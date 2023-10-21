#!/bin/bash

# Intenta escanear con la interfaz wlan0
interface="wlan0"
iwlist "$interface" scanning 2>/dev/null

# Si wlan0 no está disponible, intenta con eth0
if [ $? -ne 0 ]; then
    interface="eth0"
    iwlist "$interface" scanning 2>/dev/null
fi

# Si eth0 tampoco está disponible, intenta con lo
if [ $? -ne 0 ]; then
    interface="lo"
    iwlist "$interface" scanning 2>/dev/null
fi

# Imprime la información de las redes encontradas
echo "Información de redes encontradas en la interfaz $interface:"
iwlist "$interface" scanning | grep "ESSID\|Address\|Signal level" | sed -e 's/^[ \t]*//'
