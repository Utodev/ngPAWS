/*
 * textos.c
 *
 * Este archivo se encarga de almacenar los
 * diferentes textos de los mensajes.
 *
 */

#include <config.h>

#include <stdlib.h>
#include <stdio.h>
#include <malloc.h>
#include "textos.h"

#define TAM_INICIAL_TABLA 256
#define DELTA_TABLA 16

tabla_mensajes systxt = {0,0,NULL};
tabla_mensajes mestxt = {0,0,NULL};
tabla_mensajes objtxt = {0,0,NULL};
tabla_mensajes loctxt = {0,0,NULL};
tabla_mensajes writetxt = {0,0,NULL};	

tabla_mensajes *txtSistema = &systxt;
tabla_mensajes *txtMensajes = &mestxt;
tabla_mensajes *txtObjetos = &objtxt;
tabla_mensajes *txtLugares = &loctxt;
tabla_mensajes *txtWrite = &writetxt;

int ultTextoSistema = -1;
int ultTextoMensaje = -1;
int ultTextoLugar = -1;
int ultTextoObjeto = -1;
int ultTextoWrite = -1;

void
inicializarTabla (tabla_mensajes *tabla) {
  if(tabla->mensajes == NULL) {
    tabla->capacidad = TAM_INICIAL_TABLA;
    tabla->mensajes = (tipo_mensaje *)malloc(tabla->capacidad * sizeof(tipo_mensaje));
  }
}

void
agrandarTabla (tabla_mensajes *tabla) {
  tabla->capacidad += DELTA_TABLA;
  tabla->mensajes = (tipo_mensaje *)realloc(tabla->mensajes, tabla->capacidad * sizeof(tipo_mensaje));
}

void
agregarTexto (tabla_mensajes *tabla, int numero, char *texto)
{
  int i;
  for (i=0;i<strlen(texto);i++) if (texto[i]=='"') texto[i]='\'';
  if (tabla->mensajes == NULL) {
    inicializarTabla(tabla);
  }
  if(tabla->capacidad == tabla->ocupado) {
    agrandarTabla(tabla);
  }
  tabla->ocupado++;
  tabla->mensajes[tabla->ocupado-1].num_mensaje = numero;
  tabla->mensajes[tabla->ocupado-1].mensaje = texto;
}

void
dumpTexto (tabla_mensajes *tabla)
{
  int i;
  for (i = 0; i < tabla->ocupado; i++)
    /*if (tabla->mensajes[i] != NULL)*/
      printf ("%d:\n%s\n", i, tabla->mensajes[i]);
}

char * limpiarTexto(char *cad)
{
unsigned int i;
  for (i = 0; i < strlen (cad); i++)
  {
	  
	  if (cad[i]=='\\') 
	  {
		  cad[i++]=' ';
		  cad[i]=' ';
	  }
  }
  return cad;
}