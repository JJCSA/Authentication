# -------------------------- #






# -------- docker system -------- #
docker system df
docker system prune --all
docker system prune --volumes 



docker stop frontend && docker rm frontend
docker stop backend && docker rm backend
docker stop keycloak && docker rm keycloak
docker stop postgres && docker rm postgres

# -------- AWS Authentication Build + Push --------

aws ecr get-login-password --profile jjcsaDD --region us-east-2 | docker login --username AWS --password-stdin 247935169035.dkr.ecr.us-east-2.amazonaws.com
docker build -t jjcsa-frontend:latest --build-arg npm_config_loglevel=error .

docker tag jjcsa-frontend:latest 247935169035.dkr.ecr.us-east-2.amazonaws.com/jjcsa-frontend:latest
docker push 247935169035.dkr.ecr.us-east-2.amazonaws.com/jjcsa-frontend:latest

docker tag jjcsa-frontend:latest 247935169035.dkr.ecr.us-east-2.amazonaws.com/jjcsa-frontend:b756874
docker push 247935169035.dkr.ecr.us-east-2.amazonaws.com/jjcsa-frontend:b756874



## JJCSA-Stage
aws ecr get-login-password --profile jjcsaStageDD --region us-east-2 | docker login --username AWS --password-stdin 477908470333.dkr.ecr.us-east-2.amazonaws.com
docker build -t jjcsa-keycloak:latest .

docker tag jjcsa-keycloak:latest 477908470333.dkr.ecr.us-east-2.amazonaws.com/jjcsa-keycloak:aws-cfn-jjcsa
docker push 477908470333.dkr.ecr.us-east-2.amazonaws.com/jjcsa-keycloak:aws-cfn-jjcsa

docker tag jjcsa-keycloak:latest 477908470333.dkr.ecr.us-east-2.amazonaws.com/jjcsa-keycloak:bb2fa07
docker push 477908470333.dkr.ecr.us-east-2.amazonaws.com/jjcsa-keycloak:bb2fa07

docker tag jjcsa-keycloak:latest 477908470333.dkr.ecr.us-east-2.amazonaws.com/jjcsa-keycloak:stable
docker push 477908470333.dkr.ecr.us-east-2.amazonaws.com/jjcsa-keycloak:stable

docker tag jjcsa-keycloak:latest 477908470333.dkr.ecr.us-east-2.amazonaws.com/jjcsa-keycloak:latest
docker push 477908470333.dkr.ecr.us-east-2.amazonaws.com/jjcsa-keycloak:latest
