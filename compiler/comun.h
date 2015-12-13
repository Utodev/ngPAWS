
#include "config.h"


#ifndef TRUE
 #define TRUE (1==1)
 #define FALSE (!(TRUE))
#endif

#ifdef WIN32

#define strcasecmp stricmp

#endif

extern char wd[80];
