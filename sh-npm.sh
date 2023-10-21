#!/bin/bash
if [ "$1" = 'app1' -o "$1" = 'app2' ]; then
    echo "\n\e[92mIniciando Instalação do Node.js em $1\e[0m"
    docker compose -f docker-compose.yml exec -it $1-rabbitmq bash -c 'apt-get update &&
        apt-get install -y curl &&
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash &&
        source ~/.nvm/nvm.sh && nvm install node &&
        nvm use node &&
        npm install -g npm &&
        node -v && npm -v &&
        npm install && 
        npm run build'
else 
    echo "\n\e[91mVocê pode precisa informar em qual aplicação deseja instalar o node.js: App1 ou App2 \e[0m"
    echo "Para isso basta executar esse script e passar o parametro \e[93mapp1\e[0m ou \e[93mapp2\e[0m junto ao comando"
    echo "\nExemplo: \e[93msh sh-npm.sh app1\e[0m"
    echo "\nPor padão, como não foi passado parametro, não será relizado nenhuma ação."
fi