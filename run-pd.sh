#!/bin/bash

if pgrep pd > /dev/null; then
    killall pd
fi

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

pd $SCRIPT_DIR/$1/main.pd &
(
    sleep 2 &&
    
    # Tenta conectar o Minilogue (se estiver disponível)
    if minilogue-autoconnect.sh; then
        echo "Minilogue conectado com sucesso!"
    else
        echo "Minilogue não encontrado. Pulando..."
    fi

    # Tenta conectar o APC Mini (se estiver disponível)
    if apc-mini-autoconnect.sh; then
        echo "APC Mini conectado com sucesso!"
    else
        echo "APC Mini não encontrado. Pulando..."
    fi

    # Tenta conectar o NanoPad (se estiver disponível)
    if nanopad-autoconnect.sh; then
        echo "NanoPad conectado com sucesso!"
    else
        echo "NanoPad não encontrado. Pulando..."
    fi
)
