package fciencias.unam.SyL.repository;


import org.springframework.data.jpa.repository.JpaRepository;

import fciencias.unam.SyL.entity.Inventario;

public interface InventarioRepository extends JpaRepository<Inventario, Long> {
}