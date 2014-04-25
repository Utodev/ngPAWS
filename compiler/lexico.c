/* lexico.c
 *
 * Este archivo hace el análisis léxico.
 *
 */

#include <config.h>

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

/* Definiciones para el analizador lexico */

#include "comun.h"
#include "lexico.h"
#include "errores.h"

/* Declaraciones del modulo */

void leerLinea (void);
void leerLineaDeTexto (void);
Simbolo siguienteSimbolo (void);
char *aMinusculas (char *);
char *aMayusculas (char *);
int esNumero (char *);
int BOL;

/* Variables del modulo */

char linea[32768];
char lineaCompleta[32768];
int inicial, caracter, longLinea;
int lineaLeida;
int finFichero, lineaVacia;
FILE *fin;
char lexema[2048];
Simbolo simbolo;

/* definicion de funciones */

int
esNumero (char *cad)
{
  unsigned int i;
  for (i = 0; i < strlen (cad); i++)
    if (!isdigit (cad[i]))
      return FALSE;
  return TRUE;
}

void
prepLexico (char *nomFich)
{
  if ((fin = fopen (nomFich, "rt")) == NULL)
    {
      error (errGeneral, 0);
    }
  finFichero = FALSE;
  lineaLeida = 0;
  leerLinea ();
  simbolo = siguienteSimbolo ();
}

void
leerLinea (void)
{
  if (fgets (linea, 32768, fin) == NULL)
    {
      finFichero = TRUE;
      return;
    }
  strcpy (lineaCompleta, linea);
  lineaLeida++;
  lineaVacia = FALSE;
  while ((linea[0] == '\n') || (linea[0] == ';'))
    {
      if (linea[0] == '\n')
	lineaVacia = TRUE;
      if (fgets (linea, 32768, fin) == NULL)
	{
	  finFichero = TRUE;
	  return;
	}
      strcpy (lineaCompleta, linea);
      lineaLeida++;
    }
  inicial = caracter = 0;
}

void
leerLineaDeTexto (void)
{
  if (fgets (linea, 32768, fin) == NULL)
    {
      finFichero = TRUE;
      return;
    }
  strcpy (lineaCompleta, linea);
  lineaLeida++;
  lineaVacia = FALSE;
  inicial = caracter = 0;
}

Simbolo
siguienteSimbolo (void)
{
  int escadena, esvariablecfg, concomentario;
  escadena=esvariablecfg=concomentario=0;
  BOL = FALSE;
  do
    {
      if (finFichero)
	return pFinal;
      while ((linea[inicial] == ' ') || (linea[inicial] == '\t'))
	inicial++;
      if ((linea[inicial] == '\n') || (linea[inicial] == 0)
	  || (linea[inicial] == ';'))
	{
	  leerLinea ();
	  if (finFichero)
	    return pFinal;
	}
    }
  while ((linea[inicial] == ' ') || (linea[inicial] == '\n')
	 || (linea[inicial] == '\t'));
  caracter = inicial;
  if (inicial == 0)
    BOL = TRUE;
  if ((linea[caracter] != 34) && (linea[caracter] != '$')) /* ni cadena ni variable de configuracion */
  {
   while ((linea[caracter] != ' ') && (linea[caracter] != '\t')
	 && (linea[caracter] != '\n') && (linea[caracter] != ';')
	 && (linea[caracter] != 0))
    caracter++;
  }
  else if(linea[caracter] == 34) /* Es una cadena */
  {
   inicial++;
   caracter++;
   while ((linea[caracter] != 34) && (linea[caracter] != 0))
    caracter++;
    escadena = 1;
  }
  else /* es una linea de configuracion */
  {
    inicial++;
    caracter++;
   while ((linea[caracter] != '\n') && (linea[caracter] != 0) && (linea[caracter] != ';'))
    caracter++;
   if(linea[caracter] == ';')concomentario=1;
   esvariablecfg = 1;
  }


  strncpy (lexema, linea + inicial, caracter - inicial);
  lexema[caracter - inicial] = 0;
  if (!escadena && !esvariablecfg) aMayusculas (lexema); /* Paso el lexema a mayusculas a no ser que sea una cadena */
	else caracter++;
  inicial = caracter;
  if(concomentario)inicial--;
  if (!strcmp (lexema, "/CTL"))
    return pcCtl;
  else if (!strcmp (lexema, "/VOC"))
    return pcVoc;
  else if (!strcmp (lexema, "/OTX"))
    return pcOtx;
  else if (!strcmp (lexema, "/LTX"))
    return pcLtx;
  else if (!strcmp (lexema, "/CON"))
    return pcCon;
  else if (!strcmp (lexema, "/STX"))
    return pcStx;
  else if (!strcmp (lexema, "/MTX"))
    return pcMtx;
  else if (!strcmp (lexema, "/OBJ"))
    return pcObj;
  else if (!strcmp (lexema, "/PRO"))
    return pcPro;
  else if (escadena)
	return pString;  
  else if (esvariablecfg)
    return pDirectivaConfiguracion;
  else if (!strcmp (lexema, "_"))
    return pSubrayado;
  else if (lexema[0] == '/')
    {
      if (esNumero (lexema + 1))
	return pIdNumerico;
      else
	return pPalabra;
    }
  else if (lexema[0] == '@')
   {
      if (esNumero(lexema+1))
      return pIndirect;
      else
      return pPalabra;	
   }  
  else if (esNumero (lexema))
    return pNumero;
  else
    return pPalabra;
}

