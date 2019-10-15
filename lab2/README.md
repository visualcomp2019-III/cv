# Taller ilusiones visuales

## Propósito

Comprender algunos aspectos fundamentales de la [inferencia inconsciente](https://github.com/VisualComputing/Cognitive) de la percepción visual humana.

## Tareas

Implementar al menos 6 ilusiones de tres tipos distintos (paradójicas, geométricas, ambiguas, etc.), al menos dos con movimiento y dos con interactividad.

*Recomendación:* implementar el código desde ceros.

## Integrantes

| Integrante | github nick |
|------------|-------------|
| Nicolás Restrepo Torres | [NicolasRestrepoTorres][NicolasRestrepoTorres_link] |
| Cristian David Gonzalez Carrillo | [crdgonzalezca][crdgonzalezca_link] |

## Discusión

1. Complete la tabla

| Ilusión | Categoria | Referencia | Tipo de interactividad (si aplica) | URL código base (si aplica) |
|---------|-----------|------------|------------------------------------|-----------------------------|
| Titled table | Geométrica | [Ilusión de referencia][titled-table-link] | Cambiar orientación de las líneas internas y desaparecer las lineas internas | |
| Devil's Fork | Paradojica |[Ilusión de referencia][devils-fork]|                                    |                             |
| Reverse Spoke Illusion | Geométrica | [Ilusión de referencia][reverse-spoke-link] | Cambiar espectro con scrollbar y cambiar velocidad con teclado | |
| Shaded Diamonds | Fisiológica | [Ilusión de referencia][shaded-diamonds-link]| | [Para el gradiente del color][color-gradient]|
| Kaleidoscope Motion | Movimiento | [Ilusión de referencia][kaleidoscope-link]| Teclado para cambiar velocidad | [Referencia para dibujar cada figura][kaleidoscope-reference-link]|
| Checker illusion | Fisiológica | [Ilusión de referencia][checker-illusion]| Se puede redibujar la ilusión para que hayan distintas curvas formadas por los rombos internos||

2.Describa brevememente las referencias estudiadas y los posibles temas en los que le gustaría profundizar

Todas las referencias que tuvimos en cuenta eran ejemplos que nos acercaban a una ilusión y las intentamos imitar o alterar para llegar de una forma similar a obtener la misma ilusión. Para esto usamos principalmente la página de ilusiones [Michael Bach][michael-bach-link] en la que hacen una buena explicación de cada ilusión y se puede interacturar con estas.

La ilusión que mejor cumple su efecto es la segunda, en la que el contraste hace que las líneas indistintamente parece que giraran, es un efecto simple pero poderoso en la vista, a pesar de esto, nos gustaria profundizar en alguna oportunidad en la posibilidad de crear ilusiones ambiguas de una manera más sistemica, es bien conocido la clásica de la [princesa y el viejo](https://michaelbach.de/ot/cog-rotations/index.html) pero parece que existe una cuestión más artistica en la creación de esta porque no se podría generalizar a simple vista como se podrían construir esta.

## Entrega

* Plazo para hacer _push_ del repositorio a github: ~~6/10/19~~ 14/10/19 a las 24h.

[crdgonzalezca_link]:https://github.com/crdgonzalezca
[NicolasRestrepoTorres_link]:https://github.com/NicolasRestrepoTorres
[reverse-spoke-link]:https://michaelbach.de/ot/mot-spokes/index.html
[kaleidoscope-link]: https://michaelbach.de/ot/mot-kaleidoscope/index.html
[kaleidoscope-reference-link]: https://processing.org/examples/star.html
[shaded-diamonds-link]: https://michaelbach.de/ot/lum-diamond/index.html
[color-gradient]: https://processing.org/examples/lineargradient.html
[michael-bach-link]: https://michaelbach.de
[titled-table-link]: https://michaelbach.de/ot/ang-tiltedTable/index.html
[checker-illusion]: https://co.pinterest.com/pin/445223113150338449/?nic=1
[devils-fork]: https://michaelbach.de/ot/cog-imposs1/index.html
