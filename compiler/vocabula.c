
/* vocabula.c */

#include "config.h"

#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <stdio.h>
#include "vocabula.h"
#include "errores.h"
#include "comun.h"

char wordFound[256];

typedef struct _NODO
{
  TipoPalabra palabra;
  struct _NODO *sig;
}
TipoNodo;

typedef TipoNodo *PNodo;

typedef struct _LIST
{
  unsigned int nElem;
  PNodo rootNode;
} TipoLista;

TipoLista lista;

void
InicializarVocabulario (void)
{
  lista.rootNode = NULL;
  lista.nElem = 0;
}


void
NuevaPalabra (char *palabra, TiposDePalabra tipo, unsigned int numero)
{
  PNodo nueva, actual, anterior;

//  CheckWord(char *palabra);

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

  if (lista.rootNode == NULL)
    {
      lista.rootNode = nueva;
      lista.nElem = 1;
    }
  else
    {
      actual = lista.rootNode;
      anterior = actual;
      /* is not last one *//* new word should be after the current one */
      while ((actual->sig != NULL)
	     && (strcmp (nueva->palabra.pal, actual->palabra.pal) > 0))
	{
	  anterior = actual;
	  actual = actual->sig;
	}
      /* new word should be previous to new one*/
      if (strcmp (nueva->palabra.pal, actual->palabra.pal) < 0)
	{
	  if (actual == lista.rootNode)
	    {
	      nueva->sig = lista.rootNode;
	      lista.rootNode = nueva;
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

void FinalizarVocabulario(void)
{
  PNodo actual, borrable;

  borrable = lista.rootNode;

  while (borrable != NULL)
    {
      actual = borrable->sig;
      free (borrable);
      borrable = actual;
    }
}

int BuscarPalabra (char *txt, TipoPalabra * pal)
{
  PNodo dev;
  char texto[11];
  strncpy (texto, txt, 10);
  texto[10] = 0;
  for (dev = lista.rootNode; dev != NULL; dev = dev->sig)
    {
      if (!strcmp (dev->palabra.pal, texto))
	break;
    };
  if (dev == NULL) return FALSE;
  pal->pal = strdup (dev->palabra.pal);
  pal->tipo = dev->palabra.tipo;
  pal->num = dev->palabra.num;
  return TRUE;
}

void dumpPalabras (void)
{
  PNodo dev;
  for (dev = lista.rootNode; dev != NULL; dev = dev->sig)
    printf ("%s %d %d\n", dev->palabra.pal, dev->palabra.tipo, dev->palabra.num);
};


PPalabra SiguientePalabra (PPalabra anterior)
{
  PNodo actual;
  actual = lista.rootNode;

  if (anterior == NULL)		/* first one requested */
    if (actual == NULL)  return NULL;
    else return &(actual->palabra);

  while ((actual != NULL) && (&(actual->palabra) != anterior))
    actual = actual->sig;

  if (actual == NULL) return NULL;
  else if (actual->sig == NULL) return NULL;
  else return &(actual->sig->palabra);
}

char * BuscarPalabraPorNumero (int nPalABuscar, TiposDePalabra tipo)
{
  PNodo dev;
  strcpy (wordFound, "");
  if (nPalABuscar == -1)
    {
      strcpy (wordFound, "_");
      return wordFound;
    }

  for (dev = lista.rootNode; dev != NULL; dev = dev->sig)
    {
      if ((dev->palabra.num == nPalABuscar) && (dev->palabra.tipo == tipo))
	break;
    };

  if (dev != NULL) strcpy (wordFound, dev->palabra.pal);
  return wordFound;
}

