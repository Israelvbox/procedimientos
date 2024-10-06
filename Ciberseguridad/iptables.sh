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

# Añadir una regla a la cadena INPUT para aceptar todos los paquetes que 
# se originan desde la dirección 192.168.18.155

iptables -A INPUT -s 192.168.18.155 -j ACCEPT

# Eliminar todos los paquetes que entren.

iptables -A INPUT -j DROP

# Permitir la salida de paquetes.

iptables -A OUTPUT -j ACCEPT

# Añadir una regla a la cadena INPUT para rechazar todos los paquetes 
# que se originan desde la dirección 192.168.18.155

iptables -A INPUT -s 192.168.18.155 -j DROP

# Añadir una regla a la cadena INPUT para rechazar todos los paquetes
# que se originan desde la dirección de red 192.168.18.0

iptables -A INPUT -s 192.168.18.0/24 -j DROP

# Añadir una regla a la cadena INPUT para rechazar todos los paquetes que se originan 
# desde la dirección 192.168.18.155 y enviar un mensaje de error icmp.

iptables -A INPUT -s 192.168.18.155 -j REJECT

# Permitir conexiones locales (al localhost), por ejemplo a mysql.

iptables -A INPUT -s 127.0.0.1 -p tcp --dport 3306 -j ACCEPT

# Permitir el acceso a nuestro servidor web (puerto TCP 80)

iptables -A INPUT -s 0.0.0.0/0 -p tcp --dport 80 -j ACCEPT

# Permitir el acceso a nuestro servidor ftp (puerto TCP 20 y 21).

iptables -A INPUT -s 0.0.0.0/0 -p tcp --dport 20:21 -j ACCEPT

# Permitimos a la máquina con IP 192.168.18.10 conectarse a nuestro equipo a través de SSH.

iptables -A INPUT -s 192.168.18.10 -p tcp --dport 22 -j ACCEPT

# Rechazamos a la máquina con IP 192.168.0.10 conectarse a nuestro equipo a través de Telnet

iptables -A INPUT -s 192.168.0.10 -p tcp --dport 23 -j ACCEPT

# Rechazamos las conexiones que se originen de la máquina con la dirección física 00:db:f0:34:ab:78

iptables -A INPUT -m mac --mac-source 00:db:f0:34:ab:78 -j DROP

# Rechazamos todo el tráfico que ingrese a nuestra red LAN 192.168.0.0 /24 
# desde una red remota, como Internet, a través de la interfaz eth0. (forward)

iptables -A FORWARD -i eth0 -s 0.0.0.0/0 -d 192.168.24.0/24 -j DROP

# Aceptamos que vayan de nuestra red 192.168.24.0/24 a un servidor web (puerto 80) (forward) 

iptables -A FORWARD -i eth1 -s 192.168.24.0/24 -d 77.224.231.100 -p tcp --dport 80 -j ACCEPT

# Aceptamos que nuestra LAN 192.168.0.0/24 vayan a puertos https: (forward)

iptables -A FORWARD -i eth1 -s 192.168.24.0/24 -p tcp --dport 443 -j ACCEPT

# Aceptamos que los equipos de nuestra red LAN 192.168.24.0/24 consulten los DNS de internet (forward)

iptables -A FORWARD -i eth1 -s 192.168.24.0/24 -p tcp --dport 53 -j ACCEPT 
iptables -A FORWARD -i eth1 -s 192.168.24.0/24 -p udp --dport 53 -j ACCEPT 

# Permitimos enviar y recibir e-mail a todos:

iptables -A FORWARD -i eth1 -p tcp --dport 143 -j ACCEPT 

# Cerramos el acceso de una red definida 192.168.25.0/24 a nuestra red LAN 192.168.24.0/24

iptables -A FORWARD -i eth1 -s 192.168.24.0/24 -d 192.168.25.0/24 -j DROP 






















































