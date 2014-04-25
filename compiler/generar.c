/* generar.c
 *
 * En este archivo se trata todo lo
 * relacionado con la generación de
 * código.
 */

#include <config.h>

#include <errno.h>
#include <malloc.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "comun.h"
#include "generar.h"
#include "vocabula.h"
#include "textos.h"
#include "salidas.h"
#include "objetos.h"
#include "procesos.h"
#include "condacto.h"
#include "lexico.h"
#include "cfgvars.h"

FILE *fichJS, *fichLib, *fichSpellCheck,  *fichBlc;

char libFile[2024];

TipoCondacto elCondacto;

void VolcarProcesos (void);
void VolcarPalabras (void);
void VolcarMensajesSistema (void);
void VolcarMensajesUsuario (void);
void VolcarMensajesWrite (void);
void VolcarDescripcionesDeObjetos (void);
void VolcarDescripcionesDeLugares (void);
void VolcarConexiones (void);
void VolcarFicheroCFG (const char *);
void VolcarVariablesDeConfiguracion (void);
void VolcarObjetos (void);
void VolcarRecursos (void);


void trim(char *s)
{
       // Trim spaces and tabs from beginning:
       int i=0,j;
       while((s[i]==' ')||(s[i]=='\t')) {
               i++;
       }
       if(i>0) {
               for(j=0;j<strlen(s);j++) {
                       s[j]=s[j+i];
               }
       s[j]='\0';
       }

       // Trim spaces and tabs from end:
       i=strlen(s)-1;
       while((s[i]==' ')||(s[i]=='\t')) {
               i--;
       }
       if(i<(strlen(s)-1)) {
               s[i+1]='\0';
       }
}




void GenerarEnsamblador (char *nombreFuente)
{
  char nombreDestino[256];
  char *finNombre;
  char linea[32768];

  
  /* Generate output file */
  strcpy (nombreDestino, nombreFuente);
  finNombre = strrchr (nombreDestino, '.');
  if (finNombre)  *finNombre = '\0';
  strcat (nombreDestino, ".js");
  if ((fichJS = fopen (nombreDestino, "wt")) == NULL)
    {
      printf ("Can't create output file.\n");
      exit (-1);
    }
  /* Generate spell check file. */
  strcpy (nombreDestino, nombreFuente);
  finNombre = strrchr (nombreDestino, '.');
  if (finNombre) *finNombre = '\0';
  strcat (nombreDestino, ".txt");
  if ((fichSpellCheck = fopen (nombreDestino, "wt")) == NULL)
    {
      printf ("Can't create spell check file.\n");
      exit (-1);
    }

  /* Open BLC file */
  strcpy (nombreDestino, nombreFuente);
  finNombre = strrchr (nombreDestino, '.');
  if (finNombre) *finNombre = '\0';
  strcat (nombreDestino, ".blc");
  if ((fichBlc = fopen(nombreDestino, "rt")) == NULL)
  {
		printf ("Cant' find blc file.\n");
  }


  
  /* Add variables file */  
  strcpy (libFile, wd);
  strcat (libFile, "/jsl/variables.js");
  if ((fichLib = fopen (libFile, "rt")) != NULL)
    {
      while (!feof (fichLib))
	{
	  fgets (linea, 32768, fichLib);
	  fputs (linea, fichJS);
	}
      fclose (fichLib);
    }
  else
    perror ("ERROR");


  VolcarProcesos ();

/* Copia el hooks */
  strcpy (libFile, wd);
  strcat (libFile, "/jsl/hooks.js");
  
  if ((fichLib = fopen (libFile, "rt")) != NULL)
    {
      while (fgets (linea, 32768, fichLib))
	{
	  fputs (linea, fichJS);
	}
      fclose (fichLib);
    }



  /* Copia condactos */
  strcpy (libFile, wd);
  strcat (libFile, "/jsl/condacts.js");
  if ((fichLib = fopen (libFile, "rt")) != NULL)
    {
      while (fgets (linea, 32768, fichLib))
	{
	  fputs (linea, fichJS);
	}
      fclose (fichLib);
    }
  
  /* Copia condactos plugin */
  strcpy (libFile, wd);
  strcat (libFile, "/jsl/plugin.js");
    if ((fichLib = fopen (libFile, "rt")) != NULL)
    {
      while (fgets (linea, 32768, fichLib))
	{
	  fputs (linea, fichJS);
	}
      fclose (fichLib);
    }




  /* Copia el runtime */
  strcpy (libFile, wd);
  strcat (libFile, "/jsl/runtime.js");
  
  if ((fichLib = fopen (libFile, "rt")) != NULL)
    {
      while (fgets (linea, 32768, fichLib))
	{
	  fputs (linea, fichJS);
	}
      fclose (fichLib);
    }



  VolcarPalabras ();
  VolcarMensajesSistema ();
  VolcarMensajesUsuario ();
  VolcarMensajesWrite();
  VolcarDescripcionesDeObjetos ();
  VolcarDescripcionesDeLugares ();
  VolcarConexiones ();
  VolcarRecursos();
  VolcarObjetos();
  
};

