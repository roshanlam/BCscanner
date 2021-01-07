import pandas as pd
import urllib
import json 
import requests

class MainController():
    def get(self, code):
        code = "8888002076009"
        with urllib.request.urlopen("https://barcode.monster/api/" + code) as url:
            data = json.loads(url.read())
       # print(data['description'])
        return data['description']
