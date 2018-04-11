#!/bin/bash

PYTHON_3_VERSION="3.6.4"
PYTHON_2_VERSION="2.7.14"

echo "FROM buildpack-deps:$(awk -F'_' '{print tolower($2)}' <<< $LINUX_VERSION)"

echo "RUN apt-get update"

echo "RUN wget https://www.python.org/ftp/python/$PYTHON_3_VERSION/Python-$PYTHON_3_VERSION.tgz && \
tar xzf Python-$PYTHON_3_VERSION.tgz && \
rm Python-$PYTHON_3_VERSION.tgz && \
cd Python-$PYTHON_3_VERSION && \
./configure && \
make install"

echo "RUN wget https://www.python.org/ftp/python/$PYTHON_2_VERSION/Python-$PYTHON_2_VERSION.tgz && \
tar xzf Python-$PYTHON_2_VERSION.tgz && \
rm Python-$PYTHON_2_VERSION.tgz && \
cd Python-$PYTHON_2_VERSION && \
./configure && \
make altinstall"

echo "RUN apt-get install -y python-dev"
echo "RUN python3 -m ensurepip --default-pip"
echo "RUN pip3 install --upgrade pip"
echo "RUN pip3 install 'tox>=3.0.0rc4' tox-battery"
