package edu.uoc.biblioteca.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class InicioController {

    @GetMapping("/")
    public String inicio(Model model) {
        model.addAttribute("titulo", "Biblioteca");
        model.addAttribute("mensaje", "Gestión de préstamos de libros");
        return "index";
    }

    @GetMapping("/hola")
    @ResponseBody
    public String holaMundo() {
        return "Hello World";
    }
}
