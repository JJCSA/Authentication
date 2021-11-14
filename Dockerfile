FROM quay.io/keycloak/keycloak:13.0.1

# ARG x=x
# ENV x ${x}

# Copy jjcsa-realm.json from current directory to working directory in image
COPY jjcsa-realm.json /tmp/jjcsa-realm.json

