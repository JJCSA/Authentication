# JJCAuthentication - Keycloak

The keycloak server is configured in the docker-compose file. The docker-compose file contains postgres and keycloak containers.  
The `jjcsa-services` realm is configured in the [jjcsa-realm.json](jjcsa-realm.json) file.  
When docker starts the keycloak container, it loads this realm configuration.

## How to start

1. Ensure you have docker-compose installed in your machine.  
    (if not you can install it from https://docs.docker.com/compose/install/).

1. Start keycloak:
    ```commandline
    docker-compose up
    ```

1. Keycloak should start running on port 8080 and the admin console can be accessed at `http://localhost:8080/auth`.  
    Login using `admin/password`

1. Stop keycloak:
    ```commandline
    docker-compose down
    ```

## Cleanup

If you would like to reset your entire configuration for keycloak, you can clear everything and start afresh

1. Stop the containers
    ```commandline
    docker-compose down
    ```
1. Delete the images (delete the postgres and keycloak images)
    ```commandline
    docker images -f <IMAGE> (find images - docker images)
    ```

1. Delete volumes (delete the authentication_postgres_data volume)
    ```commandline
    docker volume rm authentication_postgres_data (find volumes - docker volume ls -q)
    ```

## Modify jjcsa-services realm

- If you want to modify any of the realm configuration, you can make the changes in the admin console.
- Once you make the changes in the admin console, export the realm configuration:
    ```commandline
    docker exec -it authentication_keycloak_1 /opt/jboss/keycloak/bin/standalone.sh \
        -Djboss.socket.binding.port-offset=100 -Dkeycloak.migration.action=export \
        -Dkeycloak.migration.provider=singleFile \
        -Dkeycloak.migration.realmName=jjcsa-services \
        -Dkeycloak.migration.usersExportStrategy=REALM_FILE \
        -Dkeycloak.migration.file=/tmp/my_realm.json
    ```
- This will export the realm configuration in the file `/tmp/my_realm.json`.
- Copy this file from the docker container to your machine:
    ```commandline
    docker cp <KEYCLOAK_CONTAINER_ID>:/tmp/my_realm.json ~/Desktop
    ```

## References:
- https://hub.docker.com/r/jboss/keycloak
- https://www.keycloak.org/docs/latest/server_admin/index.html#_export_import
- https://github.com/keycloak/keycloak-containers/blob/master/docker-compose-examples/keycloak-postgres.yml
