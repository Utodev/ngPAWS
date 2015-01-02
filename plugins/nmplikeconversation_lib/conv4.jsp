//LIB conv4


$(document).ready(function(){
	conv_active_sentences = conv_active_sentences.concat([27,28,29,30,31,32,33,36,37,38,39,41,43,44,45,80,81]);
});

function runConv4(convFlag)
{
    option_id = 1;
    clearConvOptionsArray();
	switch (getFlag(convFlag))
	{
		case 0:
			if (conv_active_sentences.indexOf(27) != -1) convOptionWrite(4,option_id++, '¿Dónde estoy?', convFlag, 27);
			if (conv_active_sentences.indexOf(28) != -1) convOptionWrite(4,option_id++, '¿Quién es usted?',convFlag, 28 );
			if (conv_active_sentences.indexOf(33) != -1) if (CNDzero(110) && CNDcarried(0) ) convOptionWrite(4,option_id++, '¿Qué planta es esa?', convFlag, 33);
			if (conv_active_sentences.indexOf(80) != -1) if (CNDnotzero(143) && CNDnotzero(88) ) convOptionWrite(4,option_id++, '¿Como puedo conseguir otro somniferus?', convFlag,80);
			if (conv_active_sentences.indexOf(81) != -1) if (CNDnotzero(143) && CNDzero(88) )	convOptionWrite(4,option_id++,'¿Como puedo conseguir otro somniferus?', convFlag, 81);
			if (conv_active_sentences.indexOf(36) != -1) if (CNDnotzero(110) && CNDzero(88) && CNDcarried(0))	convOptionWrite(4,option_id++,'Supongo que esto es lo que queria.',convFlag, 36);
			if (conv_active_sentences.indexOf(32) != -1) if (CNDnotzero(88)) convOptionWrite(4,option_id++ , 'Cúenteme algo sobre el fortín.', convFlag, 32);
			if (conv_active_sentences.indexOf(45) != -1) if (CNDnotzero(89)) convOptionWrite(4,option_id++ , '¿De qué discutían usted y el armero?.', convFlag, 45);
			if (conv_active_sentences.indexOf(34) != -1) convOptionWrite(4,option_id++,'Adiós.', convFlag, 34);
			if (conv_active_sentences.indexOf(35) != -1) convOptionWrite(4,option_id++,'Adiós.', convFlag, 35);
		break;
		case 1:
			if (conv_active_sentences.indexOf(29) != -1) convOptionWrite(4,option_id++, '¿Barbero forzoso?', convFlag, 29);
			if (conv_active_sentences.indexOf(30) != -1) convOptionWrite(4,option_id++, 'Creo que he perdido la memoria.', convFlag, 30);
			if (conv_active_sentences.indexOf(31) != -1) convOptionWrite(4,option_id++, 'Estoy al servicio del capitán Álvarez ¿Sigue con vida?', convFlag, 31);
			if (conv_active_sentences.indexOf(33) != -1) convOptionWrite(4,option_id++, '¿Qué pasó con el naufragio?', convFlag, 33);
		break;
		case 2:
			if (conv_active_sentences.indexOf(37) != -1) if (CNDnotzero(89)) convOptionWrite(4,option_id++,'¿De qué discutían usted y el armero?', convFlag, 37);
			if (conv_active_sentences.indexOf(38) != -1) convOptionWrite(4,option_id++, '¿Qué pasó con los náufragos?', convFlag, 38);
			if (conv_active_sentences.indexOf(39) != -1) if (CNDnotzero(90)) convOptionWrite(4,option_id++, '¿Qué buca el armero por las noches?', convFlag, 39);
			if (conv_active_sentences.indexOf(42) != -1) convOptionWrite(4,option_id++, '¿No queda especia?', convFlag, 42);
			if (conv_active_sentences.indexOf(46) != -1) convOptionWrite(4,option_id++, '¿Dónde van a buscarla?', convFlag, 46);
			if (conv_active_sentences.indexOf(43) != -1) convOptionWrite(4,option_id++, '¿Por qué hay tan poca gente en el fortín?', convFlag, 43);
			if (conv_active_sentences.indexOf(40) != -1) convOptionWrite(4,option_id++, '¿Qué especia?', convFlag, 40);
			if (conv_active_sentences.indexOf(41) != -1) convOptionWrite(4,option_id++, ' Es suficiente.', convFlag, 41);
		break;
		default: ACClet(convFlag, 0);  ACCcommand(1); return; // salir de conversación
	}

}

