FROM python:3.9-alpine3.13

LABEL maintainer="d-alanis98.github.io"

# Recommended for containerized Python applications
ENV PYTHONUNBUFFERED 1

# Copies requirements.txt to the /tmp path of the container
COPY ./requirements.txt /tmp/requirements.txt
# Copies the development requirements 
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
# Copies the app folder to the /app path of the container
COPY ./app /app
# Sets the working directory of the container, so that the commands will be run from this path
WORKDIR /app
# Allows to access this port on the container
EXPOSE 8000

# Sets an argument with a default value of false. This can be overriden by the args defined in docker-compose file
ARG DEV=false
# Creates virtual environment
RUN python -m venv /py && \
    # Upgrades pip
    /py/bin/pip install --upgrade pip && \
    # Installs the requirements
    /py/bin/pip install -r /tmp/requirements.txt && \
    # Only installs the dev dependencies if argument DEV is true
    if [ $DEV == "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ;\
    fi && \
    # Deletes the /tmp folder
    rm -rf /tmp && \ 
    # Creates the django-user with no password and without creating a home directory for this user
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# Updates the environment variable inside the container
ENV PATH="/py/bin:$PATH"

# Specifies the user the image will switch to
USER django-user