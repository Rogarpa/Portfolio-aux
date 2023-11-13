package fciencias.unam.SyL;


import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import fciencias.unam.SyL.entity.Inventario;
import fciencias.unam.SyL.repository.InventarioRepository;
@Controller
public class HomeController {
    @Autowired
    private InventarioService service;

    @GetMapping("/AgregarProducto")
    public String agregarP(){
        return "agregarProducto";
    }
    @GetMapping("/inventario")
    public String inventarios(Model model) {
        model.addAttribute("inventario", service.getInventarios());
        return "inventario";
    }

   @PostMapping("/guardar")
    public String save(@ModelAttribute Inventario inventario){
       service.saveInventario(inventario);
    //    InventarioRepository.flush();

    //    this.mailSendr.sendSimpleMessage("ingrediente agregado");
       return "redirect:/inventario";
    }
    
}
