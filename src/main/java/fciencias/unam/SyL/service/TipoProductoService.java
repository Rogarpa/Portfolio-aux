package fciencias.unam.SyL.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fciencias.unam.SyL.entity.TipoProducto;
import fciencias.unam.SyL.repository.TipoProductoRepository;

@Service
public class TipoProductoService {

	@Autowired
    private TipoProductoRepository repository;

    public List<TipoProducto> getTiposProducto() {
        return repository.findAll();
    }

}
