Installation under Docker:

Requires host with `docker` and `docker-compose` installed, as well as a kernel with wireguard support (either >5.6 or with backports)

1. `git clone <repo>`
  
2. Edit .env file to set subnet for internal Wireguard server 

3. `docker-compose build`
  
4. `docker-compose up -d`