void VolcarRecursos (void)
{

	FILE *f;
	char linea[32768];
	char bloque[32768];
	int inicial;
	int i , value;
	int resourceType, resourceid;

	printf ("Comprobando recursos...\n");
	fputs("resources=[];\n", fichJS);

	f = fichBlc;

	if (f==NULL) return;
	
	while (fgets (linea, 32768, f))
	{
		if (linea[0] == 0) continue;
		inicial = 0;
		/* Obtenemos tipo de recurso */
		for (i=inicial;(linea[i]!=0)&&(linea[i]!=32)&&(linea[i]!=10)&&(linea[i]!=13)&&(i<32768);i++) {};
		strncpy (bloque, linea+inicial, i-inicial);
		bloque[i-inicial]=0;
		inicial=i+1;
		resourceType = 0;

		

		if (strcmp(bloque,"Picture")==0) /* Es un recurso imagen*/
		{
				resourceType=1;
		}
		else 
		if (strcmp(bloque,"Snd")==0) /* Es un recurso sonido */
		{
			resourceType=2;
		}


		/* Obtenemos numero de recurso*/
		for (i=inicial;(linea[i]!=0)&&(linea[i]!=32)&&(linea[i]!=10)&&(linea[i]!=13)&&(i<32768);i++) {};
		strncpy (bloque, linea + inicial, i - inicial);
		bloque[i - inicial]=0;
		inicial=i+1;
		resourceid = atoi(bloque);


		/* Obtenemos tipo de recurso Glulx para ignorarlo */
		for (i=inicial;(linea[i]!=0)&&(linea[i]!=32)&&(linea[i]!=10)&&(linea[i]!=13)&&(i<32768);i++) {};
		strncpy (bloque, linea+inicial, i-inicial);
		bloque[i-inicial]=0;
		inicial=i+1;

		/* Obtenemos nombre del fichero */
		for (i=inicial;(linea[i]!=0)&&(linea[i]!=32)&&(linea[i]!=10)&&(linea[i]!=13)&&(i<32768);i++) {};
		strncpy (bloque, linea+inicial, i-inicial);
		bloque[i-inicial]=0;
		inicial=i+1;
		

		if ((resourceType == 1) || (resourceType == 2)) 
			fprintf(fichJS, "resources.push([%s, %d, \"%s\"]);\n", (resourceType==1)? "RESOURCE_TYPE_IMG" : "RESOURCE_TYPE_SND", resourceid, bloque);
	}
	fputs("\n",fichJS);	

}

