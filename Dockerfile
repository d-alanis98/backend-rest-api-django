FROM python:3.9-alpine3.13

LABEL maintainer="d-alanis98.github.io"

# Recommended for containerized Python applications
ENV PYTHONUNBUFFERED 1

# Copies requirements.txt to the /tmp path of the container
COPY ./requirements.txt /tmp/requirements.txt
# Copies the app folder to the /app path of the container
COPY ./app /app
# Sets the working directory of the container, so that the commands will be run from this path
WORKDIR /app
# Allows to access this port on the container
EXPOSE 8000

# Creates virtual environment, upgrades pip, install the requirements, delete the /tmp folder, creates the django-user
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \ 
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# Updates the environment variable inside the container
ENV PATH="/py/bin:$PATH"

# Specifies the user the image will switch to
USER django-user