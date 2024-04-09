# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update







export FLYCTL_INSTALL="/root/.fly"
  export PATH="$FLYCTL_INSTALL/bin:$PATH"
  nano ~/.bashrc

  set update channel to shell
flyctl was installed successfully to /root/.fly/bin/flyctl
Manually add the directory to your $HOME/.bash_profile (or similar)
  export FLYCTL_INSTALL="/root/.fly"
  export PATH="$FLYCTL_INSTALL/bin:$PATH"
Run '/root/.fly/bin/flyctl --help' to get started



docker run -it -p 8080:8080 -v "${PWD}":"/app" --name flyctl ubuntu /bin/bash


docker build -f Dockerfile.spring-server -t df-server .
docker run --rm -p 8080:8080  -v "${PWD}":"/app" --name df-server df-server
docker run --rm -p 8080:8080 --name df-server df-server
docker exec -it <n> /bin/bash



docker run df-server -it /bin/bash --name df-server









./mvnw  spring-boot:run \
 -Dspring-boot.run.arguments="jdbc:postgresql://aws-0-us-west-1.pooler.supabase.com:5432/postgres"
 
 ./mvnw  spring-boot:run -Dspring-boot.run.jvmArguments="\
 -Ddb.url=jdbc:postgresql://aws-0-us-west-1.pooler.supabase.com:5432/postgres"