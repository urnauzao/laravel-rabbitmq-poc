## O que é preciso para adicionar o RabbitMQ?

No `Dockerfile` adicionar:
```Dockerfile
RUN docker-php-ext-install sockets \
    && pecl install amqp \
    && docker-php-ext-enable amqp
```


No `composer.json` adicionar:
- "php-amqplib/php-amqplib":"^3.5"


Instalar dependência
- composer update


Em config/queue.php
```php
'connections' => [
    'rabbitmq' => [
        'driver' => 'rabbitmq',
        'host' => env('RABBITMQ_HOST', 'localhost'),
        'port' => env('RABBITMQ_PORT', 5672),
        'username' => env('RABBITMQ_USERNAME', 'guest'),
        'password' => env('RABBITMQ_PASSWORD', 'guest'),
        'vhost' => env('RABBITMQ_VHOST', '/'),
    ],
    //...
```


No .env adicionar as seguintes chaves:
- obs: essas configuração devem coincidir com o que está configurado no .yml que está upando o rabbit e todo o ambiente.
```conf
RABBITMQ_HOST=rabbitmq
RABBITMQ_PORT=5672
RABBITMQ_USERNAME=guest
RABBITMQ_PASSWORD=guest
RABBITMQ_VHOST=/
```

## Comandos

- Fazer build do ambiente
```sh
sh sh-build.sh
##### ALTERNATIVAS 
# sh sh-build.sh app1
# sh sh-build.sh app2
```


- Fazer up dos containers
```sh
sh sh-up.sh
```


- Instalar ou Atualizar dependências do Composer
```sh
sh sh-vendor-update.sh
##### ALTERNATIVAS
# sh sh-vendor-update.sh app1
# sh sh-vendor-update.sh app2
```


- Instalar ou Atualizar dependências do Node.js
```sh
sh sh-npm.sh ${SERVICO}
###### OPÇÕES
# sh sh-npm.sh app1
# sh sh-npm.sh app2
```

- Permissionamento de arquivos
```sh
# 1º entre dentro do container
# execute então:
chown 1000:1000 -R ./*
```