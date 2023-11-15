package fciencias.unam.SyL.controller;

import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.validation.BindingResult;

import fciencias.unam.SyL.entity.DateRange;
import fciencias.unam.SyL.entity.Inventario;
import fciencias.unam.SyL.entity.TipoProducto;
import fciencias.unam.SyL.service.InventarioService;
import fciencias.unam.SyL.service.TipoProductoService;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/inventario")
public class InventarioController {
	
    @Autowired
    private InventarioService serviceInventario;
    
    @Autowired
    private TipoProductoService tipoProductoService;

    private final Logger logger = LogManager.getLogger(InventarioController.class);
    
    @ModelAttribute
    public void init(Model model) {
    	Inventario inventario = new Inventario();
    	inventario.setPeriodo(new DateRange());
        model.addAttribute("inventario", inventario);
    	List<TipoProducto> listaDeTiposDeProducto = tipoProductoService.getTiposProducto();
        model.addAttribute("listaDeTiposDeProducto", listaDeTiposDeProducto);
    }

    @GetMapping("/AgregarProducto")
    public String agregarP(){
        return "inventario/agregarProducto";
    }
    @GetMapping("/inventario")
    public String inventarios(Model model) {
        model.addAttribute("inventario", serviceInventario.readAll());
        return "inventario/inventario";
    }

   @PostMapping("/guardar")
    public String save(@Valid @ModelAttribute Inventario inventario, BindingResult result) {
       if (result.hasErrors()) {
            logger.info("HAY ERRORES! ");
            logger.info(result.getAllErrors());
            return "inventario/agregarProducto";

        }
        
        logger.info("*** SAVE Inventario - Controller");
        
        serviceInventario.create(inventario);
        return "redirect:/inventario/inventario";
    }

    @PostMapping("/guardarEdicion")
    public String saveEdit(@Valid @ModelAttribute Inventario inventario, BindingResult result) {
        if (result.hasErrors()) {
            logger.info("HAY ERRORES! ");
            logger.info(result.getAllErrors());
            return "inventario/editarProducto";

        }else{
        logger.info("*** UPDATE Inventario - Controller");
        serviceInventario.update(inventario);
        return "redirect:/inventario/inventario";

        }
    
    }

    @GetMapping("/editar/{id}")
    public String edit(@PathVariable Long id, Model model) {
        Inventario inventarioAEditar = serviceInventario.readByidIngrediente(id);
        
        if (inventarioAEditar != null) {
            model.addAttribute("inventario", inventarioAEditar);
            List<TipoProducto> listaDeTiposDeProducto = tipoProductoService.getTiposProducto();
            model.addAttribute("listaDeTiposDeProducto", listaDeTiposDeProducto);
            model.addAttribute("tipoProducto", inventarioAEditar.getTipoProducto());
            return "inventario/editarProducto"; 
        }
        return "redirect:/inventario/inventario"; 
        
    }

    @GetMapping("/eliminar/{id}")
    public String delete(@PathVariable Long id) {
        logger.info("*** DELETE Inventario - Controller");
        serviceInventario.deleteByIdIngrediente(id);
        return "redirect:/inventario/inventario";
    }

}
