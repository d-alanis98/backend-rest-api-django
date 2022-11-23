# Recipe API project


## Commands used to initialize the project 
### Initialize Django project
```bash
docker-compose run --rm app sh -c "django-admin startproject app ."
```

## Commands for development
### Linting
```bash
docker-compose run --rm app sh -c "flake8"
```

## Start the application
```bash
docker-compose up
```
