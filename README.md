# SyL

- Configurar Base de datos

Parara fines de pruebas, es posible ejecutar un servidor de base de datos utilizando docker,
por ejemplo
```
docker-compose up -d
```

También se puede utilizar cualquier otro servidor que al que se tenga acceso, solo hay que
actualizar los parámetros de conexión en el archivo application.properties.

La creación de la base de datos es manejada por JPA, por lo que la creación de las tablas y vaciado es automático.  

3. Ejecutar
```
./mvnw spring-boot:run
```

## Dependecias usadas:

- spring-boot-starter-data-jpa
- spring-boot-starter-validation
- mysql-connector-java
- spring-boot-starter-parent
- spring-boot-starter-thymeleaf
- thymeleaf-layout-dialect
- spring-boot-starter-web
- spring-boot-devtools
- spring-boot-starter-test
- lombok
- spring-boot-starter-data-jpa
- postgresql
- spring-boot-starter-validation
- spring-boot-maven-plugin
- maven-compiler-plugin


### Actualizar el Proyecto despues de agregar una nueva dependencia

Una vez que haya agregado las dependencias necesarías de Java de MySQL Connector a su archivo pom.xml, debemos actualizar el proyecto para descargar la biblioteca. Puede hacerlo ejecutando el siguiente comando en la terminal.

mvn clean install
```
./mvnw clean install
```