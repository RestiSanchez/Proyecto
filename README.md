# Rapsberry Pi como NAS en pequeñas empresas u hogares con VPN propia

## Indice
  - ¿Qué es una Rapberry Pi y para que sirve?
  - ¿Qué es un NAS?
  - ¿Por qué crear un NAS con una Rapsberry Pi?
  - Como crear tu propio NAS con la Rapsberry Pi 4
  - Instalación de OpenMediaVault
  - Configuración de OpenMediaVault
  - Métodos para ingresar al servidor
  - Instalación de Docker y Portainer
  - Utilizar WireGuard con OpenMediaVault
  - Varios servicios instalados con Portainer
  - Conclusión
  - Fuentes
  - Ayuda con la instalación

### ¿Qué es una Rapsberry Pi y para qué sirve?

Es un ordenador de bajo coste y formato compacto destinado al desarrollado para hacer accesible la informática a todos los usuarios.
La Raspberry Pi también se caracteriza por ser muy utilizada para desarrollar pequeños prototipos y para la formación sobre informática y electrónica.

Todos los diseños de Raspberry Pi se basan en el hardware libre y habitualmente se utilizan también sistemas operativos libres basados en GNU/Linux.
Para este microordenador se ha desarrollado Raspberry Pi OS (antes conocido como Raspbian) que es una versión personalizada de Debian.
Adicionalmente se pueden instalar diferentes sistemas operativos como Ubuntu , Windows para ARM o algún otro sistema como LibreELEC para utilizar la rapsberry como centro multimedia.

El poder de las Raspberry Pi reside en los precios y la versatilidad que ofrecen. Todos los modelos de Raspberry Pi tienen un precio inferior a los 100€, eso sí, únicamente adquiriremos la placa, el resto de elementos va a parte.


### ¿Qué es un NAS? 

Un servidor NAS consiste en un equipo con extensas características de almacenamiento que se conectará através de una red, que podrá ser dómestica o corporativa. Un NAS maneja los datos como un repositorio centralizado en el cual se necesita una serie de credenciales de acceso para los usuarios autorizados.

Una de las carácterísticas principales de un NAS es que puede ofrecer una fuerte repliación de datos mediante la creación de volúmenes RAID ( " Redundant Array of Independent Disks " ). Un método mediante el cual se conectan varios discos duros en un dispositivo que permite crear distintos niveles de almacenamiento con soporte para copias de seguridad en red.

## ¿Por qué crear un NAS con una Rapsberry Pi?

Primero comentar de que existen una variedad inmesas de modelos de NAS de marcas reconocidas como Synology o QNAP entre otros pero con un precio bastante elevado. Y con esta opción reducirás bastante los precios y para una opción 

Si prefieres montarte tu propio NAS tendrás la libertad para ampliar o no cuando lo necesites y para trastear todo lo necesario , crear tu propio NAS con una Rapsberry Pi es más económico y si eres paciente tendrás lo que buscas!

### Cómo crear tu propio NAS con la Rapsberry Pi 4

Imagen rapsberry Pi 4 

#### ¿Qué vamos a necesitar para nuestro NAS?

  - Rapsberry Pi -> El modelo que utilizo yo es una Rapsberry Pi 4 de 8GB de RAM pero con una de 2GB de RAM ya sería suficiente.
  - Unidades de almacenamiento USB o con una placa que añade conexiones SATA a la Rapsberry Pi añadir unos discos HDD o SSD aumentando la velocidad de transferencia
  - Una tarjeta microSD para la instalación 

### Instalación de OpenMediaVault


##### Proceso de instalación OpenMediaVault en MicroSD

