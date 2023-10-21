#!/bin/bash
echo "Você optou por: $1"
if [ "$1" = 'app1' ]; then
    echo "Entrando em App 1"
    docker compose -f docker-compose.yml exec -it app1-rabbitmq bash
elif [ "$1" = 'app2' ]; then 
    echo "Entrando em App 2"
    docker compose -f docker-compose.yml exec -it app2-rabbitmq bash
else 
    echo "Você pode optar por entrar em App 1 ou App 2"
    echo "Para isso basta executar esse script e passar o parametro app1 ou app2 junto ao comando"
    echo "Por padão, como não foi passado parametro, entraremos no app1"
    docker compose -f docker-compose.yml exec -it app1-rabbitmq bash
fi