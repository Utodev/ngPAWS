
#include "config.h"

#define TRUE (1==1)
#define FALSE (!(TRUE))

#ifdef WIN32

#define strcasecmp stricmp

#endif

extern char wd[80];
