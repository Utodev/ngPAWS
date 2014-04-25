
/* errores.c */

#include <config.h>

#include <stdio.h>
#include <stdlib.h>
#include "errores.h"
#include "lexico.h"
#include "vocabula.h"

void
error (tipoError tipo, int nError)
{
  //printf ("Error");
  switch (tipo)
    {
    case errGeneral:
      switch (nError)
	{
	case 0:
	  printf ("::G010: Error general: comando no valido, falta el fichero de entrada.\n");
	  break;
	case 1:
	  printf ("%s:%d:G020: Error general: no hay suficiente memoria.\n", nombre_archivo, lineaLeida);
	  break;
	case 2:
	  printf ("%s:%d:G030: Error general: error en carga de plugins.\n", nombre_archivo, lineaLeida);
	  break;
	case 3:
	  printf ("%s:%d:G040: Error general: error en carga de plugins.\n", nombre_archivo, lineaLeida);
	  break;
	default:
	  printf ("%s:%d:G000: Error general: error generico.\n");
	}
      break;
    case errLexSint:
      printf ("%s:%d:", nombre_archivo, lineaLeida);
      switch (nError)
	{
	case pcCtl:
	  printf ("L010: Error sintactico: se esperaba /ctl.\n");
	  break;
	case pcVoc:
	  printf ("L020: Error sintactico: se esperaba /voc.\n");
	  break;
	case pcOtx:
	  printf ("L030: Error sintactico: se esperaba /otx.\n");
	  break;
	case pcLtx:
	  printf ("L040: Error sintactico: se esperaba /ltx.\n");
	  break;
	case pcCon:
	  printf ("L050: Error sintactico: se esperaba /con.\n");
	  break;
	case pcStx:
	  printf ("L060: Error sintactico: se esperaba /stx.\n");
	  break;
	case pcMtx:
	  printf ("L070: Error sintactico: se esperaba /mtx.\n");
	  break;
	case pcObj:
	  printf ("L080: Error sintactico: se esperaba /obj.\n");
	  break;
	case pcPro:
	  printf ("L090: Error sintactico: se esperaba /pro.\n");
	  break;
	case pSubrayado:
	  printf ("L100: Error sintactico: se esperaba _ (guion bajo).\n");
	  break;
	case pPalabra:
	  printf ("L110: Error sintactico: se esperaba una palabra.\n");
	  break;
	case pNumero:
	  printf ("L120: Error sintactico: se esperaba un numero.\n");
	  break;
	case pIdNumerico:
	  printf ("L130: Error sintactico: se esperaba /numero.\n");
	  break;
	case pFinal:
	  printf ("L140: Error sintactico: se esperaba final de fichero.\n");
	  break;
	case pDirectivaConfiguracion:
	  printf ("L150: Error sintactico: variable de configuracion no valida.\n");
	  break;
	}
      /*printf (" en la linea %d.\n", lineaLeida);*/
      break;
    case sinError:
      printf (" ninguno. Compilacion terminada.\n"); /* En teoria nunca se produce */
      break;
    case errVocab:
      printf ("%s:%d:", nombre_archivo, lineaLeida);
      switch (nError)
	{
	case 0:
	  printf ("V010: Error de vocabulario: palabra duplicada.\n", lineaLeida);
	  break;
	}
      break;
    case errSem:
      printf ("%s:%d:", nombre_archivo, lineaLeida);
      switch (nError)
	{
	case 0:
	  printf ("S010: Error semantico: el tipo de palabra no es valido.\n");
	  break;
	case 1:
	  printf ("S020: Error semantico: texto no consecutivo.\n");
	  break;
	case 2:
	  printf ("S030: Error semantico: demasiados textos.");
	  break;
	case 3:
	  printf ("S040: Error semantico: pocos textos de sistema.\n");
	  break;
	case 4:
	  printf ("S050: Error semantico: conexiones desordenadas.\n");
	  break;
	case 5:
	  printf ("S060: Error semantico: \"%s\" no es una direccion.\n", lexema);
	  break;
	case 6:
	  printf
	    ("S070: Error semantico: \"%s\" no es un valor valido para la posicion.\n", lexema);
	  break;
	case 7:
	  printf
	    ("S080: Error semantico: se encontro \"%s\" en lugar de \"y\", \"Y\" o \"_\".\n", lexema);
	  break;
	case 8:
	  printf ("S090: Error semantico: \"%s\" no es una palabra del vocabulario.\n", lexema);
	  break;
	case 9:
	  printf ("S100: Error semantico: \"%s\" no es un nombre del vocabulario.\n", lexema);
	  break;
	case 10:
	  printf ("S110: Error semantico: \"%s\" no es un adjetivo del vocabulario.\n", lexema);
	  break;
	case 11:
	  printf
	    ("S120: Error semantico: numero de objeto no valido u orden incorrecto.\n", lexema);
	  break;
	case 12:
	  printf ("S130: Error semantico: \"%s\" no es un condacto.\n", lexema);
	  break;
	case 13:
	  printf
	    ("S140: Error semantico: numero de proceso no valido u orden incorrecto.\n", lexema);
	  break;
	case 14:
	  printf ("S150: Error semantico: \"%s\" no es un verbo del vocabulario.\n", lexema);
	  break;
	case 15:
	  printf ("S160: Error semantico: el valor debe estar entre 0 y 255.\n");
	  break;
	case 16:
	  printf ("S170: Error semantico: el valor debe estar entre 1 y 99.\n");
	  break;
	case 17:
	  printf ("S180: Error semantico: numero de objeto no valido.\n");
	  break;
	case 18:
	  printf ("S190: Error semantico: numero de mensaje no valido.\n");
	  break;
	case 19:
	  printf ("S200: Error semantico: numero de mensaje del sistema no valido.\n");
	  break;
	case 20:
	  printf ("S210: Error semantico: numero de proceso no valido.\n");
	  break;
	case 21:
	  printf ("S220: Error semantico: numero de localidad no valido.\n");
	  break;
	case 22:
	  printf ("S230: Error semantico: solo un proceso puede ser de interrupcion.\n");
	  break;
	case 23:
	  printf ("S240: Error semantico: Se esperaba \"INTERRUPT\".\n");
	  break;
	case 24:
	  printf ("S250: Error semantico: los procesos 0,1 y 2 no pueden ser procesos de interrupcion.\n");
	  break;
	case 25:
	  printf ("S260: Error semantico: definición de atributos de objeto no válida.\n");
	  break;
		}
    }
  /*FinalizarVocabulario(); */
  exit (-1);
}