Simbolo
siguienteSimboloSinLeer (void)
{
  BOL = FALSE;
  inicial = caracter = 0;
  /* do { */
  if (finFichero)
    return pFinal;
  while ((linea[inicial] == ' ') || (linea[inicial] == '\t'))
    inicial++;
  if ((linea[inicial] == '\n') || (linea[inicial] == 0)
      || (linea[inicial] == ';'))
    {
      /* leerLinea(); */
      if (finFichero)
	return pFinal;
      return pPalabra;
    }
  /* } while((linea[inicial]==' ')||(linea[inicial]=='\n')||(linea[inicial]=='\t')); */
  caracter = inicial;
  if (inicial == 0)
    BOL = TRUE;
  while ((linea[caracter] != ' ') && (linea[caracter] != '\t')
	 && (linea[caracter] != '\n') && (linea[caracter] != ';')
	 && (linea[caracter] != 0))
    caracter++;
  strncpy (lexema, linea + inicial, caracter - inicial);
  lexema[caracter - inicial] = 0;
  /*aMinusculas(lexema); */
  aMayusculas (lexema);
  inicial = caracter;
  if (!strcmp (lexema, "/CTL"))
    return pcCtl;
  else if (!strcmp (lexema, "/VOC"))
    return pcVoc;
  else if (!strcmp (lexema, "/OTX"))
    return pcOtx;
  else if (!strcmp (lexema, "/LTX"))
    return pcLtx;
  else if (!strcmp (lexema, "/CON"))
    return pcCon;
  else if (!strcmp (lexema, "/STX"))
    return pcStx;
  else if (!strcmp (lexema, "/MTX"))
    return pcMtx;
  else if (!strcmp (lexema, "/OBJ"))
    return pcObj;
  else if (!strcmp (lexema, "/PRO"))
    return pcPro;
  else if (!strcmp (lexema, "_"))
    return pSubrayado;
  else if (lexema[0] == '/')
    {
      if (esNumero (lexema + 1))
	{
	  leerLinea ();
	  return pIdNumerico;
	}
      else
	return pPalabra;
    }
  else if (lexema[0] == '@')
   {
      if (esNumero(lexema+1))
      return pIndirect;
      else
      return pPalabra;	
   }  
  else if (esNumero (lexema))
    {
      leerLinea ();
      return pNumero;
    }
  else
    return pPalabra;
}

char *
aMinusculas (char *cad)
{
  unsigned int i;
  char *cadena;
  cadena = (char *) malloc (strlen (cad) + 1);
  strcpy (cadena, cad);
  for (i = 0; i < strlen (cadena); i++)
    cadena[i] = tolower (cadena[i]);
  //strcpy(cad, cadena);
  return cadena;
}

char *
aMayusculas (char *cad)
{
  unsigned int i;
  for (i = 0; i < strlen (cad); i++)
  {
	  cad[i] = toupper (cad[i]);
	  if (cad[i]=='ñ') cad[i]='Ñ';
	  if (cad[i]=='ç') cad[i]='Ç';
  }
  return cad;
}

char *
extraerTexto ()
{
  char *texto, *fdl;
  int habiaTexto;

  habiaTexto = FALSE;
  if ((texto = (char *) malloc (strlen (lineaCompleta) + 4)) == NULL)
    error (errGeneral, 1);
  *texto = 0;
  if (lineaVacia)
    strcat (texto, "\n\n");
  strcat (texto, lineaCompleta);
  /*strcpy(texto,linea); */
  while (linea[0] != '/')
    {
      habiaTexto = TRUE;
      leerLineaDeTexto ();
      if (linea[0] == '\n')
	strcat (linea, "\n");
      if (linea[0] != '/')
	{
	  if ((texto =
	       (char *) realloc (texto,
				 strlen (texto) + strlen (linea) + 1)) ==
	      NULL)
	    error (errGeneral, 1);
	  strcat (texto, linea);
	}
    }
  if (!habiaTexto)
    {
      inicial = caracter = 0;
      simbolo = siguienteSimbolo ();
      return "";
    /*OJO*/}
  else
    {
      while ((fdl = strchr (texto, '\n')) != NULL)
	if (*(fdl + 1) == '\n')
	  {
	    *fdl = '\\';
	    *(fdl + 1) = 'n';
	  }
	else
	  *fdl = ' ';
      if (texto[strlen (texto) - 1] == ' ')
	texto[strlen (texto) - 1] = 0;
      else
	texto[strlen (texto)] = 0;
	      inicial = caracter = 0;
      simbolo = siguienteSimbolo ();
      return texto;
    }
}

void
casarLex (Simbolo sim)
{
  if (sim == simbolo)
    simbolo = siguienteSimbolo ();
  else
    error (errLexSint, sim);
}

void
casarLexSinLeer (Simbolo sim)
{
  if (sim == simbolo)
    simbolo = siguienteSimboloSinLeer ();
  else
    error (errLexSint, sim);
}

void
termLexico ()
{
  fclose (fin);
}
