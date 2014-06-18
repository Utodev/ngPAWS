
#include <config.h>

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#if (defined(__MSDOS__))||(defined(WIN32))
#include "VisualStudio/dirent/dirent.h"
#else
#include <dirent.h>
#endif

#include "condacto.h"
#include "errores.h"

#include "comun.h"

TipoCondacto condactos[NUMCONDACTOS+CONDACTOS_USUARIO];

TipoCondacto condactos_estandar[NUMCONDACTOS] = {
  {"sinCondacto", condicion, nada, nada, nada, aNada}
  ,
  {"AT", condicion, locno, nada, nada, aNada}
  ,
  {"NOTAT", condicion, locno, nada, nada, aNada}
  ,
  {"ATGT", condicion, locno, nada, nada, aNada}
  ,
  {"ATLT", condicion, locno, nada, nada, aNada}
  ,
  {"PRESENT", condicion, objno, nada, nada, aNada}
  ,
  {"ABSENT", condicion, objno, nada, nada, aNada}
  ,
  {"WORN", condicion, objno, nada, nada, aNada}
  ,
  {"NOTWORN", condicion, objno, nada, nada, aNada}
  ,
  {"CARRIED", condicion, objno, nada, nada, aNada}
  ,
  {"NOTCARR", condicion, objno, nada, nada, aNada}
  ,
  {"CHANCE", condicion, percent, nada, nada, aNada}
  ,
  {"ZERO", condicion, flagno, nada, nada, aNada}
  ,
  {"NOTZERO", condicion, flagno, nada, nada, aNada}
  ,
  {"EQ", condicion, flagno, value, nada, aNada}
  ,
  {"GT", condicion, flagno, value, nada, aNada}
  ,
  {"LT", condicion, flagno, value, nada, aNada}
  ,
  {"ADJECT1", condicion, adjective, nada, nada, aNada}
  ,
  {"ADVERB", condicion, adverb, nada, nada, aNada}
  ,
  {"TIMEOUT", condicion, nada, nada, nada, aNada}
  ,
  {"ISAT", condicion, objno, locno_, nada, aNada}
  ,
  {"PREP", condicion, preposition, nada, nada, aNada}
  ,
  {"NOUN2", condicion, noun, nada, nada, aNada}
  ,
  {"ADJECT2", condicion, adjective, nada, nada, aNada}
  ,
  {"SAME", condicion, flagno, flagno, nada, aNada}
  ,
  {"NOTEQ", condicion, flagno, value, nada, aNada}
  ,
  {"NOTSAME", condicion, flagno, flagno, nada, aNada}
  ,
  {"ISNOTAT", condicion, objno, locno_, nada, aNada}
  ,
  {"INVEN", accion, nada, nada, nada, aFinDeTabla}
  ,
  {"DESC", accion, nada, nada, nada, aDescribir}
  ,
  {"QUIT", condicion, nada, nada, nada, aNada}
  ,
  {"END", accion, nada, nada, nada, aEnd}
  ,
  {"DONE", accion, nada, nada, nada, aFinDeTabla}
  ,
  {"OK", accion, nada, nada, nada, aFinDeTabla}
  ,
  {"ANYKEY", accion, nada, nada, nada, aNada}
  ,
  {"SAVE", accion, nada, nada, nada, aDescribir}
  ,
  {"LOAD", accion, nada, nada, nada, aDescribir}
  ,
  {"TURNS", accion, nada, nada, nada, aNada}
  ,
  {"SCORE", accion, nada, nada, nada, aNada}
  ,
  {"CLS", accion, nada, nada, nada, aNada}
  ,
  {"DROPALL", accion, nada, nada, nada, aNada}
  ,
  {"AUTOG", accion, nada, nada, nada, aCondicional}
  ,
  {"AUTOD", accion, nada, nada, nada, aCondicional}
  ,
  {"AUTOW", accion, nada, nada, nada, aCondicional}
  ,
  {"AUTOR", accion, nada, nada, nada, aCondicional}
  ,
  {"PAUSE", accion, value, nada, nada, aNada}
  ,
  {"GOTO", accion, locno, nada, nada, aNada}
  ,
  {"MESSAGE", accion, mesno, nada, nada, aNada}
  ,
  {"REMOVE", accion, objno, nada, nada, aCondicional}
  ,
  {"GET", accion, objno, nada, nada, aCondicional}
  ,
  {"DROP", accion, objno, nada, nada, aCondicional}
  ,
  {"WEAR", accion, objno, nada, nada, aCondicional}
  ,
  {"DESTROY", accion, objno, nada, nada, aNada}
  ,
  {"CREATE", accion, objno, nada, nada, aNada}
  ,
  {"SWAP", accion, objno, objno, nada, aNada}
  ,
  {"PLACE", accion, objno, locno_, nada, aNada}
  ,
  {"SET", accion, flagno, nada, nada, aNada}
  ,
  {"CLEAR", accion, flagno, nada, nada, aNada}
  ,
  {"PLUS", accion, flagno, value, nada, aNada}
  ,
  {"MINUS", accion, flagno, value, nada, aNada}
  ,
  {"LET", accion, flagno, value, nada, aNada}
  ,
  {"NEWLINE", accion, nada, nada, nada, aNada}
  ,
  {"PRINT", accion, flagno, nada, nada, aNada}
  ,
  {"SYSMESS", accion, smesno, nada, nada, aNada}
  ,
  {"COPYOF", accion, objno, flagno, nada, aNada}
  ,
  {"COPYOO", accion, objno, objno, nada, aNada}
  ,
  {"COPYFO", accion, flagno, objno, nada, aNada}
  ,
  {"COPYFF", accion, flagno, flagno, nada, aNada}
  ,
  {"LISTOBJ", accion, nada, nada, nada, aNada}
  ,
  {"RAMSAVE", accion, nada, nada, nada, aNada}
  ,
  {"RAMLOAD", accion, flagno, nada, nada, aNada}
  ,
  {"BELL", accion, nada, nada, nada, aNada}
  ,
  {"ADD", accion, flagno, flagno, nada, aNada}
  ,
  {"SUB", accion, flagno, flagno, nada, aNada}
  ,
  {"PARSE", condicion, nada, nada, nada, aNada}
  ,
  {"LISTAT", accion, locno_, nada, nada, aNada}
  ,
  {"LISTNPC", accion, locno_, nada, nada, aNada}
  ,
  {"PROCESS", accion, prono, nada, nada, aNada}
  ,
  {"MES", accion, mesno, nada, nada, aNada}
  ,
  {"MODE", accion, value, nada, nada, aNada}
  ,
  {"TIME", accion, value, value, nada, aNada}
  ,
  {"DOALL", accion, locno_, nada, nada, aFinDeTabla}
  ,
  {"PROMPT", accion, smesno, nada, nada, aNada}
  ,
  {"WEIGH", accion, objno, flagno, nada, aNada}
  ,
  {"PUTIN", accion, objno, locno, nada, aCondicional}
  ,
  {"TAKEOUT", accion, objno, locno, nada, aCondicional}
  ,
  {"NEWTEXT", accion, nada, nada, nada, aNada}
  ,
  {"ABILITY", accion, value, value, nada, aNada}
  ,
  {"WEIGHT", accion, flagno, nada, nada, aNada}
  ,
  {"RANDOM", accion, flagno, nada, nada, aNada}
  ,
  {"WHATO", accion, nada, nada, nada, aNada}
  ,
  {"RESET", accion, locno, nada, nada, aDescribir}
  ,
  {"PUTO", accion, locno_, nada, nada, aNada}
  ,
  {"NOTDONE", accion, nada, nada, nada, aFinDeTabla}
  ,
  {"AUTOP", accion, locno, nada, nada, aCondicional}
  ,
  {"AUTOT", accion, locno, nada, nada, aCondicional}
  ,
  {"MOVE", condicion, flagno, nada, nada, aNada}
  ,
/* los del spectrum */
  {"EXTERN", accion, string, nada, nada, aNada} // Extern now runs javascript string
  ,
  {"PAPER", accion, value, nada, nada, aNada}
  ,
  {"INK", accion, value, nada, nada, aNada}
  ,
  {"BORDER", accion, value, nada, nada, aNada}
  ,
  {"CHARSET", accion, value, nada, nada, aNada}
  ,
  {"LINE", accion, value, nada, nada, aNada}
  ,
  {"PICTURE", accion, value, nada, nada, aNada}
  ,
  {"GRAPHIC", accion, value, nada, nada, aNada}
  ,
  {"INPUT", accion, value, nada, nada, aNada}
  ,
  {"SAVEAT", accion, nada, nada, nada, aNada}
  ,
  {"BACKAT", accion, nada, nada, nada, aNada}
  ,
  {"PRINTAT", accion, value, value, nada, aNada}
  ,
  {"PROTECT", accion, nada, nada, nada, aNada}
  ,
  {"BEEP", accion, value, value, value, aNada}
  ,
  /* Propio de Paguaglus */
  {"SOUND", accion, value, nada, nada, aNada}
  ,
  /* Propios de SuperGlus */
  {"OZERO", condicion, objno, value, nada, aNada}
  ,
  {"ONOTZERO", condicion, objno, value,  nada,aNada}
  ,
  {"OSET",  accion, objno, value, nada, aNada}
  ,
  {"OCLEAR",  accion, objno, value, nada, aNada}
  ,
  {"ISLIGHT",  condicion, nada, nada, nada, aNada}
  ,
  {"ISNOTLIGHT",  condicion, nada, nada, nada, aNada}
  ,
  {"DEBUG",  accion, value, nada, nada, aNada}
  ,
  {"WRITE",  accion, string, nada, nada, aNada}
  ,
  {"TRANSCRIPT",  accion, value, nada, nada, aNada}
  ,
  {"VERSION",  accion, nada, nada, nada, aNada}
  ,
  {"WRITELN",  accion, string, nada, nada, aNada}
  ,
  {"RESTART",  accion, nada, nada, nada, aNada}
  ,
  // Blocks
  {"}",  blockEnd, nada, nada, nada, aNada}
  ,
  {"{",  blockStart, nada, nada, nada, aNada}
};


