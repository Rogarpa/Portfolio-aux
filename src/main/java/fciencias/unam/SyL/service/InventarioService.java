package fciencias.unam.SyL.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fciencias.unam.SyL.repository.InventarioRepository;

@Service
public class InventarioService {
	@Autowired
    private InventarioRepository repository;


}
