#!/bin/bash
echo "Você optou por: $1"
if [ "$1" = 'app1' ]; then
    echo "Atualizando a vendor do App 1"
    docker compose -f docker-compose.yml exec -it app1-rabbitmq composer update
elif [ "$1" = 'app2' ]; then 
    echo "Atualizando a vendor do App 2"
    docker compose -f docker-compose.yml exec -it app2-rabbitmq composer update
else 
    echo "Você pode optar por entrar em App 1 ou App 2"
    echo "Para isso basta executar esse script e passar o parametro app1 ou app2 junto ao comando"
    echo "Você deve informar em qual app deseja atualizar o composer para continuar."
fi