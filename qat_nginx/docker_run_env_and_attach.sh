docker run -p 8080:80 -p 4433:443 -it --rm --name docker_nginx_asynch -d --cap-add=ALL --privileged $1
docker exec -it docker_nginx_asynch /bin/bash
