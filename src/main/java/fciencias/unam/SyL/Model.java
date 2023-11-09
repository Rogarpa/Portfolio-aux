package fciencias.unam.SyL;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@Controller
public class Model {

    @GetMapping("/Ejemplo")
    public String ejemploP(){
        return "ejemplo";
    }

    @GetMapping("/AP")
    public String agregarP(){
        return "agregarProducto";
    }
//falta el repositorio de producto y 
    //@PostMapping("/guardar")
    //public String save(@ModelAttribute Producto producto){
       // productoRepository.save(producto);
        //productoRepository.flush();
        //return "redirect:/AP"
        //}
    
}
