#!/bin/bash
echo "Você optou por: $1"
if [ "$1" = 'app1' ]; then
    echo "Reiniciando em App 1"
    docker compose -f docker-compose.yml restart app1-rabbitmq
elif [ "$1" = 'app2' ]; then 
    echo "Reiniciando em App 2"
    docker compose -f docker-compose.yml restart app2-rabbitmq
else 
    echo "Você pode optar por entrar em App 1 ou App 2"
    echo "Para isso basta executar esse script e passar o parametro app1 ou app2 junto ao comando"
    echo "Por padão, como não foi passado parametro, reiniciaremos tudo"
    docker compose -f docker-compose.yml restart
fi