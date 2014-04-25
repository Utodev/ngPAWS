
//   PLUGINS    ;

//CND ATGE C 8 0 0 0

function CNDatge(locno)
{
	return (getFlag(FLAG_LOCATION) >= locno);
}

//CND ATLE C 8 0 0 0

function CNDatle(locno)
{
	return (getFlag(FLAG_LOCATION) <= locno);
}

//CND BCLEAR A 1 2 0 0

function ACCbclear(flagno, bitno)
{
	if (bitno>=32) return;
	setFlag(flagno, bitclear(getFlag(flagno), bitno));
}
//CND BLOCK A 14 2 2 0

function ACCblock(writeno, picno, procno)
{
   disableInterrupt();
   text = writemessages[writeno]
   text = h_writeText(text); // hook
   text = filterText(text)
   $('.block_text').html(text);
   
	var filename = getResourceById(RESOURCE_TYPE_IMG, picno);
	if (filename)
	{
		var imgsrc = '<img class="block_picture" src="' + filename + '" />';
		$('.block_graphics').html(imgsrc);
	}
    $('.block_layer').show();
    if (procno == 0 ) unblock_process ==null; else unblock_process = procno;
}
//CND BNEG A 1 2 0 0

function ACCbneg(flagno, bitno)
{
	if (bitno>=32) return;
	setFlag(flagno, bitneg(getFlag(flagno),bitno));
}
//CND BNOTZERO C 1 2 0 0

function CNDbnotzero(flagno, bitno)
{
	if (bitno>=32) return false;
	return (bittest(getFlag(flagno), bitno));
}

//CND BREAK A 0 0 0 0

function ACCbreak()
{
	doall_flag = false; 
	entry_for_doall = '';
}
//CND BSET A 1 2 0 0

function ACCbset(flagno, bitno)
{
	if (bitno>=32) return;
	setFlag(flagno, bitset(getFlag(flagno),bitno));
}
//CND BZERO C 1 2 0 0

function CNDbzero(flagno, bitno)
{
	if (bitno>=32) return false;
	return (!bittest(getFlag(flagno), bitno));
}
//CND CLEAREXIT A 2 0 0 0

function ACCclearexit(wordno)
{
	if ((wordno >= NUM_CONNECTION_VERBS) || (wordno< 0 )) return;
	setConnection(loc_here(),-1);
}
//CND COMMAND A 2 0 0 0

function ACCcommand(value)
{
	if (value) $('.input').show(); else $('.input').hide();
}
//CND DIV A 1 2 0 0

function ACCdiv(flagno, valor)
{
	if (valor == 0) return;
	setFlag(flagno, Math.Floor(getFlag(flagno) / valor));
}
//CND EXITS A 8 5 0 0

function ACCexits(locno,mesno)
{
  if ((getFlag(FLAG_LIGHT) == 0) || ((getFlag(FLAG_LIGHT) != 0) && lightObjectsPresent()))
  {
  		exitcount = 0;
  		for (i=0;i<NUM_CONNECTION_VERBS;i++) if (getConnection(locno, i) != -1) exitcount++;
      if (exitcount)
      {
    		writeMessage(mesno);
    		exitcountprogress = 0;
    		for (i=0;i<NUM_CONNECTION_VERBS;i++) if (getConnection(locno, i) != -1)
    		{ 
    			exitcountprogress++;
    			writeMessage(mesno + 2 + i);
    			if (exitcountprogress == exitcount) writeSysMessage(SYSMESS_LISTEND);
    			if (exitcountprogress == exitcount-1) writeSysMessage(SYSMESS_LISTLASTSEPARATOR);
    			if (exitcountprogress == exitcount-2) writeSysMessage(SYSMESS_LISTSEPARATOR);
  		  }
      } else writeMessage(mesno + 1);
  } else writeMessage(mesno + 1);
}

//CND FADEIN A 2 2 2 0

function ACCfadein(sfxno, channelno, times)
{
	if ((channelno <1) || (channelno >MAX_CHANNELS)) return;  //SFX channels from 1 to MAX_CHANNELS, channel 0 is for location music and can't be used here
	sfxplay(sfxno, channelno, times, 'fadein');
}
//CND GE C 1 2 0 0

function CNDge(flagno, valor)
{
	return (getFlag(flagno)>=valor);
}
//CND GETEXIT A 2 2 0 0

function ACCgetexit(value,flagno)
{
	if (value >= NUM_CONNECTION_VERBS) 
		{
			setFlag(flagno, NO_EXIT);
			return;
		}
	locno = getConnection(loc_here(),value);
	if (locno == -1)
		{
			setFlag(flagno, NO_EXIT);
			return;
		}
	setFlag(flagno,locno);
}
//CND HELP A 0 0 0 0

