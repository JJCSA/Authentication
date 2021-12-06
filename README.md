# JJCAuthentication - Keycloak

The keycloak server is configured in the docker-compose file. The docker-compose file contains 4 containers:
1) postgres-keycloak
2) keycloak
3) postgres-backend
4) backend

The `jjcsa-services` realm is configured in the [jjcsa-realm.json](jjcsa-realm.json) file.  
When docker starts the keycloak container, it loads this realm configuration.

## How to start

1. Ensure you have docker-compose installed in your machine.  
    (If not you can install it from https://docs.docker.com/compose/install/).

2. Start Keycloak and backed together in one go
   **NOTE:** **Make sure you are in Authentication GitHub's directory as it contains required docker-compose.yaml file**:
    ```commandline
    # For now we are still testing docker-compose so please use branch `AWS-ECS` for now
    git checkout AWS-ECS
    docker-compose down && docker-compose pull && docker-compose up -d
    ```

3. Keycloak should start running on port 8080 and the admin console can be accessed at `http://localhost:8080/auth`.  
    Login using `admin/password`

4. Stop all containers:
    ```commandline
    docker-compose down
    ```

5. When you try generating a token from Keycloak using the `URL: http://localhost:8080/auth` to access backend, issue is generated token is only vaid if the requester requests the access uing `http://localhost:8080/auth`.
However this localhost URL is not accessible from inside the backend container. 
To resolve this issue we need to have a host in the `/etc/hosts` directory:

   a. FOR MAC: Get your local machine IP address using below command:
    ```
    ipconfig getifaddr en1
    ```
    
   b. Update the hosts file:
    ```commandline
    sudo vi /etc/hosts
    ```
    Add following entry:
    ```
    <Local-Machine's-IP> keycloak
    ```
    Sample should look something like this 
    ```
    192.168.1.210 keycloak
    ```

6. Now you can access 
    - Keycloak at: http://keycloak:8080/auth
    - Backend at: http://localhost:9080/actuator/health




## Cleanup <It is PENDING>

If you would like to reset your entire configuration for keycloak, you can clear everything and start fresh:

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

## Credentials
The default config will create the following users:
- User: username: user, password: user, role: USER
- Admin: username: admin, password: admin, role: ADMIN
- Super-admin: username: super-admin, password: super-admin, role: SUPER_ADMIN

## References:
- https://hub.docker.com/r/jboss/keycloak
- https://www.keycloak.org/docs/latest/server_admin/index.html#_export_import
- https://github.com/keycloak/keycloak-containers/blob/master/docker-compose-examples/keycloak-postgres.yml
