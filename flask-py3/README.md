# Docker flask

### Local run
```bash
python3.7 -m pip install -r requirements.txt -t ./lib --upgrade;
python3.7 app.py;

curl -X GET http://localhost:5000/;
```

### Build
```bash
docker build -t poxstone/flask-py3 .;
```

### Run test builded
```bash
docker run --rm -dp 5000:5000 --name pox-flask poxstone/flask-py3;

# optional stop
docker stop pox-flask-py3;
```

### Upload
```bash
docker login;
docker push poxstone/flask-py3;
```

### Developing docker enviroment
```bash
docker run --rm -itp 5000:5000 --name pox-flask-py3 -v ${PWD}:/app poxstone/flask-py3;
```

