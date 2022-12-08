from flask import Flask
import datetime
import os
from flask import request

app = Flask(__name__)


@app.route('/', methods=['POST'])
def index():
    bucket = request.headers.get('ce-subject')
    source = request.headers.get('ce-source')
    print('Bucket - '+bucket)
    print('Source - '+source)
    print(os.system('gpg'))
    print(os.system('./encrypt_file.sh'))
    return 'Working.'
    


#return '<h1>Playing with a Flask Application 123 using Cloud Build at '+ str(datetime.datetime.now()) +'!</h1>'


@app.route('/about/')
def about():
    return '<h3>This is a Flask web application.</h3>'

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)
