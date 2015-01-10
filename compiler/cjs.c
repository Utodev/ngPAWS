
#include "config.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>


#include "lexico.h"
#include "sintacti.h"
#include "errores.h"
#include "textos.h"
#include "vocabula.h"
#include "objetos.h"
#include "generar.h"

#if (defined(__MSDOS__))||(defined(WIN32))
#define PATH_SEPARATOR '\\'
#define uSOFT 1
#else
#define PATH_SEPARATOR '/'
#endif

char wd[2024];
char * nombre_archivo;
char * path_archivo;
int ver_hi=0;
int ver_lo=1;
int ver_verylo = 3;



int main (int argc, char *argv[])
{
  char *buscar;
  char *pgldir;
  char *gamedir;


  if (argc < 2)
  {
     error (errGeneral, 0);
     return -1;
   };


  // Find the folder with the JSL library	
  pgldir = getenv("NGPAWS_LIBPATH");
  if (pgldir==NULL) 
  {
	#ifdef WIN32
		strcpy(wd,argv[0]);
	#else
		strcpy (wd, getenv ("_"));
	#endif
	buscar = strrchr (wd, PATH_SEPARATOR);
	if (!buscar) 	buscar = strrchr (wd, PATH_SEPARATOR);
	if (buscar) 	*buscar = 0; else strcpy (wd, ".");
   }
   else 
   {
	strcpy(wd, pgldir);
   }

   nombre_archivo = strdup(argv[1]);
   

   // find the path of the file to be compiled
   gamedir = strdup(argv[1]);
   buscar = strrchr(gamedir, PATH_SEPARATOR);
   if (!buscar) path_archivo = strdup("."); 
   else { 
	   	 int l = strlen(gamedir);
	   	 while (gamedir[l-1] != PATH_SEPARATOR) l--;
    	 gamedir[l-1] = 0;
	   	 path_archivo =  strdup(gamedir);
   	};
   
   printf("== ARGV 0: %s", argv[0]);

   printf("=== ngpaws compiler v%i.%i.%i ===\n\n",ver_hi,ver_lo, ver_verylo);
   printf("ngPAWS directory found at %s\n",wd);
   printf("Game directory found at %s\n",path_archivo);
   InicializaCondactos();
   prepLexico (argv[1]);
   analizar();
   printf ("Completed.\n");
   termLexico ();
   GenerarEnsamblador (argv[1]);
   FinalizarVocabulario ();
   return 0;
}

