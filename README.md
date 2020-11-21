# JJCAuthentication

This repository is the keycloak server repository used for the authentication and authorization. While working on JJCSA backend service make sure to use this keycloak server since it has all the configurations required for authentication and authorization. 

## Contributing:

For steps on how you can contribute, please follow the [Contributing guide](https://github.com/JJCSA/backend/blob/developer/CONTRIBUTING.md)

### Steps to start the server
1. To start the server clone this repository into your machine
2. Make sure you have a postgres instance running with `keycloak` database created
3. Navigate to keycloak/bin and run ./standalone.sh command
4. Once the server starts without any issues navigate to http://localhost:8080/auth. To login use credentials mentioned below 
````
username: admin
password: password
````

This will take you to the Keycloak UI and you can take a look at the users and session details there.
