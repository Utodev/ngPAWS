
/* errores.c */

#include "config.h"

#include <stdio.h>
#include <stdlib.h>
#include "errores.h"
#include "lexico.h"
#include "vocabula.h"


void blockError(int nError, int line)
{
	 printf ("%s:%d:", nombre_archivo, --line);
	 switch (nError)
	 {
	 case 0:  printf (":B010: Block error: unexpected '}'.\n");
	     break;
		 case 1:  printf (":B020: Block error: block is not closed.\n");
	     break;
	 }
	 exit(-1);

}

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
	  printf ("::G010: General error: invalid command, input file missing.\n");
	  break;
	case 1:
	  printf ("%s:%d:G020: General error: out of memory.\n", nombre_archivo, lineaLeida);
	  break;
	case 2:
	  printf ("%s:%d:G030: General error: error while loading plugins.\n", nombre_archivo, lineaLeida);
	  break;
	case 3:
	  printf ("%s:%d:G040: General error: error while loading plugins.\n", nombre_archivo, lineaLeida);
	  break;
	default:
	  printf ("%s:%d:G000: General error: generic error.\n");
	}
      break;
    case errLexSint:
      printf ("%s:%d:", nombre_archivo, lineaLeida);
      switch (nError)
	{
	case pcCtl:
	  printf ("L010: Syntax error: /ctl expected.\n");
	  break;
	case pcVoc:
	  printf ("L020: Syntax error: /voc expected.\n");
	  break;
	case pcOtx:
	  printf ("L030: Syntax error: /otx expected.\n");
	  break;
	case pcLtx:
	  printf ("L040: Syntax error: /ltx expected.\n");
	  break;
	case pcCon:
	  printf ("L050: Syntax error: /con expected.\n");
	  break;
	case pcStx:
	  printf ("L060: Syntax error: /stx expected.\n");
	  break;
	case pcMtx:
	  printf ("L070: Syntax error: /mtx expected.\n");
	  break;
	case pcObj:
	  printf ("L080: Syntax error: /obj expected.\n");
	  break;
	case pcPro:
	  printf ("L090: Syntax error: /pro expected.\n");
	  break;
	case pSubrayado:
	  printf ("L100: Syntax error: _ expected (underscore).\n");
	  break;
	case pPalabra:
	  printf ("L110: Syntax error: word expected.\n");
	  break;
	case pNumero:
	  printf ("L120: Syntax error: number expected.\n");
	  break;
	case pIdNumerico:
	  printf ("L130: Syntax error:  /number expected.\n");
	  break;
	case pFinal:
	  printf ("L140: Syntax error: EOF expected.\n");
	  break;
	case pDirectivaConfiguracion:
	  printf ("L150: Syntax error: invalid setup value.\n");
	  break;
	case pString:
	  printf ("L160: Syntax error: string expected.\n");
	  break;
	}
      /*printf (" en la linea %d.\n", lineaLeida);*/
      break;
    case sinError:
      printf (" none. Code compiled successfully.\n"); /* En teoria nunca se produce */
      break;
    case errVocab:
      printf ("%s:%d:", nombre_archivo, lineaLeida);
      switch (nError)
	{
	case 0:
	  printf ("V010: Vocabulary error: duplicated word.\n", lineaLeida);
	  break;
	}
      break;
    case errSem:
      printf ("%s:%d:", nombre_archivo, lineaLeida);
      switch (nError)
	{
	case 0:
	  printf ("S010: Semantic error: invalid word type.\n");
	  break;
	case 1:
	  printf ("S020: Semantic error: not consecutive text.\n");
	  break;
	case 2:
	  printf ("S030: Semantic error: too many texts.");
	  break;
	case 3:
	  printf ("S040: Semantic error: too few system messages.\n");
	  break;
	case 4:
	  printf ("S050: Semantic error: connections must be ordered by location number.\n");
	  break;
	case 5:
	  printf ("S060: Semantic error: \"%s\" is not a direction.\n", lexema);
	  break;
	case 6:
	  printf
	    ("S070: Semantic error: \"%s\" is not a valid value for that position.\n", lexema);
	  break;
	case 7:
	  printf
	    ("S080: Semantic error: found  \"%s\" in place of  \"and\", \"AND\" or \"_\".\n", lexema);
	  break;
	case 8:
	  printf ("S090: Semantic error: \"%s\" is not in the vocabulary.\n", lexema);
	  break;
	case 9:
	  printf ("S100: Semantic error: \"%s\" is not a noun in the vocabulary.\n", lexema);
	  break;
	case 10:
	  printf ("S110: Semantic error: \"%s\" is not an adjective in the vocabulary.\n", lexema);
	  break;
	case 11:
	  printf
	    ("S120: Semantic error: invalid object number or invalid order.\n", lexema);
	  break;
	case 12:
		printf ("S130: Semantic error: \"%s\" is not a condact or cannot be used with # or : modifiers.\n", lexema);
	  break;
	case 13:
	  printf
	    ("S140: Semantic error: invalid process number or invalid order.\n", lexema);
	  break;
	case 14:
	  printf ("S150: Semantic error: \"%s\" is not a verb in the vocabulary.\n", lexema);
	  break;
	case 15:
	  printf ("S160: Semantic error: value must be in the 0-255 range.\n");
	  break;
	case 16:
	  printf ("S170: Semantic error: value must be in the 1-99 range.\n");
	  break;
	case 17:
	  printf ("S180: Semantic error: invalid object number.\n");
	  break;
	case 18:
	  printf ("S190: Semantic error: invalid message number.\n");
	  break;
	case 19:
	  printf ("S200: Semantic error: invalid system message number.\n");
	  break;
	case 20:
	  printf ("S210: Semantic error: invalid process number.\n");
	  break;
	case 21:
	  printf ("S220: Semantic error: invalid location number.\n");
	  break;
	case 22:
	  printf ("S230: Semantic error: only one process can be tagged as \"interrupt\".\n");
	  break;
	case 23:
	  printf ("S240: Semantic error: \"INTERRUPT\" expected.\n");
	  break;
	case 24:
	  printf ("S250: Semantic error: Processes 0,1 and 2 cannot be tagged as interrupt..\n");
	  break;
	case 25:
	  printf ("S260: Semantic error: invalid object attributes definition.\n");
	  break;
	case 26:
	  printf ("S270: Semantic error: invalid binary definition, bit 32 cannot be 1 to avoid parameter to be considered as indirection.\n");
	  break;
		}
    }
  /*Semantic error(); */
  exit (-1);
}

