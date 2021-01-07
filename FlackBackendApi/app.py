import urllib
import json
# from flask.wrappers import Request
import requests

from flask import Flask, request, jsonify
# from flask_restful import API
# from .controller import MainController

app = Flask(__name__)
app.config["DEBUG"] = True

@app.route('/api', methods=["POST"])
def run():
     code = {}
     code['Query'] = str(request.args['Query'])
     with urllib.request.urlopen("https://barcode.monster/api/" + code) as url:
            data = json.loads(url.read())
       # print(data['description'])
     return data['description']
    
if __name__ == '__main__':
    app.run(debug=True)