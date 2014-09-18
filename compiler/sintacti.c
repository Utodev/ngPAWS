
/* sintacti.c */

#include "config.h"

#include "lexico.h"
#include "sintacti.h"
#include "errores.h"
#include "vocabula.h"
#include "salidas.h"
#include "textos.h"
#include "objetos.h"
#include "comun.h"
#include "condacto.h"
#include "procesos.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

TipoPalabra palabra;
TipoObjeto objeto;
TipoEntrada *entrada;
TipoCondacto condacto;

/*int ultConexion=-1;*/
/*int ultProceso=2;*/

/* cabeceras de funciones del analizador sintactico */

void anFichPaw (void);
void anSeccionCtl (void);
void anSeccionVoc (void);
void anSeccionOtx (void);
void anSeccionLtx (void);
void anSeccionCon (void);
void anSeccionStx (void);
void anSeccionMtx (void);
void anSeccionObj (void);
void anProcesos (void);

void anDirectivaConfiguracion(void);
void anEntradasVoc (void);
void anEntradaVoc (void);
void anTextosObjetos (void);
void anTextosLugares (void);
void anConexiones (void);
void anSalidas (int);
void anTextosSistema (void);
void anTextosMensajes (void);
void anDefinicionesObjetos (void);
void anDefObjeto (int);
void anLugar (TipoObjeto *);
void anAdjetivo (TipoObjeto *);
void anProceso (int);
void anEntradas (int);
void anEntrada (int);
void anVerbo (TipoEntrada *);
void anNombre (TipoEntrada *);
void anCondactos (int);
void anCondacto (int);
void anMasCondactos (int);
void anArgs (int *a1, int *a2, int *a3);
void anSiNo (int *);

int
Val (const char *numero)
{
  int res;
  sscanf (numero, "%d", &res);
  return res;
}

/* Analizador sintactico */