void VolcarProcesos ()
{

  TipoEntrada *laEntrada;
  int npro, nent, posicion;
  int *pCondacto, i;
  char verboDeLaEntrada[20], nombreDeLaEntrada[20];
  char p1[100], p2[100], p3[100] = "";

  fputs ("\n// PROCESSES\n\n", fichJS);
  
  /* Seguimos con la variable que indica si hay proceso interrupcion */

  if (interrupt_proc == -1) 
	  fprintf(fichJS, "interruptProcessExists = false;\n\n");
  else
	  fprintf(fichJS, "interruptProcessExists = true;\n\n");
						
  for (npro = 0; npro < ultProceso + 1; npro++)
    {
	  

      fprintf (fichJS, "function pro%03d()\n{\n", npro);
	  fprintf (fichJS, "pro%03d_restart:\n{\n", npro);
      nent = 0;
      laEntrada = SiguienteEntrada (npro, NULL);

      while (laEntrada != NULL)
	  {
		pCondacto = laEntrada->condactos;
		posicion = 0;
		strcpy (verboDeLaEntrada, BuscarPalabraPorNumero (laEntrada->verbo, verbo));
		strcpy (nombreDeLaEntrada, BuscarPalabraPorNumero (laEntrada->nombre, nombre));
		/* generar el codigo de entrada a la entrada verbo + nombre*/
		fprintf (fichJS, "\t// %s %s\n\tp%03de%04d:\n\t{\n", verboDeLaEntrada, nombreDeLaEntrada,npro, nent );
		fprintf (fichJS, " \t\tif ((doall_flag==true) && (entry_for_doall!='') && (entry_for_doall > 'p%03de%04d')) break p%03de%04d;\n",   npro, nent, npro, nent);    		// generar codigo de saltarse la entrada hasta la que toque si es un bucle doall
		if (laEntrada->verbo + laEntrada->nombre != -2) fprintf (fichJS, " \t\tif (in_response)\n\t\t{\n",   npro, nent);   
	    if (laEntrada->verbo != -1) fprintf (fichJS, "\t\t\tif (!CNDverb(%d)) break p%03de%04d;\n",  laEntrada->verbo, npro, nent);
	    if (laEntrada->nombre != -1) fprintf (fichJS, "\t\t\tif (!CNDnoun1(%d)) break p%03de%04d;\n", laEntrada->nombre, npro, nent);
		if (laEntrada->verbo + laEntrada->nombre != -2) fprintf (fichJS, " \t\t}\n",   npro, nent); 
		/* generar codigo de condactos */
		while (posicion < (laEntrada->posicion))
	    {
			elCondacto = condactos[pCondacto[posicion]];
			/* generar el codigo del condacto */
			if (!strcmp (elCondacto.nombre, "DOALL"))
			{
	            fprintf (fichJS, "\t\tentry_for_doall = 'p%03de%04d';\n", npro, nent);
	            fprintf (fichJS, "\t\tprocess_in_doall = %d;\n", npro);
			}

			if (!strcmp (elCondacto.nombre, "RESTART"))
			{
				fprintf (fichJS, "\t\t\tcontinue pro%03d_restart;\n", npro); 
		    }
					


            if (elCondacto.tipoArg3 != nada)
            {
                 if (pCondacto[posicion+3] & 0x80000000) sprintf(p3,",getFlag(%d)",pCondacto[posicion + 3] & 0x7FFFFFFF);
                    else sprintf(p3, ",%d",  pCondacto[posicion + 3]);
            } else sprintf(p3, "");
            if (elCondacto.tipoArg2 != nada)
            {
                 if (pCondacto[posicion+2] & 0x80000000) sprintf(p2,",getFlag(%d)",pCondacto[posicion + 2] & 0x7FFFFFFF);
                    else sprintf(p2, ",%d",  pCondacto[posicion + 2]);
            }else sprintf(p2, "");
            if (elCondacto.tipoArg1 != nada)
            {
                 if (pCondacto[posicion+1] & 0x80000000) sprintf(p1,"getFlag(%d)",pCondacto[posicion + 1] & 0x7FFFFFFF);
                    else sprintf(p1, "%d",  pCondacto[posicion + 1]);
            } else sprintf(p1, "");


			// generar el condacto                
            switch (elCondacto.tipo)
			{
			case condicion:
			case mixto:
				fprintf (fichJS, "\t\tif (!CND%s(%s%s%s)) break p%03de%04d;\n",  aMinusculas (elCondacto.nombre), p1,p2,p3, npro, nent );
				break;
			case accion:
				fprintf (fichJS, " \t\tACC%s(%s%s%s);\n", aMinusculas (elCondacto.nombre), p1, p2, p3);
			    if (!strcmp (elCondacto.nombre, "process"))
				{
					fprintf (fichJS,"\t\tif (describe_location_flag) break p%03de9999;\n", npro);  
			    }
		    break;
			default:
				printf ("ERROR: tipo de condacto no reconocido\n");
			}
			/* y ahora, las operaciones de limpieza del condacto según el tipo del mismo */
			switch (elCondacto.limpieza)
			{
				case aDescribir:
				case aEnd:
				case aFinDeTabla:
					fprintf (fichJS, "\t\tbreak pro%03d_restart;\n", npro); 
				break;
				case aCondicional:
					fprintf (fichJS, "\t\tif (!success) break pro%03d_restart;\n", npro); 
				break;
			}
			posicion += 4;
		} // Bucle Condactos
		fprintf (fichJS,"\t}\n\n"); // Cierro bloque de condactos
		laEntrada = SiguienteEntrada (npro, laEntrada);
		nent++;
	  } // Bucle entradas
	  fprintf (fichJS, "\n}\n}\n\n");  // Cerramos el proceso y el bloque restart, dos llaves
	  if (npro == interrupt_proc) fprintf (fichJS, "interrupt_proc = %d;\n", npro);

    }  // Bucle de los procesos
	fprintf (fichJS, "last_process = %d;\n", npro-1);
}

