
#include <config.h>

typedef struct {
  int num_mensaje;
  char * mensaje;
} tipo_mensaje;

typedef struct {
  int ocupado;
  int capacidad;
  tipo_mensaje * mensajes;
} tabla_mensajes;

extern tabla_mensajes *txtSistema;
extern tabla_mensajes *txtMensajes;
extern tabla_mensajes *txtObjetos;
extern tabla_mensajes *txtLugares;
extern tabla_mensajes *txtWrite;


extern int ultTextoSistema;
extern int ultTextoMensaje;
extern int ultTextoLugar;
extern int ultTextoObjeto;
extern int ultTextoWrite;

void agregarTexto (tabla_mensajes *, int, char *);

void dumpTexto (tabla_mensajes *);

char * limpiarTexto(char *cad);
