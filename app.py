from flask import Flask
import datetime
import os
from flask import request

app = Flask(__name__)


@app.route('/', methods=['POST'])
def index():
    content = request.json
    try:
        bucket = content['bucket']
        file_name = content['name']
        folder_list=file_name.split('/')
        if((folder_list[0].lower() == "inbound") and (folder_list[1].lower() == "work")):
            os.system('./encrypt_file.sh ' + bucket + ' ' + os.path.basename(file_name))
        elif((folder_list[0].lower() == "outbound") and (folder_list[1].lower() == "work")):
            os.system('./encrypt_file.sh ' + bucket + ' ' + os.path.basename(file_name))
    except:
        # if these fields are not in the JSON, ignore
        print("Error Ocurred")
        pass
    return "ok", 200

@app.route('/about/')
def about():
    return '<h3>This is a Cloud Run Application for OneHR Encryption/Decryption of files..</h3>'

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)
