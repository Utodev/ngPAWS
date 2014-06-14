
/* Cabecera de condactos */

#include <config.h>

#define NUMCONDACTOS 124
#define CONDACTOS_USUARIO 256



typedef enum
{ nada, flagno, value, percent, objno, mesno,
  smesno, prono, locno, locno_, adjective,
  adverb, preposition, noun, string
}
tipoArg;

typedef enum
{ aNada, aDescribir, aEnd, aFinDeTabla, aCondicional, aHook }
tipoLimpieza;

typedef enum
{ condicion, accion, mixto }
tipoCondacto;

typedef struct
{
  char *nombre;
  tipoCondacto tipo;
  tipoArg tipoArg1, tipoArg2, tipoArg3;
  tipoLimpieza limpieza;
}
TipoCondacto;

extern TipoCondacto condactos[NUMCONDACTOS + CONDACTOS_USUARIO];

int BuscarCondacto (const char *nombre, TipoCondacto * condacto);

void InicializaCondactos ();