void
checkArg (int *a1, tipoArg tipo)
{
	
  int i;
  char *texto;


  if (simbolo==pIndirect)
  {
  	tipo=flagno;
  	for (i=0 ; lexema[i]!=0 && i<256 ; i++) lexema[i] = lexema[i+1];
  }
	
  switch (tipo)
    {
    case nada:
      break;
    case value:
      if (simbolo == pNumero)
	{
	  *a1 = Val (lexema);
	  /*if ((*a1 > 255) || (*a1 < 0))
	    error (errSem, 15);*/
	}
      casarLex (pNumero);
      break;
    case flagno:
      if (simbolo == pNumero)
	{
	  *a1 = Val (lexema);
	  if ((*a1 > 255) || (*a1 < 0))
	    error (errSem, 15);
	}
      if (simbolo == pIndirect)
	{
	  *a1 = Val (lexema);
	  if ((*a1 > 255) || (*a1 < 0))
	    error (errSem, 15);
	  *a1 = *a1 | 0x80000000; /* Añado bit 31 a 1 para indicar direccionamiento indirecto */
	  casarLex (pIndirect);  
	  break;
	}
      casarLex (pNumero);
      break;
    case percent:
      if (simbolo == pNumero)
	{
	  *a1 = Val (lexema);
	  if ((*a1 > 99) || (*a1 < 1))
	    error (errSem, 16);
	}
      casarLex (pNumero);
      break;
    case objno:
      if (simbolo == pNumero)
	{
	  *a1 = Val (lexema);
	  if ((*a1 > ultTextoObjeto) || (*a1 < 0))
	    error (errSem, 17);
	}
      casarLex (pNumero);
      break;
    case mesno:
      if (simbolo == pNumero)
	{
	  *a1 = Val (lexema);
	  if ((*a1 > ultTextoMensaje) || (*a1 < 0))
	    error (errSem, 18);
	}
      casarLex (pNumero);
      break;
    case smesno:
      if (simbolo == pNumero)
	{
	  *a1 = Val (lexema);
	  if ((*a1 > ultTextoSistema) || (*a1 < 0))
	    error (errSem, 19);
	}
      casarLex (pNumero);
      break;
    case prono:
      if (simbolo == pNumero)
	{
	  *a1 = Val (lexema);
	  if ((*a1 > 255) || (*a1 < 0))
	    error (errSem, 20);
	  if (*a1 > ultProceso)
	    ultProceso = *a1;
	}
      casarLex (pNumero);
      break;
    case locno:
      if (simbolo == pNumero)
	{
	  *a1 = Val (lexema);
	  if ((*a1 > ultTextoLugar) || (*a1 < 0))
	    error (errSem, 21);
	}
      casarLex (pNumero);
      break;
    case locno_:
      if (simbolo == pNumero)
	{
	  *a1 = Val (lexema);
	  if (((*a1 > ultTextoLugar) || (*a1 < 0))  && !((*a1 > 251) && (*a1 <= 255)))
		   error (errSem, 21);
      casarLex (pNumero);
	}
      else if (simbolo == pSubrayado)
	{
	  *a1 = -1;
	  casarLex (pSubrayado);
	}
      else if (simbolo == pPalabra)
	{
	  if (!strcmp (lexema, "WORN"))
	    *a1 = 253;
	  else if (!strcmp (lexema, "CARRIED"))
	    *a1 = 254;
	  else if (!strcmp (lexema, "HERE"))
	    *a1 = 255;
	  else
	    error (errSem, 21);
	  casarLex (pPalabra);
	}
      else
	casarLex (pNumero);
      break;
    case adjective:
      if (simbolo == pPalabra)
	{
	  if (!BuscarPalabra (lexema, &palabra) || (palabra.tipo != adjetivo))
	    error (errSem, 10);
	  *a1 = palabra.num;
	  casarLex (pPalabra);
	}
      else if (simbolo == pSubrayado)
	{
	  *a1 = 255;
	  casarLex (pSubrayado);
	}
      else if (simbolo == pNumero)
	{
	  *a1 = Val (lexema);
	  casarLex (pNumero);
	}
      else
	casarLex (pPalabra);
      break;
    case adverb:
      if (simbolo == pPalabra)
	{
	  if (!BuscarPalabra (lexema, &palabra) || (palabra.tipo != adverbio))
	    error (errSem, 10);
	  *a1 = palabra.num;
	  casarLex (pPalabra);
	}
      else if (simbolo == pSubrayado)
	{
	  *a1 = 255;
	  casarLex (pSubrayado);
	}
      else if (simbolo == pNumero)
	{
	  *a1 = Val (lexema);
	  casarLex (pNumero);
	}
      else
	casarLex (pPalabra);
      break;
    case preposition:
      if (simbolo == pPalabra)
	{
	  if (!BuscarPalabra (lexema, &palabra)
	      || (palabra.tipo != preposicion))
	    error (errSem, 10);
	  *a1 = palabra.num;
	  casarLex (pPalabra);
	}
      else if (simbolo == pSubrayado)
	{
	  *a1 = 255;
	  casarLex (pSubrayado);
	}
      else if (simbolo == pNumero)
	{
	  *a1 = Val (lexema);
	  casarLex (pNumero);
	}
      else
	casarLex (pPalabra);
      break;
	case string:
		*a1 = txtWrite->ocupado ;
		if ((texto = (char *) malloc (strlen (lexema) + 4)) == NULL)
		  error (errGeneral, 1);
		*texto = 0;
		strcat (texto, lexema);
		agregarTexto (txtWrite, txtWrite->ocupado, texto);
		casarLex(pString);
	break;
    case noun:
      if (simbolo == pPalabra)
	{
	  if (!BuscarPalabra (lexema, &palabra) || (palabra.tipo != nombre))
	    error (errSem, 10);
	  *a1 = palabra.num;
	  casarLex (pPalabra);
	}
      else if (simbolo == pSubrayado)
	{
	  *a1 = 255;
	  casarLex (pSubrayado);
	}
      else if (simbolo == pNumero)
	{
	  *a1 = Val (lexema);
	  casarLex (pNumero);
	}
      else
	casarLex (pPalabra);
      break;
    }
}