void VolcarPalabras()
{

  PPalabra palabra;
  int np, i;

  fputs ("\n// VOCABULARY\n\n", fichJS);
  fputs ("vocabulary = [];\n", fichJS);


  np = 0;
  palabra = SiguientePalabra (NULL);
  while (palabra != NULL)
    {
		fprintf( fichJS, "vocabulary.push([%d, \"%s\", %d]);\n", palabra->num, palabra->pal, palabra->tipo);
	    palabra = SiguientePalabra (palabra);
		np++;
    }
  fputs ("\n\n", fichJS);
}

void VolcarMensajesSistema ()
{
  int i;
  fputs ("\n// SYS MESSAGES\n\n", fichJS);
  fprintf (fichJS, "total_sysmessages=%d;\n\n", txtSistema->ocupado);
  fprintf (fichJS, "sysmessages = [];\n\n");
  for (i = 0; i < txtSistema->ocupado; i++)
    fprintf (fichJS, "sysmessages[%d] = \"%s\";\n",txtSistema->mensajes[i].num_mensaje,txtSistema->mensajes[i].mensaje );
  fputs ("\n\n", fichSpellCheck);
}


void VolcarMensajesWrite ()
{
  int i;
  fputs ("\n// WRITE MESSAGES\n\n", fichJS);
  fprintf (fichJS, "total_writemessages=%d;\n\n", txtWrite->ocupado);
  fprintf (fichJS, "writemessages = [];\n\n");
  for (i = 0; i < txtWrite->ocupado; i++)
    fprintf (fichJS, "writemessages[%d] = \"%s\";\n",txtWrite->mensajes[i].num_mensaje,txtWrite->mensajes[i].mensaje );
  fputs ("\n\n", fichSpellCheck);
}

void VolcarMensajesUsuario ()
{
  int i;
  fputs ("\n// USER MESSAGES\n\n", fichJS);
  fprintf (fichJS, "total_messages=%d;\n\n", txtMensajes->ocupado);
  fprintf (fichJS, "messages = [];\n\n");
  for (i = 0; i < txtMensajes->ocupado; i++)
    fprintf (fichJS, "messages[%d] = \"%s\";\n",txtMensajes->mensajes[i].num_mensaje,txtMensajes->mensajes[i].mensaje );
  fputs ("\n\n", fichSpellCheck);
}




void VolcarDescripcionesDeLugares ()
{
  int i;
  fputs ("\n// LOCATION MESSAGES\n\n", fichJS);
  fprintf (fichJS, "total_location_messages=%d;\n\n", txtLugares->ocupado);
  fprintf (fichJS, "locations = [];\n\n");
  for (i = 0; i < txtLugares->ocupado; i++)
    fprintf (fichJS, "locations[%d] = \"%s\";\n",txtLugares->mensajes[i].num_mensaje,txtLugares->mensajes[i].mensaje );
  fputs ("\n\n", fichSpellCheck);
}



void VolcarConexiones ()
{
  int i, j;

  fputs ("\n// CONNECTIONS\n\n", fichJS);
  fputs ("connections = [];\n", fichJS);
  fputs ("connections_start = [];\n\n", fichJS);
  
  /* Conexiones de cada localidad */
  for (i = 0; i < ultTextoLugar + 1; i++)
    {
      fprintf (fichJS, "connections[%d] = [ ", i);
      for (j = 0; j < 16; j++)
		{
		    fprintf (fichJS, "%d", Salida (i, j));
			if (j!=15) fprintf(fichJS, ", ");
		}
      fputs (" ];\n", fichJS);
    }
  fputs ("\n", fichJS);

  /* Conexiones de cada localidad, iniciales */
  for (i = 0; i < ultTextoLugar + 1; i++)
    {
      fprintf (fichJS, "connections_start[%d] = [ ", i);
      for (j = 0; j < 16; j++)
		{
		    fprintf (fichJS, "%d", Salida (i, j));
			if (j!=15) fprintf(fichJS, ", ");
		}
      fputs (" ];\n", fichJS);
    }
  fputs ("\n\n", fichJS);
}

