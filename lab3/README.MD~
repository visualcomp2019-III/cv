# Taller raster

## Propósito

Comprender algunos aspectos fundamentales del paradigma de rasterización.

## Tareas

Emplee coordenadas baricéntricas para:

1. Rasterizar un triángulo.
2. Sombrear su superficie a partir de los colores de sus vértices.
3. Implementar un [algoritmo de anti-aliasing](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation) para sus aristas.

Referencias:

* [The barycentric conspiracy](https://fgiesen.wordpress.com/2013/02/06/the-barycentric-conspirac/)
* [Rasterization stage](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-stage)

Implemente la función ```triangleRaster()``` del sketch adjunto para tal efecto, requiere la librería [nub](https://github.com/visualcomputing/nub/releases) (versión >= 0.2).

## Integrantes

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
| Nicolás Restrepo Torres | [NicolasRestrepoTorres][NicolasRestrepoTorres_link] |
| Cristian David Gonzalez Carrillo | [crdgonzalezca][crdgonzalezca_link] |

[crdgonzalezca_link]:https://github.com/crdgonzalezca
[NicolasRestrepoTorres_link]:https://github.com/NicolasRestrepoTorres

## Discusión
En este taller se implementó la rasterización, colorización y suavizado de bordes de un triángulo generado aleatoriamente haciendo uso de la librería Nub.

A continuación se muestra la rasterización de un triángulo aleatoreo en diferentes tamaños de malla, donde se puede apreciar un efecto de definición del triángulo a medida que la cantidad de "píxeles" crece.
**Rasterización del triangulo**: para empezar a hacer el proceso de rasterización del triangulo se empezaron por tomar las coordenadas del mundo normal, iterando desde la menor formada por los tres vectores en el eje x hasta la mayor formada por los tres vectores en x y de una forma similar con el eje y. Para simular la cuadrícula dada por la libreria **nub** el incremento en cada uno de los pasos de la iteración se hace con respecto a la **magnitud del nodo**. Seguido de esto se usa lo que se conoce como la *edge function* que simplemente cálcula el valor positivo o negativo de la posición de un punto con respecto a si está a la "derecha" o a la "izquierda" de cada uno de los vectores que conforman el tríangulo. El orden de los vectores importa, así que esta comprobación se hace en ambos sentidos, en contra de las manecillas del reloj o en sentido de las manecillas del reloj; para lo cual al calcular la función con respecto a los tres vectores en el primer sentido se quiere que todos sean mayores que cero (positivos en este caso) y para el segundo sentido que todos sean menores que cero (positivo igualmente pero en el otro sentido). Esta comprobación simplemente dice si un dado pixel está dentro del tríangulo o no. Después se entiende que lo que se está renderizando o lo que se quiere obtener se quiere con base al triangulo en las coordenadas del nodo, se renderiza entonces todo lo que esté dentro del tríangulo tomando como referencia el resultado de la función anterior. Para lograr esto se hace la transformación a las coordenadas del haciendo uso de la función *node.location* que hace la transformación respectiva. Si el pixel está dentro entonces se toma un cuadrado del mismo tamaño de la cuadrícula o del tamaño del que se quiera que sea la rasterización, como la cuadrícula tiene que equivaler efectivamente a esos pixeles, se toma ese tamaño. La rasterización entonces queda con bordes irregulares pero renderiza una aproximación mejor de un tríangulo según se vaya aumentando la escala de la cuadrícula base.
**Colorización del triangulo**: Cada vértice del triángulo tiene un color asignado y según esto, los cuadrados que se tomaron en el anterior paso que representan a los pixeles se colorean con respecto a su proximidad a cada uno de los vertices del triangulos y a la cuadricula dada. Esto se logra usando las coordenadas baricentrícas de la siguiente manera: estas entregan un peso para cada pixel ubícado en cierto punto dentro del tríangulo (lo que se comprobó en el anterior paso) y según este peso y promediando con los demás se asigna cada canal de los nuevos cuadrados a renderizar. Esto resulta en un degrade mejor a medida que la cuadricula crece.
**Suavizado de bordes**: Basándonos en la lectura de [como mejorar la rasterización de un triangulo][lecture] se comprueban cuales son los pixeles cuyos bordes no se pueden dibujar completamente dentro del tríangulo. Después de hacer esta comprobación se toma un submuestreo más amplio de la zona circundante de este pixel, lo cuál signfica simplemente simular una cuadricula más grande aumentada en un factor *f*, se comprueban cuantos puntos de este submuestreo siguen estando dentro o fuera del triangulo con la misma *edge function*. Después de esto se toma un promedio ponderado del color de afuera del tríangulo y del color que se obtiene originalmente del pixel con respecto al paso anterior. Como el promedio ponderado del color de afuera es negro, lo cuál equivale a un *color(0)* entonces simplemente se ignora y se observa cuantos pixeles quedaron por dentro dando el promedio como la fórmula *pixeles_dentro/total_pixeles*. Luego se toma esta ponderación y se multiplica cada canal por ella y se dibuja el cuadrado con ese nivel de opacidad, entre más salido esté el cuadro y menos pixeles hayan, más oscuro será. Igualmente, entre más grande sea el factor, mayor procesamiento se requiere pero se logran tener los bordes más suaves.

Para probar todos los pasos anteriores se puede usar

⋅⋅* **u**: Bajar opacidad de la renderización.
⋅⋅* **d**: Subir opacidad de la renderización.
⋅⋅* **a**: Desactivar antialiasing (suavizado de bordes).
⋅⋅* **f**: Aumentar el factor submuestreo del antialiasing, está inicializado en 1 y aumenta en potencias de 2.


[lecture]:https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation


Describa los resultados obtenidos. En el caso de anti-aliasing describir las técnicas exploradas, citando las referencias.

## Entrega

* Plazo: ~~20/10/19~~ 27/10/19 a las 24h.
