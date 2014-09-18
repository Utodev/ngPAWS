
#include "config.h"

typedef struct
{
  int lugar, peso, lo_flags, hi_flags, nombre, adjetivo;
}
TipoObjeto;

extern TipoObjeto objetos[256];

void PonerObjeto (int, TipoObjeto);


