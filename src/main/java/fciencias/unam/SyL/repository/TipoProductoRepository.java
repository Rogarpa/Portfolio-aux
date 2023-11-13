package fciencias.unam.SyL.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import fciencias.unam.SyL.entity.TipoProducto;

public interface TipoProductoRepository extends JpaRepository<TipoProducto, Long> {
    // Métodos personalizados si son necesarios
}