function ACChelp()
{
	writeText('?C?O DOY ?DENES AL PERSONAJE?');
	writeText(STR_NEWLINE);
	writeText('Utiliza ?denes en imperativo o infinitivo: ABRE PUERTA, COGER LLAVE, SUBIR, etc.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('?C?O ME MUEVO POR EL JUEGO?');
	writeText(STR_NEWLINE);
	writeText('Por regla general, mediante los puntos cardinales como norte (abreviado "N"), sur (S), este (E), oeste (O) o direcciones espaciales (arriba, abajo, bajar, subir, entrar, salir, etc.). Algunas aventuras permiten tambi? cosas como "ir a pozo". Normalmente podr? saber en que direcci? puedes ir por la descripci? del sitio, aunque algunos juegos implementan el comando "SALIDAS" que te dir?exactamente cuales hay.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('?C?O PUEDO SABER QUE OBJETOS LLEVO?');
	writeText(STR_NEWLINE);
	writeText('Teclea INVENTARIO (abreviado "I")');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('?C?O USO LOS OBJETOS?');
	writeText(STR_NEWLINE);
	writeText('Utiliza el verbo correcto, en lugar de USAR ESCOBA escribe BARRER.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('?C?O PUEDO MIRAR DE CERCA UN OBJETO U OBSERVARLO M?S DETALLADAMENTE?');
	writeText(STR_NEWLINE);
	writeText('Con el verbo examinar: EXAMINAR PLATO. Generalmente se puede usar la abreviatura "EX" : EX PLATO.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('?C?O PUEDO VER DE NUEVO LA DESCRIPCI? DEL SITIO DONDE ESTOY?');
	writeText(STR_NEWLINE);
	writeText('Escribe MIRAR (abreviado "M").');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('?C?O HABLO CON LOS PERSONAJES?');
	writeText(STR_NEWLINE);
	writeText('En algunas aventuras tambi? se puede utilizar el formato [HABLAR A LUIS]. Los m?odos m? comunes son [PERSONAJE, FRASE] o [DECIR A PERSONAJE "FRASE"]. Por ejemplo: [LUIS, HOLA] o [DECIR A LUIS "HOLA"].');
	writeText(STR_NEWLINE + STR_NEWLINE);
}
//CND ISMUSIC C 0 0 0 0

function cnd_ismusic()
{
	return (CNDissound(0));	
}

//CND ISNOTMUSIC C 0 0 0 0

function CNDisnotmusic()
{
  return !CNDismusic();
}

//CND ISNOTSOUND C 1 0 0 0

function CNDisnotsound(channelno)
{
  if ((channelno <1) || (channelno >MAX_CHANNELS)) return false;
  return !(CNDissound(channelno));
}
//CND ISSOUND C 1 0 0 0

function CNDissound(channelno)
{
	if ((channelno <1 ) || (channelno > MAX_CHANNELS)) return false;
    return channelActive(channelno);
}
//CND LE C 1 2 0 0

function CNDle(flagno, valor)
{
	return (getFlag(flagno) <= valor);
}
//CND LOG A 14 0 0 0

function ACClog(writeno)
{
  console_log(writemessages[writeno]);
}
//CND MOD A 1 2 0 0

function ACCmod(flagno, valor)
{
	if (valor == 0) return;
	setFlag(flagno, Math.Floor(getFlag(flagno) % valor));
}
//CND MUL A 1 2 0 0

function ACCmul(flagno, valor)
{
	if (valor == 0) return;
	setFlag(flagno, Math.Floor(getFlag(flagno) * valor));
}
//CND NPCAT A 9 1 0 0

function ACCnpcat(locno, flagno)
{
	setFlag(flagno,getNPCCountAt(locno));
}

//CND OBJAT A 9 1 0 0

function ACCobjat(locno, flagno)
{
	setFlag(flagno, getObjectCountAt(locno));
}
//CND OBJFOUND C 2 9 0 0

function CNDobjfound(attrno, locno)
{

	for (i=0;i<num_objects;i++) 
		if ((getObjectLocation(i) == locno) && (CNDonotzero(i,attrno))) return true;
	return false;
}

//CND OBJNOTFOUND C 2 9 0 0

function CNDobjnotfound(attrno, locno)
{
   return !CNDobjfound(attrno, locno);
}
//CND ONEG A 4 2 0 0

function ACConeg(objno, attrno)
{
	if (attrno > 63) return;
	if (attrno <= 31)
	{
		attrs = getObjectLowAttributes(objno);
		bitneg(attrs, attrno);
		setObjectLowAttributes(objno, attrs);
		return;
	}
	attrs = getObjectHighAttributes(objno);
	attrno = attrno - 32;
	bitneg(attrs, attrno);
	setObjectHighAttributes(objno, attrs);
}

//CND PICTUREAT A 2 2 2 0

function ACCpictureat(x,y,picno)
{
	filename = getResourceById(RESOURCE_TYPE_IMG, picno);
	if (!filename) return;

	var screenImage = $('.location_picture');
	if (!screenImage) return;

	// Create a new image with the contents of current image, to be able to calculate original height of image
	var theImage = new Image();

	// Get curent height 
		theImage.onload = function()
		{
			var screenImageHeight = screenImage.height();
			var screenImageX = Math.floor((parseInt($('.graphics').width()) - screenImage.width())/2);;
	    	var imageHeight    = theImage.height; 
			// Calculate scale and x, Y position
			scale =  screenImageHeight / imageHeight;
			x = Math.floor(x * scale);
			y = Math.floor(y * scale);


			// now load new image
			id = 'pictureat_' + picno;
			// add new image
			$('.graphics').append('<img id="'+id+'" style="display:none" />');

			var newImage = new Image();
			newImage.onload = function ()
			{
				newimageHeight = Math.floor(newImage.height * scale);
				$('#' + id).css('position','absolute');
				$('#' + id).css('left', x + screenImageX + 'px');
				$('#' + id).css('top',y + 'px');
				$('#' + id).css('z-index','100');
				$('#' + id).attr('src', filename);
				$('#' + id).css('height',newimageHeight + 'px');
				$('#' + id).show();
			}
			newImage.src = filename;
			};
	theImage.src = screenImage.attr("src");

}

//CND RANDOMX A 1 2 0 0

function ACCrandomx(flagno, value)
{
	 setFlag(flagno, 1 + Math.floor((Math.random()*value)));
}
//CND RNDWRITE A 14 14 14 0

function ACCrndwrite(writeno1,writeno2,writeno3)
{
	val = Math.floor((Math.random()*3));
	switch (val)
	{
		case 0 : writeWriteMessage(writeno1);break;
		case 1 : writeWriteMessage(writeno2);break;
		case 2 : writeWriteMessage(writeno3);break;
	}
}
//CND RNDWRITELN A 14 14 14 0

function ACCrndwriteln(writeno1,writeno2,writeno3)
{
	ACCrndwrite(writeno1,writeno2,writeno3);
	ACCnewline();
}
//CND SETEXIT A 2 2 0 0

function ACCsetexit(value, locno)
{
	if (value < NUM_CONNECTION_VERBS) setConnection(loc_here(), value, locno);
}
//CND SETWEIGHT A 4 2 0 0

function ACCsetweight(objno, value)
{
   objectsWeight[objno] = value;
}

//CND SILENCE A 2 0 0 0

function ACCsilence(channelno)
{
	if ((channelno <1) || (channelno >MAX_CHANNELS)) return;
	sfxstop(channelno);
}
//CND TEXTPIC A 2 2 0 0

function ACCtextpic(picno, align)
{
	filename = getResourceById(RESOURCE_TYPE_IMG, picno);
	if (filename)
	texto = "<img src='"+filename+"' />";
	writeText(texto);
}
//CND TITLE A 14 0 0 0

function ACCtitle(writeno)
{
	document.title = writemessages[writeno];
}
//CND VOLUME A 2 2 0 0

function ACCvolume(channelno, value)
{
	if ((channelno <1) || (channelno >MAX_CHANNELS)) return;
	sfxvolume(channelno, value);
}

//CND WHATOX A 1 0 0 0

function ACCwhatox(flagno)
{
	whatoxfound = getReferredObject();
	setFlag(flagno,whatoxfound);
}

//CND WHATOX2 A 1 0 0 0

function ACCwhatox2(flagno)
{	
	auxNoun = getFlag(FLAG_NOUN1);
	auxAdj = getFlag(FLAG_ADJECT1);
	setFlag(FLAG_NOUN1, getFlag(FLAG_NOUN2));
	setFlag(FLAG_ADJECT1, getFlag(FLAG_ADJECT2));
	whatox2found = getReferredObject();
	setFlag(flagno,whatox2found);
	setFlag(FLAG_NOUN1, auxNoun);
	setFlag(FLAG_ADJECT1, auxAdj);
}
//CND YOUTUBE A 14 0 0 0

function ACCyoutube(strno)
{

	str = '<iframe id="youtube" width="560" height="315" src="http://www.youtube.com/embed/' + writemessages[strno] + '?autoplay=1&controls=0&modestbranding=1&showinfo=0" frameborder="0" allowfullscreen></iframe>'
	$('#text').css('height','45%');
	$('#graphics').css('height','45%');
	$('#graphics').html(str);
	$('#youtube').css('height','100%');
	$('#youtube').css('display','block');
	$('#youtube').css('margin-left','auto');
	$('#youtube').css('margin-right','auto');
	$('#graphics').show();
}
//CND ZONE C 8 8 0 0

function CNDzone(locno1, locno2)
{

	if (loc_here()<locno1) return false;
	if (loc_here()>locno2) return false;
	return true;
}
