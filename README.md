# Rapsberry Pi como NAS en pequeñas empresas u hogares

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

Primero comentar de que existen una variedad inmesas de modelos de NAS de marcas reconocidas como Synology o QNAP entre otros pero con un precio bastante elevado.

Si prefieres montarte tu propio NAS tendrás la libertad para ampliar o no cuando lo necesites y para trastear todo lo necesario , crear tu propio NAS con una Rapsberry Pi es más económico y si eres paciente tendrás lo que buscas!

### Cómo crear tu propio NAS con la Rapsberry Pi 4

Imagen rapsberry Pi 4 

#### ¿Qué vamos a necesitar para nuestro NAS?

  - Rapsberry Pi -> El modelo que utilizo yo es una Rapsberry Pi 4 de 8GB de RAM pero con una de 2GB de RAM ya sería suficiente.
  - Unidades de almacenamiento USB o con una placa que añade conexiones SATA a la Rapsberry Pi añadir unos discos HDD o SSD aumentando la velocidad de transferencia
  - Una tarjeta microSD para la instalación 

#### Instalación de OpenMediaVault

Lo primero que vamos a necesitar una vez reunidos nuestro hardware será descargar el software que vamos a usar para montarnos el NAS. 

[OpenMediaVault](https://www.openmediavault.org) 

Este software es la distribución que se basa en montar tu propio NAS

##### Proceso de instalación OpenMediaVault en MicroSD

Una vez descarga la ISO utilizaremos [Rapsberry Pi Imager](https://www.raspberrypi.com/software/)
Desde la misma página de Rapsberry puedes descargalo.

![Rapsberri Pi Imager](https://github.com/RestiSanchez/Proyecto/blob/main/imgs/rpi1.png)

Se puede utilizar otros programas como ApplePiBacker o BerryBoot , introduce tu tarjeta microSD con un adaptador al ordenador y selecciona el sistema operativo que quieres utilizar. Una vez terminado el proceso , introduce la tarjeta en la Rapsberry Pi , conecta los discos USBs o por SATA y enciendela.

![Seleccionar custom](https://github.com/RestiSanchez/Proyecto/blob/main/imgs/rpi2.png)

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

### Configuración de OpenMediaVault

Primero debemos saber que ip tiene nuestra rapsberry 

Utilizamos el comando " ip a " para saber la IP de nuestra máquina:

![image](https://user-images.githubusercontent.com/14905801/155123290-fcfc38ea-2318-4422-bf58-09b766504a8c.png)

A continuación con el comando: " sudo nano /etc/network/interfaces "

Escribimos nuestra IP estática del servidor

![image](https://user-images.githubusercontent.com/14905801/155126059-c478a47e-cd03-41a9-951f-36818e22a7bb.png)

Reiniciamos las interfaces de red para aplicar los cambios:

" sudo /etc/init.d/networking restart "

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


#### Configuración de discos 

Una vez ingresado en nuestro navegador y accedido al servidor , seleccionamos discos en la parte izquierda para configurar los discos duros que podemos utilizar: 

![image](https://user-images.githubusercontent.com/14905801/155126870-9451e155-0b36-4b84-bc63-c551c7a07c3b.png)














