CC = gcc
OPTIONS =  
LIBS =
OBJS = condacto.o errores.o generar.o lexico.o objetos.o procesos.o salidas.o sintacti.o cjs.o textos.o vocabula.o cfgvars.o

all: ngpc

ngpc: $(OBJS) config.h
	$(CC) $(OPTIONS) -o Release/ngpc $(OBJS) $(LIBS)

config.h:
	touch config.h

clean:
	rm -f *~ *.o ngpc

.c.o:
	$(CC) $(OPTIONS) -c $?
