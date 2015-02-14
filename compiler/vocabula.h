
#include "config.h"

typedef enum
{
  verbo,
  nombre,
  adjetivo,
  adverbio,
  pronombre,
  conjuncion,
  preposicion
}
TiposDePalabra;

typedef struct
{
  char *pal;
  TiposDePalabra tipo;
  unsigned int num;
}
TipoPalabra;

typedef TipoPalabra *PPalabra;

void InicializarVocabulario (void);
void NuevaPalabra (char *palabra, TiposDePalabra tipo, unsigned int numero);
void FinalizarVocabulario(void);
int BuscarPalabra (char *, TipoPalabra *);
char *BuscarPalabraPorNumero (int numPal, TiposDePalabra tipo);

void dumpPalabras (void);

PPalabra SiguientePalabra (PPalabra anterior);


