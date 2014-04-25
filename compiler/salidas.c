
#include <config.h>

#include "salidas.h"

int salidas[256][32];
int ultConexion = -1;

void
PrepararSalidas (void)
{
  int i, j;
  for (i = 0; i < 256; i++)
    for (j = 0; j < 16; j++)
	{
      salidas[i][j*2] = 0;	
	  salidas[i][j*2+1] = -1;	/* Destino -1 = No hay destino */
	}

}

void
PonerSalida (int origen, int direccion, int destino)
{
  salidas[origen][direccion * 2] = direccion;
  salidas[origen][direccion * 2 + 1] = destino;
}

int
Salida (int origen, int direccion)
{
  return salidas[origen][direccion * 2 + 1];
}

void
dumpSalidas (void)
{

};
