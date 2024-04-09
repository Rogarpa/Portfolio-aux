FROM eclipse-temurin:17-jdk-focal
WORKDIR  /app
COPY ./SyL-0.0.1-SNAPSHOT.jar /app
EXPOSE 8080
ENTRYPOINT java -jar SyL-0.0.1-SNAPSHOT.jar