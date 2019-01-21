#! /bin/bash

VERSION=$(git describe --always)

# package the app up for inclusion in the image
tar -cf docker/app.tar \
    config-freecinc.ru \
    freecinc.rb \
    generate-client.sh \
    Gemfile \
    Gemfile.lock \
    helpers/ \
    models/ \
    public/ \
    views/

docker build -t djmitche/freecinc-web:$VERSION --no-cache docker/
