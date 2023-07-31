# python-template-1
Basic python template project with a build script to run tests and basic functional utility helpers

## Running your application

Type  `./build run`

Now start coding :)


## Getting started

Copy the contents of this project or fork from it. 

### Project source

The project source root start by default in the `src` directory. This can be changed by editing the `PROJECT_SOURCE` environment variable in `build.sh`
The same is true for the test directory excep that it is `tests` by default.


### Linting and Type checking

The `build.sh` uses pylama and mypy and runs both on the source and test code.

All lint and test output are saved to `target/`

### Default main and run

A default `src/main.py` file is provided as an entry point and can be run using `build.sh run`. This is purely convention and can be changed to anything or any file you like.

### Dependencies

Dependencies are in the `requirements.txt` and `requirements-dev.txt` files

### Environment varaibles and configuration

The `build.sh` supports loading environment files from and `.env` file.
This is a simple and effective way of configuring your application. 
Or as a starting point for configuration.

## Database migrations and support

Copy the `migrations.sh` file from the https://github.com/gerritjvv/dbmigration repo.
It is a simple bash script using `psql` to run migrations.

## Utility functions

The `src/utils` folder contains utility functions that are useful and written here because a whole library is too much
or because the implementations out there are not very practicle or have quirks.

## Interactive changes and development

Try: ```./build.sh interactive```

It uses https://github.com/breuleux/jurigged and starts the `interactive.py` file. 
Use this is a scratch path to expierment and run code as you develop it. 

Any changes made are automatically reloaded and visible from interactive or the python console started.

## Logging

See `log.py`, allows to use context managers to do contextual binding for function calls.

e.g

```
def do_a():
  LOGGER.info("do", a=1)


def run():
  with logger(b=2, c=3):
    do_a()
    
    with logger(d=4):
      do_a()
```
