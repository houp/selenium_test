from flask import Flask
from test import parse


app = Flask(__name__)


@app.route('/home')
def home():
    parse()
    return 'Success'