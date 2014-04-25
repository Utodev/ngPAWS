
/* vocabula.c */

#include <config.h>

#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <stdio.h>
#include "vocabula.h"
#include "errores.h"
#include "comun.h"

char palEncontrada[256];

typedef struct _NODO
{
  TipoPalabra palabra;
  struct _NODO *sig;
}
TipoNodo;

typedef TipoNodo *PNodo;

typedef struct _LISTA
{
  unsigned int nElem;
  PNodo cabeza;
}
TipoLista;

TipoLista lista;

void
InicializarVocabulario (void)
{
  lista.cabeza = NULL;
  lista.nElem = 0;
}


void
NuevaPalabra (char *palabra, TiposDePalabra tipo, unsigned int numero)
{
  PNodo nueva, actual, anterior;

//  CompruebaPalabra(char *palabra);

  nueva = (PNodo) malloc (sizeof (TipoNodo));
  nueva->palabra.pal = (char *) malloc (11);
  strncpy (nueva->palabra.pal, palabra, 10);
  nueva->palabra.pal[10] = 0;
  if (strlen (palabra) > 10)
    nueva->palabra.pal[10] = 0;
  else
    nueva->palabra.pal[strlen (palabra)] = 0;
  nueva->palabra.tipo = tipo;
  nueva->palabra.num = numero;
  nueva->sig = NULL;

  if (lista.cabeza == NULL)
    {
      lista.cabeza = nueva;
      lista.nElem = 1;
    }
  else
    {
      actual = lista.cabeza;
      anterior = actual;
      /* no es la ultima *//* la nueva palabra es posterior a la actual */
      while ((actual->sig != NULL)
	     && (strcmp (nueva->palabra.pal, actual->palabra.pal) > 0))
	{
	  anterior = actual;
	  actual = actual->sig;
	}
      /* la nueva palabra es anterior a la actual */
      if (strcmp (nueva->palabra.pal, actual->palabra.pal) < 0)
	{
	  if (actual == lista.cabeza)
	    {
	      nueva->sig = lista.cabeza;
	      lista.cabeza = nueva;
	    }
	  else
	    {
	      anterior->sig = nueva;
	      nueva->sig = actual;
	    }
	}
      else if (strcmp (nueva->palabra.pal, actual->palabra.pal) > 0)
	{
	  actual->sig = nueva;
	}
      else
	error (errVocab, 0);
      lista.nElem++;
    }
}

void
FinalizarVocabulario (void)
{
  PNodo actual, borrable;

  borrable = lista.cabeza;

  while (borrable != NULL)
    {
      actual = borrable->sig;
      free (borrable);
      borrable = actual;
    }
}

int
BuscarPalabra (char *txt, TipoPalabra * pal)
{
  PNodo dev;
  char texto[11];
  strncpy (texto, txt, 10);
  texto[10] = 0;
  /*dev = lista.cabeza; */
  for (dev = lista.cabeza; dev != NULL; dev = dev->sig)
    {
      if (!strcmp (dev->palabra.pal, texto))
	break;
    };
  if (dev == NULL)
    return FALSE;
  /*strcpy(pal->pal,dev->palabra.pal); */
  pal->pal = strdup (dev->palabra.pal);
  pal->tipo = dev->palabra.tipo;
  pal->num = dev->palabra.num;
  return TRUE;
}

void dumpPalabras (void)
{
  PNodo dev;
  /*dev = lista.cabeza; */
  for (dev = lista.cabeza; dev != NULL; dev = dev->sig)
    printf ("%s %d %d\n", dev->palabra.pal, dev->palabra.tipo,
	    dev->palabra.num);
};


PPalabra SiguientePalabra (PPalabra anterior)
{
  PNodo actual;
  actual = lista.cabeza;

  if (anterior == NULL)		/* piden la primera */
    if (actual == NULL)
      return NULL;
    else
      return &(actual->palabra);

  while ((actual != NULL) && (&(actual->palabra) != anterior))
    actual = actual->sig;
  if (actual == NULL)
    return NULL;
  else if (actual->sig == NULL)
    return NULL;
  else
    return &(actual->sig->palabra);
}

char * BuscarPalabraPorNumero (int nPalABuscar, TiposDePalabra tipo)
{
  PNodo dev;
  strcpy (palEncontrada, "");
  if (nPalABuscar == -1)
    {
      strcpy (palEncontrada, "_");
      return palEncontrada;
    }
  /*dev = lista.cabeza; */
  for (dev = lista.cabeza; dev != NULL; dev = dev->sig)
    {
      if ((dev->palabra.num == nPalABuscar) && (dev->palabra.tipo == tipo))
	break;
    };
  if (dev != NULL)
    strcpy (palEncontrada, dev->palabra.pal);
  return palEncontrada;
}

/* fin de vocabula.c */
