#!/bin/bash	
# Configuration

. ./config.sh

echo "	--> Log into openshift"
oc login ${OPENSHIFT_PRIMARY_MASTER}:8443 --username=${OPENSHIFT_PRIMARY_USER} --password=${OPENSHIFT_PRIMARY_USER_PASSWORD} --insecure-skip-tls-verify=false
echo "	--> Switch to project"
oc project ${OPENSHIFT_PRIMARY_PROJECT}
echo "	--> delete all openshift resources"
oc delete all -l app=fuse-amq
oc delete secret amq-app-secret
oc delete sa/amq-service-account
oc delete project ${OPENSHIFT_PRIMARY_PROJECT}
echo "	--> delete all keystores and certs"
rm amq-server_cert
rm amq-server.ks
rm amq-server.ts
rm amq-client_cert
rm amq-client.ks
rm amq-client.ts
echo "	--> Delete camel artifacts"
rm camel-context-fragment.xml
echo "	--> You may choose to delete the eclipse project"
echo "Done"
