
/* errores.h */

#include "config.h"

typedef enum
{ sinError, errGeneral, errLexSint, errSem, errVocab }
tipoError;

void error (tipoError, int);
void blockError(int nError, int line);