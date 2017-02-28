OS := $(shell uname)
CC = gcc
ifeq ($(OS),Darwin)
OPTIONS = -I/usr/include/malloc/ 
else
OPTIONS =  
endif
LIBS =
OBJS = condacto.o errores.o generar.o lexico.o objetos.o procesos.o salidas.o sintacti.o cjs.o textos.o vocabula.o cfgvars.o

all: ngpc

ngpc: $(OBJS) config.h
	$(CC) $(OPTIONS) -o ngpc $(OBJS) $(LIBS)

config.h:
	touch config.h

clean:
	rm -f *~ *.o ngpc.exe ngpc

.c.o:
	$(CC) $(OPTIONS) -c $?


win32: ngpc
OPTIONS= -O2 -m32 -static-libgcc -static-libstdc++