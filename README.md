# SyL

- Configurar Base de datos

Parara fines de pruebas, es posible ejecutar un servidor de base de datos utilizando docker,
por ejemplo
```
docker-compose up -d
```

También se puede utilizar cualquier otro servidor que al que se tenga acceso, solo hay que
actualizar los parámetros de conexión en el archivo application.properties.

IMPORTANTE:
Después de la primera ejecución, se debe considerar actualizar la configuración con:
`spring.sql.init.mode=never` con el fin de no regenerar la base de datos, pero esto es hasta que ya tengamos la base bien definida, antes de ser poblada

3. Ejecutar
```
./mvnw spring-boot:run
```

## Dependecias ocupadas:

// Agregadas en este commit(en el que se subio esto)
- spring-boot-starter-data-jpa
- spring-boot-starter-validation
- mysql-connector-java


### Actualizar el Proyecto despues de agregar una nueva dependencia

Una vez que haya agregado las dependencias necesarías de Java de MySQL Connector a su archivo pom.xml, debemos actualizar el proyecto para descargar la biblioteca. Puede hacerlo ejecutando el siguiente comando en la terminal.

mvn clean install
```
./mvnw clean install
```