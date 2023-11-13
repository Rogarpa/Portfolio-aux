package fciencias.unam.SyL;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@Controller
public class Model {


    @GetMapping("/AgregarProducto")
    public String agregarP(){
        return "agregarProducto";
    }
    @GetMapping("/inventario")
    public String inventarios() {
        return "inventario";
    }

   //@PostMapping("/guardar")
    //public String save(@ModelAttribute Inventario inventario){
    //    InventarioRepository.save(inventario);
    //    InventarioRepository.flush();
//
    //    this.mailSendr.sendSimpleMessage("ingrediente agregado");
    //    return "redirect:/inventario"
    //}
    
}
