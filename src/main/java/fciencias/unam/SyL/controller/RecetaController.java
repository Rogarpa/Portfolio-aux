package fciencias.unam.SyL.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequestMapping("/receta")
public class RecetaController {

    @GetMapping("/receta/tinga")
    public String tinga() {
        return "receta1";
    }

    @GetMapping("/receta/lasana")
    public String lasana() {
        return "receta2";
    }
}
