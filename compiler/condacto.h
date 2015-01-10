
#include "config.h"

#define NUMCONDACTS 127
#define USERCONDACTS 256



typedef enum
{ nada, flagno, value, percent, objno, mesno,  smesno, prono, locno, locno_, adjective,
  adverb, preposition, noun, string, verb } tipoArg;

typedef enum { aNada, aDescribir, aEnd, aFinDeTabla, aCondicional, aHook} tipoLimpieza;

typedef enum { condicion, accion, mixto, dot, colon, blockStart, blockEnd, waitkey } tipoCondacto;

typedef struct
{
  char *nombre;
  tipoCondacto tipo;
  tipoArg tipoArg1, tipoArg2, tipoArg3;
  tipoLimpieza limpieza;
} TipoCondacto;

extern TipoCondacto condactos[NUMCONDACTS + USERCONDACTS];
extern char *path_archivo;

int BuscarCondacto (const char *nombre, TipoCondacto * condacto, int forceCondition);

void InicializaCondactos ();



