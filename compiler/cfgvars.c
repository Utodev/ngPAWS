
#include "cfgvars.h"

#include "config.h"
#include <string.h>
#include <stdlib.h>

#define MAXCFGVARS 200

/* On WIN32 and DOS compilers strcasecmp does not exist,  stricmp is used instead */
#if (defined(__MSDOS__))||(defined(WIN32))
#define strcasecmp stricmp
#endif

char * cfgvars[MAXCFGVARS];
char * cfgvarvalues[MAXCFGVARS];
int ncfgvars = 0;

#define nvalidvars 67

char * validvars[nvalidvars] = {

  "MUSICSTOP",

  "WINDOWBORDERS",
  "WINDOWFRAME",
  "WINDOWWIDTH",
  "WINDOWHEIGHT",
  "WINDOWMASK",
  "PROPORTIONALFACE",
  "PROPORTIONALSIZE",
  "TYPEWRITERFACE",
  "TYPEWRITERSIZE",

  "TYPEWRITER_0",
  "BOLD_0",
  "ITALIC_0",
  "FOREGROUND_0",
  "BACKGROUND_0",
  
  "TYPEWRITER_1",
  "BOLD_1",
  "ITALIC_1",
  "FOREGROUND_1",
  "BACKGROUND_1",
  
  "TYPEWRITER_2",
  "BOLD_2",
  "ITALIC_2",
  "FOREGROUND_2",
  "BACKGROUND_2",
  
  "TYPEWRITER_3",
  "BOLD_3",
  "ITALIC_3",
  "FOREGROUND_3",
  "BACKGROUND_3",
  
  "TYPEWRITER_4",
  "BOLD_4",
  "ITALIC_4",
  "FOREGROUND_4",
  "BACKGROUND_4",
  
  "TYPEWRITER_5",
  "BOLD_5",
  "ITALIC_5",
  "FOREGROUND_5",
  "BACKGROUND_5",
  
  "TYPEWRITER_6",
  "BOLD_6",
  "ITALIC_6",
  "FOREGROUND_6",
  "BACKGROUND_6",
  
  "TYPEWRITER_7",
  "BOLD_7",
  "ITALIC_7",
  "FOREGROUND_7",
  "BACKGROUND_7",
  
  "TYPEWRITER_8",
  "BOLD_8",
  "ITALIC_8",
  "FOREGROUND_8",
  "BACKGROUND_8",
  
  "TYPEWRITER_9",
  "BOLD_9",
  "ITALIC_9",
  "FOREGROUND_9",
  "BACKGROUND_9",
  
  "TYPEWRITER_10",
  "BOLD_10",
  "ITALIC_10",
  "FOREGROUND_10",
  "BACKGROUND_10",
  
  "GRAPHIC_PERCENT",
  "GRAPHIC_POSITION"
};

void
addcfgvar(const char * , const char * );

void
initcfgvars()
{
  int i;
  
  ncfgvars = 0;
  for(i=0;i<MAXCFGVARS;i++)
  {
    cfgvars[i] = cfgvarvalues[i] = NULL;
  }
}

void
putcfgvar(const char * varname, const char * varvalue)
{
  int i;
  
  if(iscfgvar(varname))
  {
    for(i=0;i<ncfgvars;i++)
    {
      if(!strcasecmp(cfgvars[i], varname))
      {
        if(cfgvarvalues[i]!=NULL)
	{
	  free(cfgvarvalues[i]);
	}
	cfgvarvalues[i] = ((varvalue == NULL)?NULL:strdup(varvalue));
	break;
      }
    }
  }
  else
  {
    addcfgvar(varname, varvalue);
  }
}

void
addcfgvar(const char * varname, const char * varvalue)
{
  if((varname==NULL) || (ncfgvars==MAXCFGVARS))
  {
    return;
  }
  if(iscfgvar(varname))
  {
    putcfgvar(varname, varvalue);
  }
  else
  {
    cfgvars[ncfgvars] = strdup(varname);
    cfgvarvalues[ncfgvars++] = ((varvalue==NULL)?NULL:strdup(varvalue));
  }
}

const char *
cfgvarvalue(const char * varname, const char * defaultvalue)
{
  int i;
  
  for(i=0;i<ncfgvars;i++)
  {
    if(!strcasecmp(cfgvars[i], varname))
    {
      return cfgvarvalues[i];
    }
  }
  return defaultvalue;
}

int
iscfgvar(const char * varname)
{
  int i;
  
  for(i=0;i<ncfgvars;i++)
  {
    if(!strcasecmp(cfgvars[i], varname))
    {
      return 1;
    }
  }
  return 0;
}

int isvalidcfgvar(const char * name) {
  int i;
  
  for(i=0;i<nvalidvars;i++)
  {
    if(!strcasecmp(validvars[i], name))
    {
      return 1;
    }
  }
  return 0;
}

int checkvalidcfgvars() {
  int i;
  
  for(i=0;i<ncfgvars;i++)
  {
    if(!isvalidcfgvar(cfgvars[i]))
    {
      return 0;
    }
  }
  return 1;  
}

