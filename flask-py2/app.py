# include lib path
import sys
ROOT_DIR = sys.path[0]
sys.path.append(ROOT_DIR + '/lib/')

# import modules
from flask import Flask
app = Flask(__name__)


# set routes
@app.route('/')
def hello_world():
    return 'Hey, we have Flask in a Docker container!'

# run application
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)

