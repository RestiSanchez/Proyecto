#####################################
# Script instalacion OpenMediaVault #
#####################################

# Actualizamos repositorios

apt update 
apt upgrade -y

# Añadimos al usuario pi al grupo ssh por si hubiera algun problema

adduser pi ssh

# Ejecutamos script instalacion OMV

wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash

## Reiniciamos la máquina

reboot
