# FLY PATH ADDING
export FLYCTL_INSTALL="/root/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
  nano ~/.bashrc

# Build Dockerfile
docker build -f Dockerfile.spring-server -t df-server .
# Run machine with volume
docker run --rm -p 8080:8080  -v "${PWD}":"/app" --name df-server df-server
# Run machine without volume
docker run --rm -p 8080:8080 --name df-server df-server
# Enter machine
docker exec -it df-server /bin/bash


# For adding env variables
./mvnw  spring-boot:run \
 -Dspring-boot.run.arguments="jdbc:postgresql://aws-0-us-west-1.pooler.supabase.com:5432/postgres"
 
 ./mvnw  spring-boot:run -Dspring-boot.run.jvmArguments="\
 -Ddb.url=jdbc:postgresql://aws-0-us-west-1.pooler.supabase.com:5432/postgres"
