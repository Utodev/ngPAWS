Lib name: draw_picture_svg_lib
Overrides: drawPicture()
Use: seldom, quite specific
Installation: copy `draw_picture_svg_lib` to project `jsl` folder and compile the game.

About: This library overrides the way ngPAWS shows the svg images in html. For general cases, default behaviour is perfect, but in my case I stretch the use of the svg.
Having, for example, a svg embeded into another svg, default behaviour will not show the composed picture. Example:

```
/
| base.svg <svg [...]></svg>
| composed.svg | base.svg <svg [...]><image xlink:href="base.svg"></svg>
```
Default `drawPicture()` will show and empty `composed.svg`
This lib will add a `<object>` round the svg and display the `composed.svg` and it's linked `base.svg`

