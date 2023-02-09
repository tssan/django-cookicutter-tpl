#!/bin/bash

set -o errexit

function print_help() {
    help="Run script - help:\n"
    help+="./run.sh [action]\n\n"
    help+="actions:\n"
    help+="init          -   install venv\n"
    help+="clean         -   remove venv\n"
    help+="venv <cmd>    -   run command in venv\n"
    help+="dj <cmd>      -   run django command\n"
    help+="run           -   run app in development mode\n"
    help+="test          -   run tests\n"

    echo -e "$help"
}

if [[ $# -eq 0 ]] ; then
    print_help
    exit 0
fi

action=$1

shift 1

source .env
export PYTHONPATH=$PYTHONPATH

if [ -d "$VENV_PATH" ]; then
    source $VENV_PATH/bin/activate
fi

case "$action" in
    init)
        $PYTHON_EXC -m venv $VENV_PATH
        source $VENV_PATH/bin/activate
        pip install --upgrade pip
        pip install -r requirements.txt
    ;;
    clean)
        rm -rf $VENV_PATH
        find . -name "*.pyc" -exec rm -rf {} \; -prune -print
        find . -name "__pycache__" -exec rm -rf {} \; -prune -print
        rm *.log
    ;;
    venv)
        $@
    ;;
    test)
        pytest $@
    ;;
    run)
        python $PROJECT_PATH/manage.py runserver $DEV_HOST:$DEV_PORT
    ;;
    dj)
        python $PROJECT_PATH/manage.py $@
    ;;
    *)
        print_help
    ;;
esac
