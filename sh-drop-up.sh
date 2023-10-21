#!/bin/bash
# Derruba tudo
sh sh-down.sh 

# Inicializa a variável de controle
i=0

# Inicia o loop
while [ $i -lt 15 ]; do
    # Exibe um ponto
    echo -n "....."
    
    # Incrementa a variável de controle
    i=$((i + 1))
    
    # Espera o intervalo antes de exibir o próximo ponto
    sleep "0.3"
done

# Quebra de linha no final
echo

# Sobe tudo
sh sh-up.sh