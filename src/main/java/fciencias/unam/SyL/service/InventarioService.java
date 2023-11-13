package fciencias.unam.SyL.service;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fciencias.unam.SyL.entity.Inventario;
import fciencias.unam.SyL.repository.InventarioRepository;

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
