# Signal in Docker



## About <a name = "about"></a>

This repository builds a container that runs Signal for desktop.

In case you don't want to build it by yourself, you can get pull the container from [this dockerhub repository](https://hub.docker.com/repository/docker/eindemwort/sigindock), from your command line:
```
docker pull eindemwort/sigindock
```

### Building and installing

This docker container was built using Docker version:
```
Docker version 18.03.1-ce, build 9ee9f40
```

Run the `build_sigindock.sh` script and it will build the container.<br>
Run the `signal.sh` script and it will launch the container with all the necessary parameters.

I recommend copying the script `signal.sh` to a location in your `PATH` variable, for instance, I copied it to `/usr/bin`.

