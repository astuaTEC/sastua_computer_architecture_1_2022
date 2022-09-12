# Proyecto Individual: Desarrollo de una aplicación para la generación de gráficos y texto

***

## Requisitos

El proyecto fue desarrollado en un entorno linux, específicamente en la distribución Ubuntu 22.04 LTS. Por lo que es importante que se asegure de ejecutarlo en un entorno de este tipo.

Deberá tener instalado python en su computadora, preferiblemente en su versión 3.9 o posterior.

Instalar varias librerías como:

Open cv:

```console
pip install opencv-python
```

NumPy:
```console
pip install numpy
```

PyQt5:

```console
pip install PyQt5
```

PyQt5 tools:

```console 
pip install pyqt5-tools
```

En cuanto al ensamblador, este fue desarrolado mediante el ISA x86. Es por eso que si necesita realizar algún cambio en el archivo fuente (proyecto_1/src/asm/main.asm) deberá tener instalado NASM.

NASM:

```console 
sudo apt update
```

```console 
sudo apt install nasm
```

***

## Uso del programa

Una vez instalado todo lo anterior, es hora de ejecutar el archivo gui.py que se encuentra dentro de la carperta proyecto_1/src.

Lo puede hacer como vea más conveniente, ya sea con algún IDE o ejecutando un comando en consola como el siguiente:

```console 
python3 gui.py
```

Se le abrirá una ventana como la siguiente:

![Inicio](https://res.cloudinary.com/dnxt7nqdg/image/upload/v1662759566/Proyecto%201%20-%20Arqui%201/Screenshot_from_2022-09-09_15-34-39_gjaxk8.png)

Si presiona el botón "Abrir imagen", le abrirá el seleccionador de archivos de su computadora. Aquí podrá seleccionar ciertas imágenes dentro de la carpeta "imgs", que ya vienen incluidas en el proyecto, o bien, seleccionar cualquier otra imagen de su computadora, siempre y cuando sea de tamaño 390x390.

![Abrir](https://res.cloudinary.com/dnxt7nqdg/image/upload/v1662759566/Proyecto%201%20-%20Arqui%201/Screenshot_from_2022-09-09_15-35-50_fvazni.png)

Luego de eso, le aparecerá la imagen seleccionada en el recuadro izquierdo, donde también podrá ver la división de la misma por cuadrantes.

![Cargada](https://res.cloudinary.com/dnxt7nqdg/image/upload/v1662759566/Proyecto%201%20-%20Arqui%201/Screenshot_from_2022-09-09_15-36-25_lch3qv.png)

En el centro de la pantalla podrá elegir un número de cuadrante, al cual se le aplicará el algoritmo de la interpolación bilineal. Una vez seleccionado el número de cuadrante, oprima el botón "Iniciar" para aplicar dicho algoritmo. Se le cargará el resultado de este en el recuadro derecho de la pantalla.

![Algoritmo](https://res.cloudinary.com/dnxt7nqdg/image/upload/v1662759566/Proyecto%201%20-%20Arqui%201/Screenshot_from_2022-09-09_15-36-46_ivvtgx.png)

Si quiere limpiar tanto el recuadro derecho como el izquierdo, lo podrá hacer oprimiendo el botón "Limpiar". Cabe recalcar que para cargar otra imagen no es necesario limpiar los recuadros y luego abrir la otra imagen, sino que simplemente se puede cargar la nueva imagen directamente.

![Limpiar](https://res.cloudinary.com/dnxt7nqdg/image/upload/v1662759626/Proyecto%201%20-%20Arqui%201/Screenshot_from_2022-09-09_15-40-14_zjqhhb.png)

*** 

## Notas extra

Si quiere realizar un cambio en el ensamblador (proyecto_1/src/asm/main.asm), luego de realizar este, deberá compilar el archivo y enlazarlo. Para ello use los siguientes comandos:

```console 
nasm -felf64 -o main.o main.asm
ld -o main main.o
```