Una vez descarga la ISO utilizaremos [Rapsberry Pi Imager](https://www.raspberrypi.com/software/)
Desde la misma página de Rapsberry puedes descargalo.

![Rapsberri Pi Imager](https://github.com/RestiSanchez/Proyecto/blob/main/imgs/rpi1.png)

Se puede utilizar otros programas como ApplePiBacker o BerryBoot , introduce tu tarjeta microSD con un adaptador al ordenador y selecciona el sistema operativo que quieres utilizar. Una vez terminado el proceso , introduce la tarjeta en la Rapsberry Pi , conecta los discos USBs o por SATA y enciendela.

Seleccionamos la opción de Raspberry Pi OS (other) y dentro seleccionamos una imagen del sistema que nosotros queramos , en mi caso como no quiero versión de escritorio utilizo la Raspberry Pi OS lite (Legacy) que contiene unas actualizaciones de seguridad que en las otras versiones no tienen.

![image](https://user-images.githubusercontent.com/14905801/160571762-d13bcc59-4f09-4a4c-b67d-357147ed5b9c.png)

Lo metemos en nuestra tarjeta micro SD y a nuestra rapsberry , la iniciamos y nos logeamos con el usuario y contraseña por defecto :
- Usuario: pi
- Contraseña: raspberry


El SSH lo podemos activar de dos maneras: 

1.- De forma manual:
  - Añadir en consola :
  ~~~
  sudo systemctl enable ssh
  
  sudo systemctl start ssh
  ~~~
2.- Volviendo a meter la tarjeta SD en el ordenador
  - Creamos un archivo de texto y le quitamos la extension dejandolo como "ssh".
  - Desconectamos la tarjeta y metemos la microSD en la rapsberry
 
 De cualquiera de estas dos formas activamos el ssh de la máquina
 
 #### Cambiamos la contraseña una vez logeado con:
~~~
passwd
~~~
 
#### Actualizamos repositorios
~~~
apt update 
apt upgrade -y
~~~

#### Descargamos y ejecutamos script instalacion OMV

wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash

Cambiamos la contraseña una vez logeado con:
~~~
passwd
~~~


### Configuración de OpenMediaVault

Ya nos podemos conectar por ssh a nuestra maquina en mi caso utilizo Putty

Primero debemos saber que ip tiene nuestra rapsberry 

Utilizamos el comando " ip a " para saber la IP de nuestra máquina:

![image](https://user-images.githubusercontent.com/14905801/160607439-fef6f797-574d-4cef-989f-26857e199ba9.png)

Y procedemos a introducirla en nuestro navegador , nos pedirá un usuario y una contraseña para acceder , por defecto los credenciales de inicio de sesión son:

Nombre de usuario: " admin "
Contraseña: " openmediavault "

![image](https://user-images.githubusercontent.com/14905801/155123476-ea2ac2c0-6bc1-471b-be0a-9f6cba4d2327.png)


#### Métodos para ingresar al servidor

**IMPORTANTE** 
Mirar el repositorio con la configuración previa de algunos aspectos necesarios de OpenMediaVault:

https://github.com/RestiSanchez/OpenMediaVault.git

Para acceder a la aplicacion web ingresamos la ip en nuestro navegador

Acceder desde un equipo cliente:

- Linux -> Accedemos al administrador de archivos y seleccionamos "Conectar al servidor" , cuando nos pida ingresar una dirección tendremos que introducir un prefijo "sbm://" Por lo que quedaria algo asi:

Ejemplo: 
~~~
sbm://ip_de_nuestro_servidor
~~~

- Windows -> Nos vamos al explorador de archivos y en la ubicación escribimos el prefijo "\\":

Ejemplo: 
~~~
\\ip_de_nuestro_servidor
~~~

Y ya estariamos accediendo a nuestro servidor NAS de nuestra Rapsberry Pi!

### Instalamos Docker y Portainer

#### ¿Qué es Docker y para qué sirve?

Docker es una plataforma creada con el fin de desarrollar, implementar y ejecutar aplicaciones dentro de contenedores. Lo cual permite a los desarrolladores realizar el empaquetado de nuestras aplicaciones junto a sus correspondientes dependencias dentro de una unidades estandarizadas conocidas bajo el término de contenedores de software.

#### ¿Qué es Portainer y para qué sirve?

Portainer es una herramienta web open-source la cual se ejecuta ella misma como un container, por tanto deberemos tener Docker instalado. Esta aplicación nos va a permitir gestionar de forma muy fácil e intuitiva nuestros contenedores Docker a través de una interfaz gráfica.

Para las tareas de administración de contenedores Docker, a veces la línea de comandos puede hacerse algo dura para realizar ciertas acciones. A través de una interfaz web, un administrador puede tener una visión global más clara de los contenedores que está ejecutando y facilitar su gestión.

#### ¿Dónde lo instalamos?

![image](https://user-images.githubusercontent.com/14905801/160883597-01a7b277-640d-43a1-991e-28605ade5dc5.png)

Menu -> Sistema -> OMV-Extras e instalamos los dos servicios con la aplicacion Web




### Otros contenedores instalados

#### Heimdall

Gracias a esta aplicación podemos tener una página de inicio donde puedes agrupar todos los accesos directos a tus aplicaciones docker. Es uno de los pocos contenedores con imágenes arm , por lo tanto compatible con nuestra RPi.

Esta aplicación es muy útil cuando tienes un montón de contenedores corriendo y no recuerdas las url y puertos de cada aplicación.

#### DuckDNS

Duckdns es un servicio de DNS dinámico , este contenedor nos brinda la posibilidad de convertir nuestra dirección IP pública en un dominio mas sencillo de recordar y mantenerlo actualizado siempre para que no tengamos que preocuparnos por si cambia nuestra IP pública


## Conclusión

Para empezar me gustaria comentar el punto de vista dentro de una empresa:
Me parece un recurso bastante útil para realizar copias de seguridad a los equipos de forma autónoma y se guarde en red en un disco duro de este equipo. Además cada trabajador puede tener su propia carpeta dentro de otro disco duro donde almacenar datos que se utilizan a diario. Es nuestro propio servidor de almacenamiento en red muy económico , pero es muy útil si queremos tener separadas nuestras copias de seguridad o si se necesita acceder al contenido desde varios equipos sin depender de un server dedicado.

Para las copias de seguridad y que puedan trabajar con esos archivos trabajaria directamente en una red interna para que solo los trabajadores de esa empresa se pudieran conectar. Además se podría añadir tu propia VPN como he explicado con anterioridad para aumentar la seguridad y también la productividad pudiendo trabajar y acceder a los recursos en red desde cualquier punto con conexion a Internet.

Además gracias a la utilización de docker y portainer puedes aumentar los microservicios que puede ofrecer nuestro servidor de OpenMediaVault 

### Asistente de configuración de OpenMediaVault

Se puede abrir el asistente utilizando 
~~~
  omv-firstaid
~~~

### Extensiones

- servicio de impresion 
- servicio de escaner en red
- servicio VPN propio


### FUENTES
- https://www.geeknetic.es/Guia/2138/Como-convertir-una-Raspberry-Pi-en-un-NAS.html
- https://www.hostinger.es/tutoriales/como-configurar-vpn-linux-con-openvpn
- https://chachocool.com/como-instalar-docker-en-debian-10-buster/
- https://eloutput.com/productos/gadgets/raspberry-pi-nas-ventajas-desventajas/
- https://nefele.dev/blog/gestor-de-dns-dinamicas-duckdns/#:~:text=Para%20crear%20nuestra%20dirección%20DDns,queramos%20para%20nuestro%20subdomino%20DDns.
- https://www.youtube.com/watch?v=UDGtzAncVMI
- https://profile.es/blog/que_es_docker/
- https://ahorasomos.izertis.com/solidgear/portainer-io-monitorea-y-administra-docker-de-manera-sencilla-e-intuitiva/
- https://hub.docker.com/r/linuxserver/heimdall
- https://hub.docker.com/r/linuxserver/duplicati
- https://hub.docker.com/r/containrrr/watchtower
- https://hub.docker.com/r/linuxserver/qbittorrent
- https://docs.docker.com/samples/wordpress/
- https://www.tecmint.com/manage-and-create-lvm-parition-using-vgcreate-lvcreate-and-lvextend/



### DUDAS SOBRE INSTALACIÓN

Mirar repositorio: https://github.com/RestiSanchez/OpenMediaVault
