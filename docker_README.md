Installation under Docker:

Requires host with `docker` and `docker-compose` installed, as well as a kernel with wireguard support (either >5.6 or with backports)

```shell
git clone https://github.com/ikidd/wgdashboard-dockerized
cd wgdashboard-dockerized
```  
Edit .env file to set subnet for internal Wireguard server 

```shell
docker-compose build  
docker-compose up -d
```
To update:

```shell
git pull
docker-compose build --no-cache
docker-compose up -d
```


