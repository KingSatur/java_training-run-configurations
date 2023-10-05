#!/bin/bash

projectNames=( 
    "java_training_api_gateway" 
    "java_training_config_server"
    "java_training_book_management_bff"
    "java_training_book"
    "java_training_eureka_server"
    "java_training_rating"
)
projectTags=( 
    "api-gateway" 
    "configserver"
    "book-management-bff"
    "books"
    "eurekaserver"
    "rating"
) 
baseImageName=java_training
selectedEnviroment=dev

for i in "${!projectNames[@]}"
do
    completePath=../${projectNames[i]}
    echo $completePath
    docker build $completePath --build-arg commit=$(git --git-dir="$completePath/.git/" rev-parse HEAD) -t $baseImageName/${projectTags[i]} --progress=plain
done

docker-compose -f ./$selectedEnviroment/docker-compose.yml -env-file ./$selectedEnviroment/.env up 
