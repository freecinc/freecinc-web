#! /bin/bash

VERSION=$(git describe --always)
tar -cf docker/app.tar config-freecinc.ru freecinc.rb Gemfile Gemfile.lock helpers/ models/ public/ views/
docker build -t djmitche/freecinc-web:$VERSION --no-cache docker/
