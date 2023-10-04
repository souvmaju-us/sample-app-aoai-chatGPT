#!/bin/bash

echo ""
echo "Creating Python Virtual Environment"
echo ""
python -m venv .venv
if [ $? -ne 0 ]; then
    echo "Failed craete virtualenv"
    exit $?
fi
source .venv/bin/activate
if [ $? -ne 0 ]; then
    echo "Failed to activate virtualenv"
    # exit $?
fi

# python -m pip install -r requirements.txt
# if [ $? -ne 0 ]; then
#     echo "Failed to install required packages"
#     exit $?
# fi


echo ""
echo "Restoring frontend npm packages"
echo ""
cd frontend
npm install
if [ $? -ne 0 ]; then
    echo "Failed to restore frontend npm packages"
    # exit $?
fi

echo ""
echo "Building frontend"
echo ""
npm run build
if [ $? -ne 0 ]; then
    echo "Failed to build frontend"
    # exit $?
fi

cd ..
. ./scripts/loadenv.sh

echo ""
echo "Starting backend"
echo ""
./.venv/bin/python -m flask run --port=5000 --host=127.0.0.1 --reload --debug
if [ $? -ne 0 ]; then
    echo "Failed to start backend"
    # exit $?
fi