void
anArgs (int *a1, int *a2, int *a3)
{
  checkArg (a1, condacto.tipoArg1);
  checkArg (a2, condacto.tipoArg2);
  checkArg (a3, condacto.tipoArg3);
};

void
anCondacto (int numPro)
{
  int sharpCondact;
  int colonCondact;
  int cond, arg1, arg2, arg3;
  /*cond= */ arg1 = arg2 = arg3 = -1;
  if (simbolo == pPalabra)
    {
	  sharpCondact = 0;
	  colonCondact = 0;
	  if (lexema[strlen(lexema)-1] == '#') 
	  {
		  sharpCondact = 1;
		  lexema[strlen(lexema)-1] = 0;
	  }
	  if (lexema[strlen(lexema)-1] == ':') 
	  {
		  colonCondact = 1;
		  lexema[strlen(lexema)-1] = 0;
	  }

      if ((cond = BuscarCondacto (lexema, &condacto, sharpCondact|colonCondact)) == FALSE)
	error (errSem, 12);
      else
	{
	  casarLex (pPalabra);
	  anArgs (&arg1, &arg2, &arg3);
	  // IMPORTANT NOTE: In order to handle the blocks with {} and due to lack of knowledge of how the
	  // compiler is built, I'm going to do a dirty trick: to be able to raise errors when generating
	  // javascript if the writer uses a block end "}" without block start "{", or the writer leaves
	  // a block without end block "}", I need to store the line number where it is somewhere. As the
	  // block "condacts" don't have any parameters, I'm using the arg1 parameter to store it. Dirty
	  // trick really, sorry for that.
	  if ((condactos[cond].tipo == blockStart) || (condactos[cond].tipo == blockEnd))
		  arg1 = lineaLeida;

	  agregarCondacto (numPro, cond + 32768 * sharpCondact + 65536 * colonCondact, arg1, arg2, arg3);
	}
    }
  else
    {
      casarLex (pPalabra);
    }
/*  anArgs();*/
}

void
anMasCondactos (int numPro)
{
  while ((simbolo == pPalabra) && (!BOL))
    anCondacto (numPro);
}

void
anCondactos (int numPro)
{
  anCondacto (numPro);
  anMasCondactos (numPro);
}

void
anNombre (TipoEntrada * entrada)
{
  if ((simbolo == pPalabra) || (simbolo == pNumero))
    {
      if (BuscarPalabra (lexema, &palabra))
	if (palabra.tipo == nombre)
	  entrada->nombre = palabra.num;
	else
	  error (errSem, 9);
      else
	error (errSem, 8);
      if (simbolo == pPalabra)
	casarLex (pPalabra);
      else
	casarLex (pNumero);
    }
  else if (simbolo == pSubrayado)
    {
      entrada->nombre = -1;
      casarLex (pSubrayado);
    }
  else
    error (errLexSint, pPalabra);
}

void
anVerbo (TipoEntrada * entrada)
{
  if ((simbolo == pPalabra) || (simbolo == pNumero))
    {
      if (BuscarPalabra (lexema, &palabra))
	if ((palabra.tipo == verbo)
	    || ((palabra.tipo == nombre) && (palabra.num < 20)))
	  entrada->verbo = palabra.num;
	else
	  error (errSem, 14);
      else
	error (errSem, 8);
      if (simbolo == pPalabra)
	casarLex (pPalabra);
      else
	casarLex (pNumero);
    }
  else if (simbolo == pSubrayado)
    {
      entrada->verbo = -1;
      casarLex (pSubrayado);
    }
  else
    error (errLexSint, pPalabra);
}

void
anEntrada (int numPro)
{
  entrada = (TipoEntrada *) malloc (sizeof (TipoEntrada));
  entrada->posicion = 0;
  entrada->sig = NULL;
  anVerbo (entrada);
  anNombre (entrada);
  agregarEntrada (numPro, entrada);
  anCondactos (numPro);
}

void
anEntradas (int numPro)
{
  while ((simbolo == pPalabra) || (simbolo == pSubrayado) || (simbolo == pNumero))
    anEntrada (numPro);
}

