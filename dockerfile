# Use the official lightweight Python image.
#FROM gcr.io/google.com/cloudsdktool/google-cloud-cli:latest
FROM gcr.io/google.com/cloudsdktool/google-cloud-cli:alpine

# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True

# Copy local code to the container image.
ENV APP_HOME .
WORKDIR $APP_HOME
COPY . ./

# Install production dependencies.
#RUN apt-get update && apt-get -y install curl gpg && apt-get --purge -y autoremove && apt-get clean
	
#RUN apt-get -y install gnupg && 
RUN apk --update add gnupg && apk add --no-cache python3 py3-pip && pip3 install --no-cache-dir -r requirements.txt

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
# Timeout is set to 0 to disable the timeouts of the workers to allow Cloud Run to handle instance scaling.
CMD exec gunicorn --bind :8080 --workers 1 --threads 8 --timeout 0 app:app
