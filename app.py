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
        bucket = content['bucket']
        file_name = content['name']
        folder_list=file_name.split('/')

        if(trim(lower(folder_list[0]))=="inbound" and folder_list[1] == "work"):
            os.system('./encrypt_file.sh ' + bucket + ' ' + os.path.basename(file_name))
        elif(trim(lower(folder_list[0]))=="outbound" and folder_list[1] == "work"):
            os.system('./encrypt_file.sh ' + bucket + ' ' + os.path.basename(file_name))

    except:
        # if these fields are not in the JSON, ignore
        print("Error Ocurred")
        pass
    return "ok", 200
    


#return '<h1>Playing with a Flask Application 123 using Cloud Build at '+ str(datetime.datetime.now()) +'!</h1>'


@app.route('/about/')
def about():
    return '<h3>This is a Flask web application.</h3>'

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)
