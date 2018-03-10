## Requirements
- QAT PCIe card (not chipset) have to be installed

## Usage

``` sh
>> ./docker_run_env_and_attach.sh <image id>
docker shell >> ./init_setting.sh
```

You should be able to access nginx http server at
``` sh
HTTP: http://<host IP address>:8080
HTTPS: https://<host IP address>:4433
```


You can test OpenSSL performance with qat offloading as
``` sh
/openssl/.openssl/bin/openssl speed -engine qat -elapsed -multi 2 -async_jobs 72 rsa2048
```


## Trouble shoot
If you got fatal issue when you run openssl speed test, it should be due to `qat_service` and device driver problem.

Please try bellow in docker container
``` sh
>> systemctl stop qat_service
>> rmmod icp_qa_al
>> systemctl start qat_service
```

## Known issue
Currently user need to do bellows before starting container.
```sh
>> insmod icp_qa_al.ko
>> insmod qat_contig_mem.ko
>> ./docker_run_env_and_attach.sh <image id>
```

If you have started container before, please check whether similar modules are loaded.
```sh
>> lsmod | grep qa
```
