#!/bin/bash
Red="\e[31m"
Green="\e[32m"
Default="\e[0m\n"
services="mariadb wordpress phpmyadmin nginx ftps influxdb telegraf grafana"

printf "FT_SERVICES de celeloup\n\n"
if [ $1 ] && [ $1 = "-reset" ]; then
	if [ $2 ]; then
		services=$2
		kubectl delete -f srcs/$2/$2_config.yml
		docker exec -it minikube docker rmi --force $2-img
	else
		printf "\n--- Deleting all deployment, service, persistent volume claim and docker images --- \n";
		for service in $services
		do
			printf "Deleting ${service} ... \n"
			kubectl delete -f srcs/${service}/${service}_config.yml
			docker exec -it minikube docker rmi --force ${service}-img
		done
		kubectl delete -f srcs/secrets.yml
		kubectl delete -f srcs/config_map.yml
		exit 0;
	fi
	printf "\n"
fi

if [ $OSTYPE = "linux-gnu" ]; then
	printf "\t--- Testing if docker works --- \n";
	docker ps > /dev/null
	if [[ $? == 1 ]]; then
		printf "Your docker isn't working. Attempting to fix it now .....\n"
		sudo usermod -aG docker $(whoami);
		printf "Should be fixed now. Log off and on again please.\n"
		exit 1;
	else
		printf "Docker is working !\n";
	fi
fi

# printf "\n--- Downloading Minikube ---\n"
# curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && \
# 	chmod +x minikube && \
# 	sudo install minikube /usr/local/bin/ && \
# 	rm minikube && \
# 	printf "Minikube installed\n" || { printf "Minikube installation failed\n" && exit 1; }

printf "\n\t--- Starting Minikube ---\n"
minikube delete > /dev/null
rm -rf ~/.minikube
minikube start --vm-driver=docker && \
	printf "Minikube started\n" || { printf "Minikube start failed\n" && exit 1; }

minikube addons enable metallb

kubectl apply -f srcs/secrets.yml
kubectl apply -f srcs/config_map.yml
eval $(minikube docker-env)

printf "\n\t--- Building images --\n"
for service in $services
do
	printf "Building ${service} ... "
	docker build srcs/${service} -t ${service}-img > /dev/null && \
		printf "${Green}done !${Default}" || { printf "${Red}failed ! ${Default}" && exit 1; }
done

printf "\n\t--- Services configuration --\n"
for service in $services
do
	printf "$service configuration ... "
	kubectl apply -f srcs/${service}/${service}_config.yml > /dev/null && \
	printf "${Green}applied !${Default}" || { printf "${Red}failed ! ${Default}" && exit 1; }
done

minikube dashboard