void
VolcarFicheroCFG(const char * nombreFuente)
{
  
  char nombreDestino[2048];
  FILE *fichCFG;
  char * finNombre;

  strcpy (nombreDestino, nombreFuente);
  finNombre = strrchr (nombreDestino, '.');
  if (finNombre)
    *finNombre = '\0';
  strcat (nombreDestino, ".cfg");
  /* Abrir el fichero de destino */
  if ((fichCFG = fopen (nombreDestino, "wt")) == NULL)
  {
      printf ("No se puede crear el fichero de configuracion para escribirlo.\n");
      exit (-1);
  }
  
  if(iscfgvar("WINDOWBORDERS"))fprintf(fichCFG, "WindowBorders=%s\n", (!strcasecmp(cfgvarvalue("WINDOWBORDERS", "ON"),"ON")?"yes":"no"));
  if(iscfgvar("WINDOWFRAME"))fprintf(fichCFG, "WindowFrame=%s\n", (!strcasecmp(cfgvarvalue("WINDOWFRAME", "ON"),"ON")?"yes":"no"));
  if(iscfgvar("WINDOWWIDTH"))fprintf(fichCFG, "WindowWidth=%s\n", cfgvarvalue("WINDOWWIDTH", "640"));
  if(iscfgvar("WINDOWHEIGHT"))fprintf(fichCFG, "WindowHeight=%s\n", cfgvarvalue("WINDOWHEIGHT", "400"));
  if(iscfgvar("WINDOWMASK"))fprintf(fichCFG, "WindowMask=%s\n", cfgvarvalue("WINDOWMASK", "0"));
  
  if(iscfgvar("PROPORTIONALFACE"))fprintf(fichCFG, "FontName=%s\n", cfgvarvalue("PROPORTIONALFACE", "Arial"));
  if(iscfgvar("PROPORTIONALSIZE"))fprintf(fichCFG, "FontSize=%s\n", cfgvarvalue("PROPORTIONALSIZE", "12"));
  if(iscfgvar("TYPEWRITERFACE"))fprintf(fichCFG, "FixedFontName=%s\n", cfgvarvalue("TYPEWRITERFACE", "Courier New"));
  if(iscfgvar("TYPEWRITERSIZE"))fprintf(fichCFG, "FixedFontSize=%s\n", cfgvarvalue("TYPEWRITERSIZE", "14"));
  
  fclose(fichCFG);
}


#define NUL '\0'




void VolcarVariablesDeConfiguracion(void)
{
  int i;
  char cad1[2048];
  const char * graphic_pos = cfgvarvalue("GRAPHIC_POSITION","UP");
  char * graphic_pos_val;
  
  char * deftypewriter [] = {
  "OFF", "OFF", "OFF", "OFF", "OFF", "OFF", "OFF", "OFF", "OFF", "OFF", "OFF" };
  
  char * defbold [] = {
  "OFF", "OFF", "OFF", "OFF", "OFF", "OFF", "OFF", "OFF", "ON" , "ON" , "OFF" };
  
  char * defitalic [] = {
  "OFF", "OFF", "OFF", "OFF", "OFF", "OFF", "OFF", "OFF", "OFF", "OFF", "ON"  };
  
  char * defforeground [] = {
  "ffffff", "ff0000", "00ff00", "0000ff", "ffff00", "00ffff", "ff00ff", "808080", "ffffff", "ffffff", "ffffff"  };
  
  char * defbackground [] = {
  "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000"  };
  
  fputs ("\n CONFIG VARS\n\n", fichJS);
  
  
  fprintf(fichJS, ":cfg_musicstop dc.l %d.l\n", !strcasecmp(cfgvarvalue("MUSICSTOP","ON"), "ON")?1:0);
  
  for(i=0;i<11;i++) {
    trim(deftypewriter[i]);
    trim(defbold[i]);
    trim(defitalic[i]);
    trim(defforeground[i]);
    trim(defbackground[i]);
  	sprintf(cad1, "TYPEWRITER_%d", i);
  	fprintf(fichJS, ":cfg_typewriter_%d dc.l %s.l\n", i, !strcasecmp(cfgvarvalue(cad1, (deftypewriter[i])), "ON")?"0":"1");
  	
	sprintf(cad1, "BOLD_%d", i);
  	fprintf(fichJS, ":cfg_bold_%d dc.l %s.l\n", i, !strcasecmp(cfgvarvalue(cad1, (defbold[i])), "ON")?"1":"0");
	
	sprintf(cad1, "ITALIC_%d", i);
  	fprintf(fichJS, ":cfg_italic_%d dc.l %s.l\n", i, !strcasecmp(cfgvarvalue(cad1, (defitalic[i])), "ON")?"1":"0");
	
	sprintf(cad1, "FOREGROUND_%d", i);
  	fprintf(fichJS, ":cfg_foreground_%d dc.l 0x%s.l\n", i, cfgvarvalue(cad1, (defforeground[i])));
	
	sprintf(cad1, "BACKGROUND_%d", i);
  	fprintf(fichJS, ":cfg_background_%d dc.l 0x%s.l\n", i, cfgvarvalue(cad1, (defbackground[i])));
  }
  
  fprintf(fichJS, ":cfg_graphic_percent dc.l %s.l\n", cfgvarvalue("GRAPHIC_PERCENT","50"));
  
  if(!strcasecmp(graphic_pos, "UP")||!strcasecmp(graphic_pos, "TOP") || !strcasecmp(graphic_pos, "NORTH"))
  {
    graphic_pos_val="22"; /* winMethod_Above|winMethod_Proportional */
  }
  else if (!strcasecmp(graphic_pos, "DOWN")||!strcasecmp(graphic_pos, "BOTTOM") || !strcasecmp(graphic_pos, "SOUTH"))
  {
    graphic_pos_val="23"; /* winMethod_Below|winMethod_Proportional */
  }
  else if (!strcasecmp(graphic_pos, "LEFT")||!strcasecmp(graphic_pos, "WEST"))
  {
    graphic_pos_val="20"; /* winMethod_Left|winMethod_Proportional */
  }
  else if (!strcasecmp(graphic_pos, "RIGHT")||!strcasecmp(graphic_pos, "EAST"))
  {
    graphic_pos_val="21"; /* winMethod_Right|winMethod_Proportional */
  }
  else
  {
    graphic_pos_val="22"; /* winMethod_Above|winMethod_Proportional */
  }
  
  fprintf(fichJS, ":cfg_graphic_position dc.l 0x%s.l\n", graphic_pos_val);
  
}


