#! /usr/bin/env sh

mkdir -p $TASKDDATA
taskd init
taskd config --force log ${TASKDDATA}/log/taskd.log

# Copy tools for certificates generation and generate it
cp /usr/share/taskd/pki/generate* ${TASKDDATA}/pki
cd ${TASKDDATA}/pki
./generate
cd /

# Configure taskd to use this newly generated certificates
taskd config --force client.cert ${TASKDDATA}/pki/client.cert.pem
taskd config --force client.key ${TASKDDATA}/pki/client.key.pem
taskd config --force server.cert ${TASKDDATA}/pki/server.cert.pem
taskd config --force server.key ${TASKDDATA}/pki/server.key.pem
taskd config --force server.crl ${TASKDDATA}/pki/server.crl.pem
taskd config --force ca.cert ${TASKDDATA}/pki/ca.cert.pem

taskd config --force server 0.0.0.0:53589


# Organization and user setup
cd ${TASKDDATA}/pki
taskd add org "Familienunternehmen Lindemann"
taskd add user "Familienunternehmen Lindemann" "Benny" | awk 'FNR == 1 { print $NF }' > "${TASKDDATA}/Benny.userkey"
./generate.client "Benny"