void
anProceso (int numPro)
{
  NuevoProceso (numPro);
  anEntradas (numPro);
}

void
anProcesos ()
{
  int ultimo = -1;
  int numero;
  while (simbolo == pcPro)
    {
      casarLex (pcPro);
	  if (simbolo == pPalabra)
	  {
		  if (strcmp (lexema, "INTERRUPT"))
		  {
			error (errSem, 23);
		  };
		  if (interrupt_proc >= 0) 
			  error(errSem, 22);
		  /* Atención, doy por supuesto que el numero de proceso va 
		  a ser ultimo + 1, porque de otro modo fallara en el siguiente
		  if */
		  interrupt_proc = ultimo + 1;
		  if (interrupt_proc < 3)
			  error(errSem,24);
		  casarLex (pPalabra);
	  };

      if (simbolo == pNumero)
	  {
	   sscanf (lexema, "%d", &numero);
	   if ((numero != ultimo + 1) || (numero > ultProceso+1))
	     error (errSem, 13);
	  };
	  
      casarLex (pNumero);
      anProceso (numero);
      ultimo = numero;
      if (numero > ultProceso)
	ultProceso++;
    }
}

void
anSiNo (int *valor)
{
  if (simbolo == pPalabra)
    {
      if (!strcmp (lexema, "Y"))
	{
	  *valor = TRUE;
	  casarLex (pPalabra);
	}
      else
	error (errSem, 7);
    }
  else if (simbolo == pSubrayado)
    {
      *valor = FALSE;
      casarLex (pSubrayado);
    }
  else
    error (errLexSint, pPalabra);
}

void
anAdjetivo (TipoObjeto * obj)
{
  if ((simbolo == pPalabra) || (simbolo == pNumero))
    {
      if (!BuscarPalabra (lexema, &palabra))
	error (errSem, 8);
      if (palabra.tipo != adjetivo)
	error (errSem, 10);
      obj->adjetivo = palabra.num;
      if (simbolo == pPalabra)
	casarLex (pPalabra);	/* El adjetivo */
      else
	casarLex (pNumero);
    }
  else if (simbolo == pSubrayado)
    {
      obj->adjetivo = 255;
      casarLex (pSubrayado);
    }
  else
    error (errLexSint, pPalabra);
}

void
anLugar (TipoObjeto * obj)
{
  if (simbolo == pNumero)
    {
      obj->lugar = Val (lexema);
      casarLex (pNumero);
    }
  else if (simbolo == pPalabra)
    {
      if (!strcmp (lexema, "WORN"))
	obj->lugar = 253;
      else if (!strcmp (lexema, "CARRIED"))
	obj->lugar = 254;
      else
	error (errSem, 6);
      casarLex (pPalabra);
    }
  else if (simbolo == pSubrayado)
    {
      obj->lugar = 252;
      casarLex (pSubrayado);
    }
  else
    error (errLexSint, pNumero);
}


void anObjFlags(int * valor)
{
	int i;

	if (simbolo==pNumero) 
	{
		if (strlen(lexema) != 32) error (errSem, 25); /* Da error porque es un numero de longitud inadecuada */
		
		*valor = 0;
		for (i=0;i<32;i++)
			switch (lexema[i]) {

			 case '0': i=i;
			 break;
			 case '1': *valor|= (1<<i);
			 break;
			 default: error (errSem, 25); /* Da error porque a pesar de ser un numero no es un numero binario */
			}
		casarLex(pNumero);
	}
}

