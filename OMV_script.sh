#####################################
# Script instalacion OpenMediaVault #
#####################################

# Ver los pasos
set -x

# Actualizamos repositorios

apt update 
apt upgrade -y

# Añadimos al usuario pi al grupo ssh por si hubiera algun problema

adduser pi ssh

# Instalamos git
apt install git


# Activamos y ejecutamos el ssh con:

sudo systemctl enable ssh

sudo systemctl start ssh


# Descargamos y ejecutamos script instalacion OMV

wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash

## Reiniciamos la máquina

reboot
