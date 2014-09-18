
#include "config.h"

typedef struct _tipoEntrada
{
  int verbo, nombre;
  int posicion;
  struct _tipoEntrada *sig;
  int condactos[512];
}
TipoEntrada;

/*extern char *procesos[256];*/
extern TipoEntrada *procesos[256];
extern int ultProceso;
extern int interrupt_proc;

void NuevoProceso (int);
void agregarEntrada (int, TipoEntrada *);
void agregarCondacto (int, int, int, int, int);
void FinalizarProcesos (void);
TipoEntrada *SiguienteEntrada (int numProceso, TipoEntrada * anterior);