void
anDefObjeto (int numObj)
{
  anLugar (&objeto);
  if (simbolo == pNumero)
    {
      objeto.peso = Val (lexema);
      casarLex (pNumero);
    }
  else
    error (errLexSint, pNumero);
  //anSiNo (&objeto.contenedor);
  //anSiNo (&objeto.prenda);  ¡Ya no se define aquí, ahora son flags!
  if ((simbolo == pPalabra) || (simbolo == pNumero))
    {
      if (!BuscarPalabra (lexema, &palabra))
	error (errSem, 8);
      if (palabra.tipo != nombre)
	error (errSem, 9);
      else
	objeto.nombre = palabra.num;
      if (simbolo == pPalabra)
	casarLex (pPalabra);	/* El propio nombre */
      else
	casarLex (pNumero);
    }
  else if (simbolo == pSubrayado)
    {
      objeto.nombre = 255;
      casarLex (pSubrayado);
    }
  anAdjetivo (&objeto);
  anObjFlags(&objeto.lo_flags);
  anObjFlags(&objeto.hi_flags);
  PonerObjeto (numObj, objeto);
}

void
anDefinicionesObjetos ()
{
  int anterior, numero;
  anterior = -1;
  while (simbolo == pIdNumerico)
    {
      sscanf (lexema, "/%d", &numero);
      if ((numero != anterior + 1) || (numero > ultTextoObjeto))
	error (errSem, 11);
      casarLex (pIdNumerico);
      anDefObjeto (numero);
      anterior = numero;
    }
}

void
anSeccionObj ()
{
  casarLex (pcObj);
  anDefinicionesObjetos ();
}

void
anTextosMensajes ()
{
  int numero;
  while (simbolo == pIdNumerico)
    {
      sscanf (lexema, "/%d", &numero);
	  if (ultTextoMensaje<numero) ultTextoMensaje = numero;
      /*if (numero != ultTextoMensaje)
	error (errSem, 1); 
      if (numero > 255)
	error (errSem, 2);*/ /* OJO! */
      casarLexSinLeer (pIdNumerico);
      agregarTexto (txtMensajes, numero, extraerTexto ());
    }
}

void
anSeccionMtx ()
{
  casarLex (pcMtx);
  anTextosMensajes ();
}

void
anTextosSistema ()
{
  int numero;
  while (simbolo == pIdNumerico)
    {
      
      sscanf (lexema, "/%d", &numero);
	  if (ultTextoSistema<numero) ultTextoSistema=numero;
     /* if (numero != ultTextoSistema)
	error (errSem, 1);
      if (numero > 255)
	error (errSem, 2);*/
      casarLexSinLeer (pIdNumerico);
      /* leerLineaDeTexto(); */
      agregarTexto (txtSistema, numero, extraerTexto ());
    }
}

void
anSeccionStx ()
{
  casarLex (pcStx);
  anTextosSistema ();
  if (ultTextoSistema < 60)
    error (errSem, 3);

}

void
anSalidas (int origen)
{
  while (simbolo == pPalabra)
    {
      if (!BuscarPalabra (lexema, &palabra)
	  || ((palabra.num > 13) && (palabra.tipo != verbo)))
	error (errSem, 5);
      casarLex (pPalabra);
      if (simbolo == pNumero)
	{
	  PonerSalida (origen, palabra.num, Val (lexema));
	  casarLex (pNumero);
	}
      else
	{
	  error (errLexSint, pNumero);
	}
    }
}

void
anConexiones ()
{
  int numero;
  while (simbolo == pIdNumerico)
    {
      ultConexion++;
      sscanf (lexema, "/%d", &numero);
      if (numero != ultConexion)
	error (errSem, 4);
      casarLex (pIdNumerico);
      anSalidas (numero);
    }
}

void
anSeccionCon ()
{
  casarLex (pcCon);
  anConexiones ();
}

void
anTextosLugares ()
{
  int numero;
  while (simbolo == pIdNumerico)
    {
      ultTextoLugar++;
      sscanf (lexema, "/%d", &numero);
      if (numero != ultTextoLugar)
	error (errSem, 1);
      if (numero > 255)
	error (errSem, 2);
      casarLexSinLeer (pIdNumerico);
      agregarTexto (txtLugares, numero, extraerTexto ());
    }
}

void
anSeccionLtx ()
{
  casarLex (pcLtx);
  anTextosLugares ();
}

