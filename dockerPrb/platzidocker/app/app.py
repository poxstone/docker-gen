from flask import Flask
from redis import Redis
import os
import socket
import sys
app = Flask(__name__)
redis = Redis(host='redis', port=6379, socket_connect_timeout=5)
host = socket.gethostname()

@app.route('/')
def hello():
    redis.incr('hits')
    return '\nHello World!\nI have been seen %s times.\nMy Host name is %s\n\n' % (redis.get('hits') ,host)

if __name__ == "__main__":
    #sys.stderr.write("Hello platzi\n") Agregar para mostrar los volumes
    app.run(host="0.0.0.0", debug=True)
