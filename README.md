# Biblioteca

Aplicación web de gestión de una biblioteca que permite a los usuarios realizar préstamos de libros.
Proyecto en equipo de la asignatura FP065 *Aplicación backend con tecnología Java en servidores de aplicaciones* (UOC).

## Tecnologías

| Componente | Versión |
|---|---|
| Java (Eclipse Temurin) | 21 LTS |
| Spring Boot | 4.1.1 |
| Servidor de aplicaciones | Tomcat embebido |
| Plantillas | Thymeleaf |
| Gestión del proyecto | Maven (wrapper incluido) |
| Contenedores | Docker y Docker Compose |

## Requisitos

- **JDK 21** (Eclipse Temurin), con `JAVA_HOME` apuntando a él.
- **Git**.
- **Docker Desktop**, solo para ejecutar la aplicación en contenedor.

No hace falta instalar Maven: el proyecto incluye el wrapper (`mvnw` / `mvnw.cmd`), que descarga la versión correcta la primera vez.

### Instalar el JDK 21

**Windows** (PowerShell):

```powershell
winget install --id EclipseAdoptium.Temurin.21.JDK -e
```

**macOS** (Homebrew):

```bash
brew install --cask temurin@21
```

Comprobar la instalación en una terminal nueva:

```bash
java -version
```

Debe indicar `openjdk version "21..."` y `Temurin`.

## Obtener el código

```bash
git clone git@github.com:EricKColl/FP.449-Producto1.git
cd FP.449-Producto1
```

## Ejecutar en local

**Windows**:

```powershell
.\mvnw.cmd spring-boot:run
```

**macOS / Linux**:

```bash
./mvnw spring-boot:run
```

La aplicación queda disponible en:

- http://localhost:8080 → página de inicio
- http://localhost:8080/hola → respuesta `Hello World`

Para ejecutar los tests:

```bash
./mvnw verify          # macOS / Linux
.\mvnw.cmd verify      # Windows
```

## Ejecutar con Docker

Con Docker Desktop en marcha, el mismo comando sirve en Windows y macOS:

```bash
docker compose up -d --build
```

La primera vez compila el proyecto dentro del contenedor, por lo que tarda algo más. Después la aplicación queda disponible en http://localhost:8080.

```bash
docker ps                          # el contenedor "biblioteca" debe aparecer como healthy
docker compose logs -f             # ver los logs
docker compose down                # parar y eliminar el contenedor
```

El `Dockerfile` es multi-etapa: compila con Maven y JDK 21 y ejecuta el JAR con una imagen JRE 21 ligera, con un usuario sin privilegios y el puerto 8080 expuesto.

## Abrir el proyecto en IntelliJ IDEA

1. *File → Open* y seleccionar el fichero `pom.xml` → *Open as Project*.
2. *File → Project Structure → Project → SDK*: JDK 21 (Temurin).
3. *Settings → Editor → File Encodings*: UTF-8.
4. Ejecutar la clase `BibliotecaApplication`.

## Estructura

```
src/
├── main/
│   ├── java/edu/uoc/biblioteca/
│   │   ├── BibliotecaApplication.java   # punto de entrada
│   │   └── controller/                  # controladores MVC
│   └── resources/
│       ├── templates/                   # vistas Thymeleaf
│       ├── static/                      # CSS, imágenes, JS
│       └── application.properties
└── test/                                # tests
```

## Flujo de trabajo con Git

- `main`: versión estable. Protegida; solo recibe cambios mediante pull request revisada.
- `develop`: rama de integración. También protegida.
- `feature/<tarea>`: una rama por tarea, creada desde `develop`.

```bash
git switch develop
git pull
git switch -c feature/mi-tarea
# ... cambios ...
git add .
git commit -m "Añade ..."
git push -u origin feature/mi-tarea
```

Después se abre una pull request hacia `develop` y otro miembro del equipo la revisa antes de fusionarla.

Los fines de línea se normalizan con `.gitattributes`, de modo que el repositorio funciona igual en Windows y macOS. En Windows se recomienda `git config --global core.autocrlf true` y en macOS `git config --global core.autocrlf input`.

## Equipo

- Erick Coll Rodríguez
- Carles Miguel Millán
- Jacobo Barrera Toba
- Antonio Charneco Alcalá
