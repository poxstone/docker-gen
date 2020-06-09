FROM python:3.7.2-alpine3.7
MAINTAINER poxstone

COPY . /app
WORKDIR /app
RUN pip install -r ./requirements.txt -t ./lib --upgrade

ENTRYPOINT ["python"]
CMD ["app.py"]

