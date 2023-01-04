# Use the official lightweight Python image.
FROM gcr.io/google.com/cloudsdktool/google-cloud-cli:alpine

# Copy local code to the container image.
ENV APP_HOME .
WORKDIR $APP_HOME
COPY . ./

# Install production dependencies.
RUN apk update && apk add --no-cache jq && apk add --no-cache python3 py3-pip && apt-get --purge -y autoremove && apt-get clean && pip3 install --no-cache-dir -r requirements.txt

# Run the service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
# Timeout is set to 0 to disable the timeouts of the workers to allow Cloud Run to handle instance scaling.
CMD exec gunicorn --bind :8080 --workers 1 --threads 8 --timeout 0 app:app
