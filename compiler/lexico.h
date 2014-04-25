/* lexico.h */

/* Declaraciones para el analizador lexico */

/* Tipos globales */

#include <config.h>

typedef enum
{ pError, pcCtl, pcVoc, pcOtx, pcLtx, pcCon, pcStx,
  pcMtx, pcObj, pcPro, pSubrayado, pPalabra, pNumero,
  pIdNumerico, pFinal, pIndirect, pString, pDirectivaConfiguracion
}
Simbolo;

/* Variables globales */

extern char lexema[2048];
extern char *nombre_archivo;
extern Simbolo simbolo;
extern int lineaLeida;
extern int BOL;

/* Funciones globales */

void prepLexico (char *);
void casarLex (Simbolo);
void casarLexSinLeer (Simbolo);
char *extraerTexto (void);
void termLexico (void);
char *aMinusculas (char *);
char *aMayusculas (char *);
