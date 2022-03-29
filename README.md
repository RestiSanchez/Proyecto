# Rapsberry Pi como NAS en pequeñas empresas u hogares con VPN propia

## Indice
  - ¿Qué es una Rapberry Pi y para que sirve?
  - ¿Qué es un NAS?
  - ¿Por qué crear un NAS con una Rapsberry Pi?
  - Como crear tu propio NAS con la Rapsberry Pi 4
  - Instalación de OpenMediaVault
  - Configuración de OpenMediaVault
  - Configuración de certificados SSL
  - Cambio de contrasñea de administrador
  - Configuración de discos
  - Configuración de perfil de usuario
  - Métodos para ingresar al servidor
  - Utilizar OpenVPN con OpenMediaVault
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

Ahora nos descargariamos el script desde github , haciendo un git clone de este repositorio
~~~
git clone https://github.com/RestiSanchez/Proyecto.git
~~~
Una vez clonado en consola puedes escribir:

Cambiamos al directorio
~~~
cd /Proyecto/  

sudo bash OMV_script.sh
~~~
Con este script lo que hacemos es , actualizar los repositorios , activar el ssh que viene por defecto desactivado e instalar el OpenMediaVault desde consola.

### Configuración de OpenMediaVault

Primero debemos saber que ip tiene nuestra rapsberry 

Utilizamos el comando " ip a " para saber la IP de nuestra máquina:

