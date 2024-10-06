#!/bin/sh
# Script cortafuegos.sh para la configuración de iptables
#
# Primero borramos todas las reglas previas que puedan existir
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

# Después definimos que la politica por defecto sea ACEPTAR
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

# Para evitar errores en el sistema, debemos aceptar
# todas las comunicaciones por la interfaz lo (localhost)
iptables -A INPUT -i lo -j ACCEPT


