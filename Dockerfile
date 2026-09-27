# Etapa 1: compilación con Maven y JDK 21
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app

# Se descargan primero las dependencias para aprovechar la caché de capas
COPY pom.xml .
RUN mvn -B -q dependency:go-offline

COPY src ./src
RUN mvn -B -q package -DskipTests

# Etapa 2: ejecución con una JRE 21 ligera
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

RUN addgroup -S biblioteca && adduser -S biblioteca -G biblioteca
COPY --from=build --chown=biblioteca:biblioteca /app/target/*.jar app.jar
USER biblioteca

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=20s --retries=3 \
    CMD wget -qO- http://localhost:8080/hola || exit 1

ENTRYPOINT ["java", "-jar", "app.jar"]