![image](https://user-images.githubusercontent.com/14905801/155123290-fcfc38ea-2318-4422-bf58-09b766504a8c.png)

A continuación con el comando: 
~~~ sudo nano /etc/network/interfaces 
~~~

Escribimos nuestra IP estática del servidor

![image](https://user-images.githubusercontent.com/14905801/155126059-c478a47e-cd03-41a9-951f-36818e22a7bb.png)

Reiniciamos las interfaces de red para aplicar los cambios:

~~~ sudo /etc/init.d/networking restart 
~~~

![image](https://user-images.githubusercontent.com/14905801/155126218-ca4e89f1-c016-4f89-b2a5-999880b5babe.png)

Y procedemos a introducirla en nuestro navegador , nos pedirá un usuario y una contraseña para acceder , por defecto los credenciales de inicio de sesión son:

Nombre de usuario: " admin "
Contraseña: " openmediavault "

![image](https://user-images.githubusercontent.com/14905801/155123476-ea2ac2c0-6bc1-471b-be0a-9f6cba4d2327.png)

### Configuración certificados SSL

Ya con acceso al servidor seguimos la siguiente ruta: "Sistema" -> "Opciones generales" -> "Conexión segura" 

Para utilizar la conexión segura necesitas un certificado , para crear este certificado hay que entrar en "Sistema" -> "Certificados" y haz click sobre SSL , luego pulsa "Añadir" y "Guardar" tras ingresar los datos. Hay que habilitar el certificado en los ajustes generales y aplicar cambios.

![image](https://user-images.githubusercontent.com/14905801/155127858-841c0ed5-a90f-4aaa-91a4-6f6d3944fe6d.png)

Nos dirigimos a la primera ruta comentada de este apartado y habilitamos el SSL , seleccionando el certificado creado en el paso anterior:

![image](https://user-images.githubusercontent.com/14905801/155128082-b2ac03ea-0ad6-4cc0-b07e-fbe6e4b5f27d.png)

#### Cambio de contraseña de administrador

Nos vamos a opciones generales , contraseña de administrador e ingresamos la nueva contraseña:

![image](https://user-images.githubusercontent.com/14905801/155128757-bb521466-2b45-4850-912d-b99f0ef7371b.png)


#### Configuración de discos 

Una vez ingresado en nuestro navegador y accedido al servidor , seleccionamos discos en la parte izquierda para configurar los discos duros que podemos utilizar: 

![image](https://user-images.githubusercontent.com/14905801/155126870-9451e155-0b36-4b84-bc63-c551c7a07c3b.png)

Ahora nos vamos a Sistema de Archivos y pulsamos en añadir y seleccionamos el formato para inicializar los discos y el disco que queramos inicializar

![image](https://user-images.githubusercontent.com/14905801/155285951-1865d0e5-78e6-44ff-9273-7091a3f016e0.png)

Otra cosa que podemos apreciar aquí son las cuotas que se le pueden poner a usuario/s o grupo/s como podemos ver en la siguiente imagen , limitando la cantidad de datos que pueden meter en el disco.

![image](https://user-images.githubusercontent.com/14905801/155287392-071c62c6-f853-4133-b09d-1f7b8d19ad3c.png)


Y ahora nos vamos a Carpeta compartida y pulsamos en añadir y creamos nuestra carpeta o sistema de carpetas:

![image](https://user-images.githubusercontent.com/14905801/155286444-451a0006-443a-43df-808b-336c249fc8c3.png)

Tendremos una serie de permisos para cada usuario/grupo que depende de cada carpeta/s variarán según lo que deseemos hacer.

#### Configuración de perfil de usuario

Nos vamos a la opción " Usuario " . Seleccionamos la opción " Añadir " y rellenamos los datos.

En este apartado podemos agregar y eliminar perfiles de acceso al server NAS , podemos modificar los permisos de acceso de estos perfiles. Despues de ingresar un usuario , lo seleccionamos y pulsamos en " Modificar acceso ". Podremos otogar o revocar permisos a los usuarios para que puedan moficar el contenido almacenado , permisos de solo lectura o ningun permiso.

#### Métodos para ingresar al servidor

- Linux -> Accedemos al administrador de archivos y seleccionamos "Conectar al servidor" , cuando nos pida ingresar una dirección tendremos que introducir un prefijo "sbm://" Por lo que quedaria algo asi:

Ejemplo: 
~~~sbm://192.168.1.36
~~~

- Windows -> Nos vamos al explorador de archivos y en la ubicación escribimos el prefijo "\\":

Ejemplo: 
~~~\\192.168.1.36
~~~

Y ya estariamos accediendo a nuestro servidor NAS de nuestra Rapsberry Pi!

### Utilizar OpenVPN con OpenMediaVault 

Lo primero que vamos a hacer es añadir unos repositorios a la lista que nos trae OpenMediaVault (Solo nos trae dos) y para solucionar el problema con la instalacion de programas necesitaremos añadir estos dos repositorios a la lista de "" /etc/apt/sources.list ""

~~~ deb http://httpredir.debian.org/debian buster main non-free contrib
deb-src http://httpredir.debian.org/debian buster main non-free contrib
~~~
![image](https://user-images.githubusercontent.com/14905801/155306261-06615565-4674-4e8e-98cb-7162dfaa54db.png)





## Conclusión

Para empezar me gustaria comentar el punto de vista dentro de una empresa:
Me parece un recurso bastante útil para realizar copias de seguridad a los equipos de forma autónoma y se guarde en red en un disco duro de este equipo. Además cada trabajador puede tener su propia carpeta dentro de otro disco duro donde almacenar datos que se utilizan a diario. Es nuestro propio servidor de almacenamiento en red muy económico , pero es muy útil si queremos tener separadas nuestras copias de seguridad o si se necesita acceder al contenido desde varios equipos sin depender de un server dedicado.

Para las copias de seguridad y que puedan trabajar con esos archivos trabajaria directamente en una red interna para que solo los trabajadores de esa empresa se pudieran conectar. Además se podría añadir tu propia VPN como he explicado con anterioridad para aumentar la seguridad y también la productividad pudiendo trabajar y acceder a los recursos en red desde cualquier punto con conexion a Internet.

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



### DUDAS SOBRE INSTALACIÓN

### Instalación OpenMediaVault

![image](https://user-images.githubusercontent.com/14905801/155089913-f13a57da-cfa6-4d5c-a1ca-ad2ef4c67606.png)

Comenzamos con la instalación una vez iniciada nuestra rapsberry , automáticamente avanza hasta instalar , seleccionamos el idioma y el teclado que vamos a utilizar , comenzará a cargar la configuración de red:

![image](https://user-images.githubusercontent.com/14905801/155090431-80780900-7cff-475d-903b-46e40c917138.png)

Escribimos el nombre del dominio o del grupo de trabajo que estás utilizando:

![image](https://user-images.githubusercontent.com/14905801/155090693-7f89295a-b78d-43db-b3d2-c3c76ef26baa.png)

Avanzamos y ahora nos pide ingresar una contraseña para el usuario root , se puede dejar en blanco , creandote un usuario con permisos de administrador utilizando la orden " sudo " de forma automática

![image](https://user-images.githubusercontent.com/14905801/155091176-4bc9d6af-4926-4cd7-9c7c-4c67d207e5aa.png)

Volvemos a meter la contraseña para su verificación e ingresamos la zona horaria donde estamos , una vez seleccionada la zona , comenzará la instalación:

![image](https://user-images.githubusercontent.com/14905801/155091469-51c51845-a4f6-4ad3-882d-0557a30f00df.png)

Una vez finalizada pulsamos en continuar y se nos inciará OpenMediaVault
