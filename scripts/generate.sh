#!/bin/bash

PYTHON_3_VERSION="3.6.4"
PYTHON_2_VERSION="2.7.14"

echo "FROM buildpack-deps:$(awk -F'_' '{print tolower($2)}' <<< $LINUX_VERSION)"

RUN apt-get update

echo "RUN wget https://www.python.org/ftp/python/$PYTHON_3_VERSION/Python-$PYTHON_3_VERSION.tgz && \
tar xzf Python-$PYTHON_3_VERSION.tgz && \
rm Python-$PYTHON_3_VERSION.tgz && \
cd Python-$PYTHON_3_VERSION && \
./configure && \
make altinstall"

echo "RUN wget https://www.python.org/ftp/python/$PYTHON_2_VERSION/Python-$PYTHON_2_VERSION.tgz && \
tar xzf Python-$PYTHON_2_VERSION.tgz && \
rm Python-$PYTHON_2_VERSION.tgz && \
cd Python-$PYTHON_2_VERSION && \
./configure && \
make altinstall"

# install lsb-release, etc., for testing linux distro
echo "RUN apt-get update && apt-get -y install lsb-release unzip"

echo "RUN apt-get install -y python-dev"
echo "RUN pip install --user 'tox>=3.0.0rc4' tox-battery"

# install bats for testing
echo "RUN git clone https://github.com/sstephenson/bats.git \
  && cd bats \
  && ./install.sh /usr/local \
  && cd .. \
  && rm -rf bats"

# install dependencies for tap-to-junit
echo "RUN perl -MCPAN -e 'install TAP::Parser'"
echo "RUN perl -MCPAN -e 'install XML::Generator'"