int ultimo_condacto;

char libFile[2024];

FILE *fplugin;

int
BuscarCondacto (const char *nombre, TipoCondacto * condacto, int forceCondition)
{
  int i;

  for (i = 0; i <= ultimo_condacto && strcmp (nombre, condactos[i].nombre); i++);
  if (i == ultimo_condacto+1)
    return FALSE;

  // Dot condacts must be conditions
  if (forceCondition)  if ((condactos[i].tipo != mixto) && (condactos[i].tipo != condicion)) return FALSE;
  condacto->tipo = condactos[i].tipo;
  condacto->tipoArg1 = condactos[i].tipoArg1;
  condacto->tipoArg2 = condactos[i].tipoArg2;
  condacto->tipoArg3 = condactos[i].tipoArg3;
  return i;
};


void CargarDefinicionCondacto(char *fichero)
{
	FILE *f;
	char linea[32768];
	char bloque[32768];
	int inicial;
	int i , value;
	
	char *fullname;

	fullname = (char *)malloc(strlen(fichero)+6);
	fullname = strcpy(fullname, "/jsl/");
	strcat(fullname, fichero);

	strcpy(libFile,wd);
	strcat(libFile,fullname);

	
	f = fopen(libFile,"rt");
	fgets(linea,32768,f);
	if (linea[0]!=47) error(errGeneral,3);
	if (linea[1]!=47) error(errGeneral,3);
	ultimo_condacto++;
	inicial = 2;
	/* Obtenemos tipo de plugin */
	for (i=inicial;(linea[i]!=0)&&(linea[i]!=32)&&(i<32768);i++) {};

	strncpy (bloque, linea+inicial, i-inicial);
	bloque[i-inicial]=0;
	inicial=i+1;

	if (strlen(bloque)<3) error(errGeneral,3);

	if (strcmp(bloque,"LIB")==0) /* Es un bloque libreria */
	{
		ultimo_condacto--;
	}

	else 

	if (strcmp(bloque,"CND")==0) /* Es un condacto */
	{

		/* Obtenemos nombre de condacto */
		for (i=inicial;(linea[i]!=0)&&(linea[i]!=32)&&(i<32768);i++) {};

		strncpy (bloque, linea + inicial, i - inicial);
		bloque[i - inicial]=0;
		inicial=i+1;
	
		if (strlen(bloque)<1) error(errGeneral,3);


		condactos[ultimo_condacto].nombre = (char *)malloc(strlen(bloque)+1);
		strcpy(condactos[ultimo_condacto].nombre, bloque);



		

		/* Obtenemos tipo de condacto */
		for (i=inicial;(linea[i]!=0)&&(linea[i]!=32)&&(i<32768);i++) {};

		strncpy (bloque, linea+inicial, i-inicial);
		bloque[i-inicial]=0;
		inicial=i+1;

		if (strlen(bloque)!=1) error(errGeneral,3);

		switch (toupper(bloque[0])) 
		{
		case 65 : condactos[ultimo_condacto].tipo = accion;
				   break;
		case 67 : condactos[ultimo_condacto].tipo = condicion;
				   break;
		default : error(errGeneral,3); 
		}


		/* Obtenemos parámetro 1 */
		for (i=inicial;(linea[i]!=0)&&(linea[i]!=32)&&(i<32768);i++) {};

		strncpy (bloque, linea+inicial, i-inicial);
		bloque[i-inicial]=0;
		inicial=i+1;

		if (strlen(bloque)<1) error(errGeneral,3);

		value = atoi(bloque);
    
		condactos[ultimo_condacto].tipoArg1 = value;

		/* Obtenemos parámetro 2 */
		for (i=inicial;(linea[i]!=0)&&(linea[i]!=32)&&(i<32768);i++) {};

		strncpy (bloque, linea+inicial, i-inicial);
		bloque[i-inicial]=0;
		inicial=i+1;

		if (strlen(bloque)<1) error(errGeneral,3);

		value = atoi(bloque);
    
		condactos[ultimo_condacto].tipoArg2 = value;

		/* Obtenemos parámetro 3 */
		for (i=inicial;(linea[i]!=0)&&(linea[i]!=32)&&(i<32768);i++) {};

		strncpy (bloque, linea+inicial, i-inicial);
		bloque[i-inicial]=0;
		inicial=i+1;

		if (strlen(bloque)<1) error(errGeneral,3);

		value = atoi(bloque);
    
		condactos[ultimo_condacto].tipoArg3 = value;


		/* Obtenemos tipo de salida */
		for (i=inicial;(linea[i]!=0)&&(linea[i]!=32)&&(i<32768);i++) {};

		strncpy (bloque, linea+inicial, i-inicial);
		bloque[i-inicial]=0;
		inicial=i+1;

		if (strlen(bloque)<1) error(errGeneral,3);

		value = atoi(bloque);
    
		condactos[ultimo_condacto].limpieza = value;
	}
	else
	{
		error(errGeneral,3); /* No era ni LIB ni CND */
	}

	fputs(linea,fplugin); /* Copiamos resto de fichero plu en el plugin.js */
  
  
    while (fgets (linea, 32768, f))
	{
	  fputs (linea, fplugin);
	}
    fputs("\n",fplugin);


	fclose(f);

	free(fullname);
}

