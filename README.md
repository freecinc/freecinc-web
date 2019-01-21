# FreeCinc

Setting up your own [TaskServer](http://taskwarrior.org/docs/taskserver/why.html) takes some effort. By running freecinc on the same server as your TaskServer, you allow others access to sync with your TaskServer. Like sharing is caring. Like free beer. Like love and a handshake.

## Live on the Web

This repository defines the FreeCinc web server.
It is a Sinatra (Ruby) application originally developed by Jack Desert.

The production FreeCinc is live on the web at [FreeCinc.com](https://freecinc.com)

## Building the Image

Run `./build.sh` to build the docker image used to deploy this service.

### Configuration

The web application expects its configuration in the form of environment variables:

 * `HOSTNAME` -- hostname on which this service runs
 * `TASKDATA` -- the directory containing taskd's data
 * `PKI_DIR` -- the directory containing client certificates and keys
 * `SECRETS_DIR` -- the directory containing server and ca certificates and keys
 * `SALT` -- a secret value used to generate passwords from usernames

## Running tests

    bundle exec rspec

## LICENSE

MIT License. See LICENSE in this repo.
