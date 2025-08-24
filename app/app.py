from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello_world():
    return f'Hello from EKS cluster! This is host: {os.uname().nodename}'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
    