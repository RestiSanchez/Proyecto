#Lo primero que vamos a hacer va a ser crear una variable de entorno para trabajar de forma mas comoda posible
#
# Variables de entorjo
OVPN_DATOS="ovpn_Resti_openvpn"
DNS="nombre_dns"
# Tendremos que abrir en nuestro router un puerto UDP tanto interno como externo
PUERTO="Numero_puerto"
CLIENTE="Nombre_cliente"
# Actualizar repositorio
apt update
apt upgrade

# Instalamos el paquete net-tools que contiene las herramientas de red necesarias para la instalacion de 
# OpenVPN , ademas de docker para la creacion de contenedores

apt install net-tools -y 
apt install docker -y

# Utilizaremos el comando sudo para crear un volumen de docker

docker volume create --name $OVPN_DATOS

docker run -v $OVPN_DATOS:/etc/openvpn --log-driver=none --rm darathor/openvpn ovpn_genconfig -u udp://$DNS

# Creamos el certificado de CA

docker run -v $OVPN_DATOS:/etc/openvpn --log-driver=none --rm -it darathor/openvpn ovpn_initpki

# Aqui utilizaremos el puerto declarado arriba

docker run -v $OVPN_DATOS:/etc/openvpn -d -p $PUERTO:$PUERTO/udp --cap-add=NET_ADMIN darathor/openvpn

# Generamos un certificado de cliente sin contraseña
# Lo dejo comentado porque me interesa saber como meter certificados incrustados a la configuracion del cliente

docker run -v $OVPN_DATOS:/etc/openvpn --log-driver=none --rm darathor/openvpn ovpn_getclient $CLIENTE > $CLIENTE.ovpn
