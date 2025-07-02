#!/bin/bash

set -e

DIRECTORY=/root/platon-node
DATADIR=${DIRECTORY}/data

if [[ "$(ls -A $DATADIR)" ]]; then
    echo "skip init platon node..."
else
    echo "start init platon node..."
    mkdir -p ${DIRECTORY}/data && /usr/bin/platonkey genkeypair | tee >(grep "PrivateKey" | awk '{print $2}' >/root/platon-node/data/nodekey) >(grep "PublicKey" | awk '{print $3}' >/root/platon-node/data/nodeid)
    mkdir -p ${DIRECTORY}/data && /usr/bin/platonkey genblskeypair | tee >(grep "PrivateKey" | awk '{print $2}' >/root/platon-node/data/blskey) >(grep "PublicKey" | awk '{print $3}' >/root/platon-node/data/blspub)
fi

exec /usr/bin/platon \
    --identity platon \
    --datadir ${DIRECTORY}/data \
    --port 16789 \
    --http.addr "0.0.0.0" \
    --http.port 6789 \
    --http.api "platon,net,web3,admin,personal" \
    --http \
    --nodekey ${DIRECTORY}/data/nodekey \
    --cbft.blskey ${DIRECTORY}/data/blskey \
    --verbosity 1 \
    --syncmode "fast" \
    --metrics \
    --metrics.addr 0.0.0.0 \
    --metrics.port 6060