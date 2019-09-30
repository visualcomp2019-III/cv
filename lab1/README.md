# Taller de análisis de imágenes por software

## Propósito

Introducir el análisis de imágenes/video en el lenguaje de [Processing](https://processing.org/).

## Tareas

Implementar las siguientes operaciones de análisis para imágenes/video:

* Conversión a escala de grises: promedio _rgb_ y [luma](https://en.wikipedia.org/wiki/HSL_and_HSV#Disadvantages).
* Aplicación de algunas [máscaras de convolución](https://en.wikipedia.org/wiki/Kernel_(image_processing)).
* (solo para imágenes) Despliegue del histograma.
* (solo para imágenes) Segmentación de la imagen a partir del histograma.
* (solo para video) Medición de la [eficiencia computacional](https://processing.org/reference/frameRate.html) para las operaciones realizadas.

Emplear dos [canvas](https://processing.org/reference/PGraphics.html), uno para desplegar la imagen/video original y el otro para el resultado del análisis.

### Alternativas para video en Linux y `gstreamer >=1`

Distribuciones recientes de Linux que emplean `gstreamer >=1`, requieren alguna de las siguientes librerías de video:

1. [Beta oficial](https://github.com/processing/processing-video/releases).
2. [Gohai port](https://github.com/gohai/processing-video/releases/tag/v1.0.2).

Descompriman el archivo `*.zip` en la caperta de `libraries` de su sketchbook (e.g., `$HOME/sketchbook/libraries`) y probar cuál de las dos va mejor.

## Integrantes

| Integrante | github nick |
|------------|-------------|
| Nicolás Restrepo Torres | [NicolasRestrepoTorres][NicolasRestrepoTorres_link] |
| Cristian David Gonzalez Carrillo | [crdgonzalezca][crdgonzalezca_link] |

[crdgonzalezca_link]:https://github.com/crdgonzalezca
[NicolasRestrepoTorres_link]:https://github.com/NicolasRestrepoTorres

## Discusión

### Imágenes

* Para el procesamiento de imágenes se hizo un solo programa el cual tiene una serie de botones para cambiar entre los diferentes procesamientos de la imagen seleccionada, este archivo es: `ImageManipulation/ImageManipulation.pde`:
* Se aplica a cada dos versiones con escala de grises, una donde se hace el promedio del RGB de cada píxel y se agrega este color como nuevo valor en la imagen transformada. La otra forma de hacer la escala de grises es aplicando el proceso _luma_, el cual le asigna pesos a cada componente del RGB del pixel. De esta manera, se puede ver que la escala de grises en el del promedio es más oscura y no queda tan bonita, en cambio con luma, es una mejor manera de obtener los grises, quedando una imagen no tan gris.
* Se aplican tres máscaras de convolución a la imagen seleccionada, como se listan a continuación:
  * Detección de bordes: se observa que los bordes quedan resaltados, dando una impresión de mayor textura sobre la imagen.
  * Difuminación de la imagen: esto se hace
  haciendo uso de del kernel Gaussian blur
  de 3x3. Con este kernel se obtiene una
  imagen totalmente desenfocada.
  * Máscara de desenfoque: aumenta el
  contraste de los bordes de los elementos
  sin incrementar el ruido o las
  imperfecciones de la imagen. Se puede ver
  una imagen un poco más definida, dando la
  impresión de mayor nitidez.
* Generación de histograma a partir de la imagen transformada a escala de grises. Este histograma se hace tomando el valor de  brillantes de cada pixel obteniendo la frecuencia entre 0 a 255 para así mostrar el correspondiente histograma. Este histograma por ende nos muestra que la mayor cantidad de valores sobre el centro, indicando que estamos trabajando sobre el promedio de las componentes RGB de la imagen original.
* Se segmenta la imagen de escala de grises, esta segmentación se realiza dividiendo el histograma en 4 partes, si la imagen en gris tiene una brillantez en la primera parte va a tener solor color rojo, la segunda parte verde y la tercera va a ser azul, la cuarta parte va a tomar un color gris que viene de la imagen en escala de grises. Esto nos muestra una segmentación clara de la imagen con diferentes colores.

### Video

* Para el procesamiento de videos se hizo un solo programa el cual tiene una serie de botones para cambiar entre los diferentes procesamientos de la imagen seleccionada, este archivo es: `ComputationalEfficiencyVideo/ComputationalEfficiencyVideo.pde`:

* Para procesar el video, primeramente notamos que se necesitaba instalar la librería de Video Processing y que GStreamer era parte de las librerías nativas de Linux/GNU. Este proceso no funcionaba desde la interfaz gráfica, sino, como se indicaba en las instrucciones, directamente copiando la librería en la carpeta de sketchbook. Tuvimos problemas con esto porque al revisar los releases de esta librería y de las otras, la última versión no beta tenía archivos que no funcionaban y daban problemas con GStreamer y otros drivers del mismo computador. Inclusive no reconocía el archivo de video y no podía abrirlo. Entonces al descargar la beta se soluciona este problema.
* Con base a lo que ya se había aplicado en la convolución de las imágenes, se entendió como se podía procesar un video en Processing. Primero se ejecuta el vídeo en bucle para que siempre haya un frame disponible en la función `available()`, y `read()` respectivamente. Cada vez que se lee un frame, se crea un `PGraphics` porque es hasta este momento, dónde está disponible la información del ancho y el largo, luego se toma este frame como si fuera un PImage, ya que Processing lo permite y se aplica la misma convolución, filtro o promedio y se dibuja en el canvas, esto hace que las imágenes consecutivas vayan aplicando un filtro y aparezcan como un video sobre el canvas.
* Lo que se en cuanto a la **eficiencia computacional** es que a medida que sea más compleja la operación, los cuadros por segundo van a disminuir para que el video se siga viendo fluido. En _Luma_ y en el promedio, que son operaciones computacionalmente no complejas: O(n), donde n es la cantidad de píxeles. En cambio, en las máscaras de convolución que se aplicaron la operación, hay una complejidad general de O(N^2) si es que no hay una optimización en ciertos casos por medio de una FFT. En la beta oficial La tasa de refresco ronda por los 30 cuadros por segundo cuando la convolución no es muy complicada como en el _sharpenKernel_, si aplicamos la convolución más compleja que es el denominado blurKernel5 que es una versión del _blurKernel_ usual pero con una matriz de 5x5, la tasa de refresco cae entre los 10 y los 20 cuadros por segundo, mientras que en el _blurKernel_ normal ronda entre los 25 y 35 cuadros por segundo.

* En conclusión, la operación de convolución que tiene una complejidad computacional muy parecida a la multiplicación matricial, necesita algoritmos especiales como el _Solvay Strassen_ o hardware dedicado como las tarjetas gráficas para que su implementación en otras aplicaciones reales, no se vea realmente afectada.

## Entrega

* Plazo para hacer _push_ del repositorio a github: 29/9/19 a las 24h.
