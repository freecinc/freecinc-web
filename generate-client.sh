#!/bin/sh

## based on taskd's generate.client, but simplified drastically

set -e

SECRETS=$1
DIR=$2
NAME=$3

if [ -z "${DIR}" ] || [ -z "${NAME}" ]; then
    echo "USAGE: generate-client.sh SECRETS DIR NAME"
    exit 1
fi

cd $DIR

# Take the correct binary to create the certificates
CERTTOOL=$(command -v gnutls-certtool 2>/dev/null || command -v certtool 2>/dev/null || true)
if [ -z "$CERTTOOL" ]
then
  echo "ERROR: No certtool found" >&2
  exit 1
fi

if ! [ -f ${NAME}.key.pem ]
then
  # Create a client key.
  $CERTTOOL \
    --generate-privkey \
    --sec-param High \
    --outfile ${NAME}.key.pem
fi

chmod 600 ${NAME}.key.pem

if ! [ -f ${NAME}.template ]
then
  # Sign a client cert with the key.
  cat <<EOF >${NAME}.template
organization = FreeCinc Client
cn = $NAME
expiration_days = 10000
tls_www_client
encryption_key
signing_key
EOF
fi

if ! [ -f ${NAME}.cert.pem ] || [ ${NAME}.template -nt ${NAME}.cert.pem ]
then
  $CERTTOOL \
    --generate-certificate \
    --load-privkey ${NAME}.key.pem \
    --load-ca-certificate ${SECRETS}/ca.cert.pem \
    --load-ca-privkey ${SECRETS}/ca.key.pem \
    --template ${NAME}.template \
    --outfile ${NAME}.cert.pem
fi

chmod 600 ${NAME}.cert.pem
