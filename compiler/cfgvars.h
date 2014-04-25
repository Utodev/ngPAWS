
#ifndef CFGVARS_H
#define CFGVARS_H

void initcfgvars();
int iscfgvar(const char * varname);
int isvalidcfgvar(const char * name);
void putcfgvar(const char * varname, const char * varvalue);
const char * cfgvarvalue(const char * varname, const char * defaultvalue);

#endif