function responseConv4(convFlag, value)
{
	clearConvOptionsArray();
	$('.nmpconvoption a').attr('onclick','');
	switch (value)
	{
		// menu 0
		case 27: writeText("¿No es evidente?  Se encuentra en la más desastrosa enfermería del fortín más dejado de la mano de Dios.\n"); 
		         ACCexclude(27); 
		         break;

		case 28: writeText("Soy el barbero forzoso del lugar. El Capitán está interesado en saber quién es usted.\n");
		         ACCexclude(28);
		         ACClet(convFlag, 1);
		         break;

		case 33: writeText(" Déjeme ver...  - la coge cuidadosamente en la mano y empieza a diseccionarla con la mirada - Parece ser un Somniferus Radicalus, se disuelve fácilmente en cualquier líquido.\n"); 
				 ACCdestroy(17);
				 ACCexclude(33);
				 ACCset(110);
				 ACCexclude(34);
				 ACCinclude(35);
				 ACCget(0);
		         break;

		case 80: writeText("Todavía conservo el que me dió. Tenga.\n");
				 ACCget(0);
				 ACCexclude(80);
		         break;

		case 81: writeText("Consígame una flor como la que trajo anteriormente.\n");
				 ACCexclude(81);
 				 break;

		case 36: writeText("Déjeme ver... - tras un momento de observación, desliza la planta en uno de sus bolsillos - Como dije, sabré ser generoso. ¿Qué le gustaria saber sobre el Fortín?\n");
				 ACCdestroy(17);
				 ACCset(88);
				 ACCset(142);
				 ACCexclude(45);
		         break;

		case 32: writeText("¿Qué quiere saber?\n");
				 ACClet(convFlag,2);
				 break;

		case 45: writeText("Preferiría no hablar de ello.\n");
				 ACClet(convFlag,100);
				 break;

		case 34: writeText("Por aquí estaré.\n");
				 ACClet(convFlag,100);
		         break;

		case 35: writeText("Por aquí estaré. El barbero como expresando un deseo oculto dice: 'Si puede conseguirme otro Somniferus para mi estudio, sabré ser generoso'.\n");
				 ACCexclude(35);
				 ACCinclude(34);
				 ACClet(convFlag,100);
		         break;

		// menu 1
		case 29: writeText("Sí. En realidad soy un estudioso de las hierbas, acepté el trabajo para así tener la oportunidad de viajar al nuevo mundo.\n");
				 ACCexclude(29);
		         break;

		case 30: writeText("No parece tener ninguna herida en la cabeza. Tómese un tiempo para recordar lo sucedido y vaya a ver al capitán.\n");
				 ACCexclude(30);
				 ACCinclude(34);
				 ACClet(convFlag,0);
		         break;

		case 31: writeText("No se ha encontrado a ningún Capitán Álvarez entre los heridos - Ves como se levanta y sale fuera.\n");
				 ACCexclude(31);
				 ACCset(77);			  // Da la alarma para que te maten
				 ACClet(convFlag,100);
		         break;

		case 44: writeText("Esperaba que fuese usted quien dijera algo. Por lo que he oído debieron de chocar contra alguna roca, espero que no llevasen un cargamento importante.\n");
		         break;


		// menu 2
		case 37: writeText("De qué discutiremos, querrá decir. Todas las tardes viene con el mismo cuento, se queja de dolores imaginarios. Todo por conseguir una dósis de la especia.\n");
				 ACCexclude(37);
				 ACCinclude(40);
		         break;

		case 38: writeText("Esa pregunta es fácil de responder: No hubo supervivientes.");
				 ACCexclude(38);
		         break;

		case 39: writeText("Probablemente la especia. Pero no la encontrará, no queda. Me pregunto que podrá más,  si la especia o el nulo sentido común que queda del hombre que fue.\n");
				 ACCexclude(39);
				 ACCinclude(40);
				 ACCinclude(42);
		         break;

		case 42: writeText("En efecto. Como ya escuchó al armero, van a organizar otra expedición y esta vez iremos todos. Prefiriría no ir, pero si no lo hago el Capitán se encargará personalmente de mi.\n");
				 ACCexclude(42);
				 ACCinclude(46);
		         break;

		case 46: writeText("No lo sé. Creo que a una plantación natural que hay en el interior de la isla. Pero el trayecto debe de ser muy peligroso, son pocos los que vuelven...\n");
				 ACCexclude(46);
		         break;

		case 43: writeText("Hará ya dos años desde nuestra llegada, créame si le digo que la vida aquí es muy dura. Se diria que la tierra está maldita. Cuando la encontramos pensamos que era medicinal, hasta que tuvimos problemas y la gente empezó a morir.\n");
				 ACCexclude(43);
		         break;

		case 40: writeText("La expresión del barbero se vuelve grave - La planta del soldado. Vinimos para conseguir un buen lugar donde 'comerciar' sin ser vistos, pero la encontramos. Será nuestra definitiva perdición, nadie la sobrevive, créame... NADIE.\n");
				 ACCexclude(40);
		         break;

		case 41: writeText("Acepte mi consejo: cuídese del veneno que no mata.\n");
				 ACClet(convFlag,0);
		         break;
	};

	runConv4(convFlag);
}

