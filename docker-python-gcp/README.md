# Personalized SDK DOCKER image
| *Note*: [GCP images Documentation](https://cloud.google.com/sdk/docs/downloads-docker)
* Docker 

## Build
```bash
docker build . -t docker.io/poxstone/gcloud-sdk;
```

## Run
```bash
docker run -it --rm \
  --net host \
  -u "$(id -u):$(id -g)" \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -v $HOME/.gitconfig:/home/cloudsdk/.gitconfig \
  -v $HOME/.ssh:/home/cloudsdk/.ssh/ \
  -v $HOME/.config/gcloud:/home/cloudsdk/.config/gcloud \
  -v $(pwd):/home/cloudsdk/project/ \
  docker.io/poxstone/gcloud-sdk bash;
```

## GCLOUD auth
```bash
gcloud auth login;
```

## GCloud Run

```bash
docker run -it --rm   --net host   -u "$(id -u):$(id -g)"   -e PUID=$(id -u)   -e PGID=$(id -g)   -v $HOME/.gitconfig:/home/cloudsdk/.gitconfig   -v $HOME/.config/gcloud:/home/cloudsdk/.config/gcloud   -v $(pwd):/home/cloudsdk/project/   docker.io/poxstone/gcloud-sdk bash;
```
