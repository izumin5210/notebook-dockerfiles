#!/usr/bin/env bash
set -e

# https://hub.docker.com/r/jupyter/notebook/~/dockerfile/

# Python binary and source dependencies
apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        git \
        libcurl4-openssl-dev \
        libffi-dev \
        libsqlite3-dev \
        libzmq3-dev \
        pandoc \
        python \
        python3 \
        python-dev \
        python3-dev \
        sqlite3 \
        texlive-fonts-recommended \
        texlive-latex-base \
        texlive-latex-extra \
        zlib1g-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Tini
curl -L https://github.com/krallin/tini/releases/download/v0.6.0/tini > tini && \
    echo "d5ed732199c36a1189320e6c4859f0169e950692f451c03e7854243b95f4234b *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

# Install the recent pip release
curl -O https://bootstrap.pypa.io/get-pip.py && \
    python2 get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py && \
    pip2 --no-cache-dir install requests[security] && \
    pip3 --no-cache-dir install requests[security]

# Install some dependencies.
pip2 --no-cache-dir install ipykernel && \
    pip3 --no-cache-dir install ipykernel && \
    \
    python2 -m ipykernel.kernelspec && \
    python3 -m ipykernel.kernelspec

# Move notebook contents into place.
# ADD . /usr/src/jupyter-notebook
git clone https://github.com/jupyter/notebook.git && \
    mv notebook /usr/src/jupyter-notebook

# Install dependencies and run tests.
BUILD_DEPS="nodejs-legacy npm" && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq $BUILD_DEPS && \
    \
    pip3 install --no-cache-dir --pre -e /usr/src/jupyter-notebook && \
    \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge -y --auto-remove \
        -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $BUILD_DEPS

# Run tests.
pip2 install --no-cache-dir mock nose requests testpath && \
    pip3 install --no-cache-dir nose requests testpath && \
    \
    iptest2 && iptest3 && \
    \
    pip2 uninstall -y funcsigs mock nose pbr requests six testpath && \
    pip3 uninstall -y nose requests testpath

# Add a notebook profile.
mkdir -p -m 700 /root/.jupyter/ && \
    echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py
