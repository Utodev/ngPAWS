ngPAWS authoring system
=======================

ngPAWS (pronunced n-g-paws) is an authoring system based on the Professional Adventure
Writing System, thus the name ngPAWS stands for "next generation PAWS". 

PAWS was an authoring system widely used in UK and Spain in the later 80s and early 90s,
being the version for Sinclair ZX Spectrum the most well known, though there have been 
version for CP/M (Amstrad CPC, PCW) and IBM PC. Also, there are several clones of PAW 
made in the 90s, 2000, and 2010s.

What makes ngPAWS different?
----------------------------
What makes ngPAWS different is it does not generate an executable file, but a website. 
In fact, it generates javascript code that can be run in any modern browser. So text
adventures (aka interactive fiction) made with ngPAWS can be run in any web server, or 
locally.


txtpaws
-------
txtpaws is a preprocessor able to convert identifiers into the numbers used by PAWS or 
ngPAWS, so you can make orders like "GOTO lForest" instead of "GOTO 12". It is very
helpful and though you can work with ngPAWS without it is not recommended.




Documentation
-------------

For detailed documentation please check github wiki:

https://github.com/Utodev/ngPAWS/wiki


Reporting bugs
--------------

If you found any bugs please report it using Github issue manager:

https://github.com/Utodev/ngPAWS/issues


Quick start: how to compile my first game?
------------------------------------------

1) Get ngpc (ngPAWS compiler) and txtpaws (https://github.com/Baltasarq/txtpaws) 
   binaries and put them in some folder.
2) Get the jsl folder and put it in the same folder (or set the enviroment variable
   NGPAWS_LIBPATH to the folder where the jsl folder contents are)
3) Copy the new_game_pack folder contents to some other folder (it will be the game 
    working folder)
4) From the game working folder, run the following commands:

<path to binaries>/txtpaws -I"dat/" code.txp
<path to binaries>/ngpc code.sce

For instance:

~/bin/txtpaws -I"dat/" code.txp
~/bin/ngpc code.sce

or

C:\UTILS\txtpaws -I"dat/" code.txp
C:\UTILS\bin\ngpc code.sce


If everything went fine you will have now a code.js file in your working folder, and 
you can start index.html file with your  favorite browser.


License
-------
The compiler was developed first by Yokiyoki for his PAW clone "Paguaglús", it has been 
modified during the years by me (Carlos Sanchez) for the Superglus project and now
I have adapted it to generate javascript instead. It's (C) Yokiyoki and Carlos Sanchez and
it's released under the GPL license.

The jsl libraries all can be used in your games, so they all use the more flexible 
MIT license. All of them are (C) Carlos Sánchez.