
#include "config.h"

#include "procesos.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

TipoEntrada *procesos[256];

int ultProceso = 2;
int interrupt_proc = -1;

void
NuevoProceso (int numPro)
{
  procesos[numPro] = NULL;
};

void
agregarEntrada (int numPro, TipoEntrada * entrada)
{
  TipoEntrada *e;
  if (procesos[numPro] == NULL)
    procesos[numPro] = entrada;
  else
    {
      for (e = procesos[numPro]; e->sig != NULL; e = e->sig);
      entrada->sig = NULL;
      entrada->condactos[0] = 0;
      e->sig = entrada;
    }
}

void
agregarCondacto (int numPro, int cond, int arg1, int arg2, int arg3)
{
  TipoEntrada *e;
  for (e = procesos[numPro]; e->sig != NULL; e = e->sig);
  e->condactos[e->posicion] = cond;
  (e->posicion)++;
  e->condactos[e->posicion] = arg1;
  (e->posicion)++;
  e->condactos[e->posicion] = arg2;
  (e->posicion)++;
  e->condactos[e->posicion] = arg3;
  (e->posicion)++;
};

void
FinalizarProcesos (void)
{
  TipoEntrada *e, *a;
  int i;
  for (i = 0; i < 256; i++)
    if (procesos[i] != NULL)
      {
	a = e = procesos[i];
	while (a != NULL)
	  {
	    a = e->sig;
	    free (e);
	    e = a;
	  }
      }
};

TipoEntrada *
SiguienteEntrada (int numProceso, TipoEntrada * anterior)
{
  TipoEntrada *actual;
  actual = procesos[numProceso];

  if (anterior == NULL)		/* piden la primera */
    return actual;

  while ((actual != NULL) && (actual != anterior))
    actual = actual->sig;
  if (actual == NULL)
    return NULL;
  else
    return actual->sig;
}
