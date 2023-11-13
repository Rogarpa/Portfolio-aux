package fciencias.unam.SyL.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
/**
 * Clase que nos permite representar un INVENTARIO de SyL,
 * es decir una lista de productos o ingredientes.
 */
@Entity
@Table(name="usuario")
public class Usuario{
	
	@Id
    @Column(name = "idUsuario", unique=true)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @NotNull(message="El ID del usuario es requerido")
    private int idUsuario;
    
    @Column(name = "nombre")
    @NotNull(message="El nombre es requerido")
    private String nombre;
    
    @Column(name = "apellidoMaterno")
    @NotNull(message="El apellido materno es requerido")
    private String apellidoMaterno;
    
    @Column(name = "apellidoPaterno")
    @NotNull(message="El apellido paterno es requerido")
    private String apellidoPaterno;
    
    @Column(name = "telefono")
    @NotNull(message="El teléfono es requerido")
    private int telefono;
    
    @Column(name = "correo")
    @NotNull(message="El correo es requerido")
    private String correo;
    
    @Column(name = "contrasena")
    @NotNull(message="La contraseña es requerida")
    private String contrasena;
    
}
