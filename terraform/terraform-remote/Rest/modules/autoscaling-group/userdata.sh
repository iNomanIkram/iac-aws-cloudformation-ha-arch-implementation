#!/bin/bash
export DB_HOST="${privateip}"
add-apt-repository ppa:deadsnakes/ppa -y
apt update -y
git clone https://github.com/iNomanIkram/demo_flask_mariadb
apt update
apt install python3.9 -y
cd demo_flask_mariadb
apt-get install python3.9-venv -y
python3.9 -m venv venv
curl  https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py
python3.9 get-pip.py
source venv/bin/activate
python3.9 -m pip install --upgrade pip
pip install flask flask-restful mysql-connector-python
python3.9 app.py