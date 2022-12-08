from flask import Flask
import datetime
import os
from flask import request

app = Flask(__name__)


@app.route('/', methods=['POST'])
def index():
    content = request.json
    try:
        #print(content)
        proj = content['bucket']
        file_name = content['name']
        dictionary='{"event_bucket:"'+'"' + content['bucket'] +'",' +'"event_file_name:"'+ '"' + content['name']+'"}'
        with open("event_info.json", "w") as outfile:
            json.dump(dictionary, outfile)
        print('Bucket Name - ' + proj)
        print('File Name -' + file_name)
        #print(os.system('gpg'))
        print(os.system('./encrypt_file.sh'))
    except:
        # if these fields are not in the JSON, ignore
        pass
    return "ok", 200
    


#return '<h1>Playing with a Flask Application 123 using Cloud Build at '+ str(datetime.datetime.now()) +'!</h1>'


@app.route('/about/')
def about():
    return '<h3>This is a Flask web application.</h3>'

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)
