# Getting Started

# Docker para la base de datos:

La idea es que con docker puedes utilizar imágenes para ejecutar servicios típicos (por ejemplo un manejador de bases de datos, como MySQL. docker-compose es simplemente una forma estándar de declarar esos servicios (sería similar al pom.xml de un proyecto de java).

Spring tiene algunas herramientas/dependencias (como Hibernate) que te permiten poder generar todo el esquema de la base de datos (eso se puede configurar en el properties). De esta forma, de momento seguiremos esta forma de trabajo:

- Crear las entidades (POJO's, entities, models, etc) en Java, 
- Levantar un servidor de base de datos (de manera local, o utilizando docker) y crear una base de datos vacía (solo con el CREATE DATABASE)
	- Para eso ocupamos el docker-compose
```
ntory@flavor:~/Escritorio/CC/20241/Technologies-for-internet-dev/SyL$ docker-compose up -d
[+] Building 0.0s (0/0)                                                                                                                
[+] Running 1/0
 ✔ Container syl-postgres-1  Running
```
	- para verificar que se ha creado ejecutamos:
```
ntory@flavor:~/Escritorio/CC/20241/Technologies-for-internet-dev/SyL$ docker ps
CONTAINER ID   IMAGE                COMMAND                  CREATED        STATUS          PORTS                                         NAMES
ebc8ed7b2193   postgres:14-alpine   "docker-entrypoint.s…"   13 hours ago   Up 22 minutes   0.0.0.0:32123->5432/tcp, :::32123->5432/tcp   syl-postgres-1

```
- ESTO debe cambiarse por las instrucciones para postgrest, ME AYUDAN CON ESTO?
	- Para conectarse a nuestro contenedor
		- sudo docker exec -it syl-mysql-1 bash
- to postgrest:
	- psql -h localhost -U main -d SyL -p 32123
	- \l 
	- \c SyL
	- \dt
	\d+ nombre_de_tabla
	
- toMysql:
	- mysql -u root -p
		- entrar como root
	- show databases;
	- use SyLDB;

- De a cuerdo a nuestro properties hemos configurado spring para que genere el esquema de la base de datos al iniciar la aplicación.

### versiones ocupadas
ntory@flavor:~/Escritorio/CC/20241/Technologies-for-internet-dev/SyL$ docker-compose --version
Docker Compose version v2.18.1
ntory@flavor:~/Escritorio/CC/20241/Technologies-for-internet-dev/SyL$ docker --version
Docker version 24.0.7, build afdd53b

### Reference Documentation
For further reference, please consider the following sections:

* [Official Apache Maven documentation](https://maven.apache.org/guides/index.html)
* [Spring Boot Maven Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/3.1.5/maven-plugin/reference/html/)
* [Create an OCI image](https://docs.spring.io/spring-boot/docs/3.1.5/maven-plugin/reference/html/#build-image)
* [Thymeleaf](https://docs.spring.io/spring-boot/docs/3.1.5/reference/htmlsingle/index.html#web.servlet.spring-mvc.template-engines)
* [Spring Web](https://docs.spring.io/spring-boot/docs/3.1.5/reference/htmlsingle/index.html#web)
* [Spring Boot DevTools](https://docs.spring.io/spring-boot/docs/3.1.5/reference/htmlsingle/index.html#using.devtools)

### Guides
The following guides illustrate how to use some features concretely:

* [Handling Form Submission](https://spring.io/guides/gs/handling-form-submission/)
* [Building a RESTful Web Service](https://spring.io/guides/gs/rest-service/)
* [Serving Web Content with Spring MVC](https://spring.io/guides/gs/serving-web-content/)
* [Building REST services with Spring](https://spring.io/guides/tutorials/rest/)