void CargarCondactosUsuario ()
{
	

   DIR *dir;
   struct dirent *ent;
   
   strcpy(libFile,wd);
   strcat(libFile,"/jsl/plugin.js");

   fplugin = fopen(libFile,"wt");
   if (fplugin == NULL)    error(errGeneral,2);
   fputs("\n//   PLUGINS    ;\n\n",fplugin);

   ultimo_condacto = NUMCONDACTOS - 1;

  strcpy(libFile,wd);
  strcat(libFile,"/jsl/");
  if ((dir = opendir(libFile)) == NULL)
   {
     error(errGeneral,3);
   }
   while ((ent = readdir(dir)) != NULL)
   {
		if (strstr(ent->d_name,".jsp")!=NULL)
		{
			printf("Loading plugin %s\n",ent->d_name);
			CargarDefinicionCondacto(ent->d_name);
		}
   }
	printf("\n");
   
   if (closedir(dir) != 0)
   	   error(errGeneral,2);

   fclose(fplugin);
}

	

void
InicializaCondactos()
{
	int i;
	for (i=0;i<NUMCONDACTOS;i++)
 	 condactos[i] = condactos_estandar[i];
	for (i = NUMCONDACTOS; i < NUMCONDACTOS+CONDACTOS_USUARIO; i++)
		condactos[i].nombre = ""; /* Ponemos el nombre del condacto vacio para que no lo encuentre en las búsquedas */
	CargarCondactosUsuario();
	return;
}

