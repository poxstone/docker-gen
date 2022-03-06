# Personalized SDK DOCKER image
| *Note*: [GCP images Documentation](https://cloud.google.com/sdk/docs/downloads-docker)
* Docker 

## Build
```bash
docker build . -t gcloud-sdk;
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
  gcloud-sdk bash;
```

## GCLOUD auth
```bash
gcloud auth login;
```