# Docker flask

### Local run
```bash
python2.7 -m pip install -r requirements.txt -t ./lib --upgrade;
python2.7 app.py;

curl -X GET http://localhost:5000/;
```

### Build
```bash
docker build -t poxstone/flask-py2 .;
```

### Run test builded
```bash
docker run --rm -dp 5000:5000 --name pox-flask-py2 poxstone/flask-py2;

# optional stop
docker stop pox-flask-py2;
```

### Upload
```bash
docker login;
docker push poxstone/flask-py2;
```

### Developing docker enviroment
```bash
docker run --rm -itp 5000:5000 --name pox-flask-py2 -v ${PWD}:/app poxstone/flask-py2;
```

