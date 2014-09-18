
#include "config.h"

#include "objetos.h"
#include <stdio.h>

TipoObjeto objetos[256];

void
PonerObjeto (int num, TipoObjeto obj)
{
  objetos[num] = obj;
};

