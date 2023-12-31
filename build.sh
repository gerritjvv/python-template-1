#!/usr/bin/env bash


# current bash script (build.sh) directory
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

PROJECT_SOURCE="$dir/src"
PROJECT_TEST_SOURCE="$dir/tests"

# check for .env file in the current directory and load export them
if [ -f "$dir/.env" ];
then
    echo "Loading variables from .env file"
    set -o allexport
    source "$dir/.env"
    set +o allexport
fi

install_reqs () {

 # install dependencies from requirements and requirements-dev

 req_file="$dir/requirements.txt"
 if [ -f "$req_file" ];
 then
   pip install -r "$req_file"
 fi

 req_dev_file="$dir/requirements-dev.txt"
 if [ -f "$req_dev_file" ];
 then
   pip install -r "$req_dev_file"
 fi

}

check_venv () {
# check if we are in a virtual environment, if not create and activate
if [ -z "$VIRTUAL_ENV" ];
then
 
 if [ -d "$dir/.venv" ];
 then
  echo "Using $dir/.venv"
 else
    echo "Creating new venv "$dir/.venv""
    python -m venv "$dir/.venv"
    pip install --upgrade pip
 fi 

 source .venv/bin/activate

 echo "Run source .venv/bin/activate in your terminal to use the same venv as this script"

fi

export PYTHONPATH="${PYTHONPATH}:${PROJECT_SOURCE}:${PROJECT_TEST_SOURCE}"

}


run_jurigged () {
 
  echo "Running jurigged with interactive.py, changes made to this script or any modules it refers to will be auto reloaded"
  python -m jurigged -i interactive.py

}


check_venv

CMD="$1"
shift


case $CMD in
  run )
    (cd $PROJECT_SOURCE && python -m main)
    ;;
  lint)
    if [ -c command pylama &> /dev/null ]; 
    then 
        echo "Install dev commands"
        install_reqs
    fi

    mkdir -p "$dir/target"
    set -e
    # adapt and change the project source and test source, and also the ignores
    pylama -i E501,C901,W291,C231,E131,E722,E124,E125,E501,W293,E203 "$PROJECT_SOURCE" "$PROJECT_TEST_SOURCE"  | tee "$dir/target/pylama.log"
    mypy "$PROJECT_SOURCE" "$PROJECT_TEST_SOURCE"  | tee "$dir/target/mypy.log"
    ;;
   test )
    mkdir -p "$dir/target"
    pytest --capture=no --fixtures-per-test --exitfirst "$PROJECT_TEST_SOURCE" | tee "$dir/target/tests.log"
    ;;
   install )
    install_reqs
    ;;
   interactive )
     run_jurigged
     ;;
  dev)
   echo "Add development code here"
    ;;
  *)
    echo "Command $CMD not supported"
    ;;
esac;