FROM ubuntu:16.04
MAINTAINER poxstone

RUN apt-get update -y && \
    apt-get install -y python-pip python-pip python-dev

COPY ./requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r ./requirements.txt -t ./lib --upgrade

COPY . /app

ENTRYPOINT ["python"]
CMD ["app.py"]