void
anTextosObjetos ()
{
  int numero;
  while (simbolo == pIdNumerico)
    {
      ultTextoObjeto++;
      sscanf (lexema, "/%d", &numero);
      if (numero != ultTextoObjeto)
	error (errSem, 1);
      if (numero > 255)
	error (errSem, 2);
      casarLexSinLeer (pIdNumerico);
      agregarTexto (txtObjetos, numero, extraerTexto ());
    }
}

void
anSeccionOtx ()
{
  casarLex (pcOtx);
  anTextosObjetos ();
}

void
anEntradaVoc ()
{
  char pal[10];
  int numero;
  TiposDePalabra tipo;

  if (simbolo == pPalabra)
    {
      strncpy (pal, lexema, 10);
      casarLex (pPalabra);
    }
  else if (simbolo == pNumero)
    {
      strncpy (pal, lexema, 10);
      casarLex (pNumero);
    }
  else
    error (errLexSint, pPalabra);
  if (simbolo == pNumero)
    {
      sscanf (lexema, "%d", &numero);
      casarLex (pNumero);
    }
  else
    error (errLexSint, pNumero);
  if (simbolo == pPalabra)
    {
      if (!strcmp (lexema, "VERB"))
	tipo = verbo;
      else if (!strcmp (lexema, "NOUN"))
	tipo = nombre;
      else if (!strcmp (lexema, "ADJECTIVE"))
	tipo = adjetivo;
      else if (!strcmp (lexema, "ADVERB"))
	tipo = adverbio;
      else if (!strcmp (lexema, "PRONOUN"))
	tipo = pronombre;
      else if (!strcmp (lexema, "CONJUGATION"))
	tipo = conjuncion;
      else if (!strcmp (lexema, "CONJUNCTION"))
	tipo = conjuncion;
      else if (!strcmp (lexema, "PREPOSITION"))
	tipo = preposicion;
      else
	error (errSem, 0);
    }
  else
    error (errLexSint, pPalabra);
  NuevaPalabra (pal, tipo, numero);
  casarLex (pPalabra);
}

void
anEntradasVoc ()
{
  while ((simbolo == pPalabra) || (simbolo == pNumero))
    anEntradaVoc ();
}

void
anSeccionVoc ()
{
  casarLex (pcVoc);
  anEntradasVoc ();
}

void
anDirectivaConfiguracion()
{
  int longnombre;
  char temp[2048];
  char * posigual = strchr(lexema, '=');
  if(posigual==NULL)
  {
    putcfgvar(lexema, NULL);
  }
  else
  {
    posigual++;
    longnombre = posigual - lexema;
    strncpy(temp, lexema, longnombre-1);
    temp[longnombre-1] = '\0';
    if(isvalidcfgvar(temp))
    {
      putcfgvar(temp, posigual);
    }
    else
    {
      error(errLexSint, pDirectivaConfiguracion);
    }
    /* printf("'%s',%d:'%s'->'%s'\n", lexema, longnombre, temp, posigual); */
  }
  casarLex(pDirectivaConfiguracion);
}

void
anSeccionCtl ()
{
  if(simbolo == pcCtl) casarLex (pcCtl);
  else return;
  
  if(simbolo == pSubrayado) casarLex (pSubrayado);
  
  while(simbolo == pDirectivaConfiguracion) {
    anDirectivaConfiguracion();
  }
}

void
anFichPaw ()
{
  puts ("Processing control section...");
  anSeccionCtl ();
  puts ("Processing vocabulary...");
  anSeccionVoc ();
  puts ("Processing system messages...");
  anSeccionStx ();
  puts ("Processing user messages...");
  anSeccionMtx ();
  puts ("Processing object descriptions...");
  anSeccionOtx ();
  puts ("Processing location descriptions...");
  anSeccionLtx ();
  puts ("Processing connections...");
  anSeccionCon ();
  puts ("Processing objects...");
  anSeccionObj ();
  puts ("Processing processes and response table...");
  anProcesos ();
}

void
analizar (void)
{
  InicializarVocabulario ();
  PrepararSalidas ();
  anFichPaw ();
  casarLex (pFinal);
/*  error(sinError,0);*/
}
