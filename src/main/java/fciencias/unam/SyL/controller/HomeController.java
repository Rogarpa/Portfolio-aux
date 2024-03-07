package fciencias.unam.SyL.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequestMapping("/")
public class HomeController {
	
    @GetMapping("/")
    public String home() {
        return "menu";
    }
    @GetMapping("/index")
    public String index() {
        return "menu";
    }

    @GetMapping("/tinga")
    public String tinga() {
        return "./receta/receta1";
    }

    @GetMapping("/lasana")
    public String lasana() {
        return "./receta/receta2";
    }
}
