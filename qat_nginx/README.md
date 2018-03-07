## usage

``` sh
>> ./docker_run_daemon.sh <image id>
<container id>

>> ./docker_exec.sh <container id>

docker shell >> ./insmod.sh
```

You should be able to access nginx http server at
``` sh
HTTP: http://<host IP address>:8080
HTTPS: https://<host IP address>:8433
```


You can test OpenSSL performance with qat offloading as
``` sh
/openssl/.openssl/bin/openssl speed -engine qat -elapsed -multi 2 -async_jobs 72 rsa2048
```