void VolcarDescripcionesDeObjetos ()
{
}

void VolcarObjetos (void)
{
  int i, objetosLlevados;
  fputs ("\n //OBJECTS\n\n", fichJS);
  objetosLlevados = 0;

  fprintf (fichJS, "objects = [];\n");
  fputs("objectsAttrLO = [];\n", fichJS);
  fputs("objectsAttrHI = [];\n", fichJS);
  fputs("objectsLocation = [];\n", fichJS);
  fputs("objectsNoun = [];\n", fichJS);
  fputs("objectsAdjective = [];\n", fichJS);
  fputs("objectsWeight = [];\n", fichJS);
  fputs("objectsAttrLO_start = [];\n", fichJS);
  fputs("objectsAttrHI_start = [];\n", fichJS);
  fputs("objectsLocation_start = [];\n", fichJS);
  fputs("objectsWeight_start = [];\n\n", fichJS);
  

  
  for (i = 0; i < ultTextoObjeto + 1; i++)
  {
	  fprintf (fichJS, "objects[%d] = \"%s\";\n",i,txtObjetos->mensajes[i].mensaje );
      fprintf (fichJS, "objectsNoun[%d] = %d;\n", i, objetos[i].nombre);
      fprintf (fichJS, "objectsAdjective[%d] = %d;\n", i, objetos[i].adjetivo);
      fprintf (fichJS, "objectsLocation[%d] = %d;\n", i, objetos[i].lugar);
	  fprintf (fichJS, "objectsLocation_start[%d] = %d;\n", i, objetos[i].lugar);
      fprintf (fichJS, "objectsWeight[%d] = %d;\n", i, objetos[i].peso);
	  fprintf (fichJS, "objectsWeight_start[%d] = %d;\n", i, objetos[i].peso);
      fprintf (fichJS, "objectsAttrLO[%d] = %d;\n", i, objetos[i].lo_flags);
	  fprintf (fichJS, "objectsAttrLO_start[%d] = %d;\n", i, objetos[i].lo_flags);
      fprintf (fichJS, "objectsAttrHI[%d] = %d;\n", i, objetos[i].hi_flags);
	  fprintf (fichJS, "objectsAttrHI_start[%d] = %d;\n\n", i, objetos[i].hi_flags);

      if (objetos[i].lugar == 254)	objetosLlevados ++;
  }
  
  fprintf (fichJS, "last_object_number =  %d; \n", ultTextoObjeto);
  fprintf (fichJS, "carried_objects = %d;\n",  objetosLlevados);
  fprintf (fichJS, "total_object_messages=%d;\n\n", txtObjetos->ocupado);

}


