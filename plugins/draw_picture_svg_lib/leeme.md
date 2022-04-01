Nombre de la librería: draw_picture_svg_lib
Sobreescribe: drawPicture()
Uso: raro, bastante específico
Instalación: copia `draw_picture_svg_lib` en la carpeta `jsl` del proyecto y compila.

Información: Esta librería sobreescribe la forma que tiene ngPAWS de mostrar las imágenes svg en html que es perfecta para un uso general, pero en mi caso voy al límite.
Si tenemos por ejemplo un svg incrustado dentro de otro, por defecto, ngPAWS no mostrará la imagen compuesta. Ejemplo:

```
/
| base.svg <svg [...]></svg>
| compuesto.svg | base.svg <svg [...]><image xlink:href="base.svg"></svg>
```
La función por defecto `drawPicture()` mostrará un `composed.svg` vacío.
Con esta librería se añade un elemento `<object>` alrededor del svg y se muestra el `composed.svg` y su imagen enlazada `base.svg`

