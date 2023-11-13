package fciencias.unam.SyL;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fciencias.unam.SyL.repository.InventarioRepository;
import fciencias.unam.SyL.entity.Inventario;

import java.util.List;
@Service
public class InventarioService {
	@Autowired
    private InventarioRepository repository;

    public List<Inventario> getInventarios() {
        return repository.findAll();
    }

    public Inventario saveInventario(Inventario inventario) {
        return repository.save(inventario);
    }

}
