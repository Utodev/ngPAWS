//CND HELP A 0 0 0 0

function ACChelp()
{
	if (getLang()=='EN') EnglishHelp(); else SpanishHelp();
}	

function EnglishHelp()
{
	writeText('HOW DO I SEND COMMANDS TO THE PC?');
	writeText(STR_NEWLINE);
	writeText('Use simple orders: OPEN DOOR, TAKE KEY, GO UP, etc.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('HOW CAN I MOVE IN THE MAP?');
	writeText(STR_NEWLINE);
	writeText('Usually you will have to use compass directions as north (shortcut: "N"), south (S), east (E), west (W) or other directions (up, down, enter, leave, etc.). Some games allow complex order like "go to well". Usually you would be able to know avaliable exits by location description, some games also provide the "EXITS" command.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('HOW CAN I CHECK MY INVENTORY?');
	writeText(STR_NEWLINE);
	writeText('type INVENTORY (shortcut "I")');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('HOW CAN I USE THE OBJECTS?');
	writeText(STR_NEWLINE);
	writeText('Use the proper verb, that is, instead of USE KEY type OPEN.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('HOW CAN I CHECK SOMETHING CLOSELY?');
	writeText(STR_NEWLINE);
	writeText('Use "examine" verb: EXAMINE DISH. (shortcut: EX)');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('HOW CAN I SEE AGAIN THE CURRENT LOCATION DSCRIPTION?');
	writeText(STR_NEWLINE);
	writeText('Type LOOK (shortcut "M").');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('HOW CAN I TALK TO OTHER CHARACTERS?');
	writeText(STR_NEWLINE);
	writeText('Most common methods are [CHARACTER, SENTENCE] or [SAY CHARACTER "SENTENCE"]. For instance: [JOHN, HELLO] o [SAY JOHN "HELLO"]. Some games also allow just [TALK TO JOHN]. ');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('HOW CAN I PUT SOMETHING IN A CONTAINER, HOW CAN I TAKE SOMETHING OUT?');
	writeText(STR_NEWLINE);
	writeText('PUT KEY IN BOX. TAKE KEY OUT OF BOX. INSERT KEY IN BOX. EXTRACT KEY FROM BOX.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('HOW CAN I PUT SOMETHING ON SOMETHING ELSE?');
	writeText(STR_NEWLINE);
	writeText('PUT KEY ON TABLE. TAKE KEY FROM TABLE');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('¿CÓMO SAVE/RESTORE MY GAME?');
	writeText(STR_NEWLINE);
	writeText('Use SAVE/LOAD commands.');
	writeText(STR_NEWLINE + STR_NEWLINE);

}

function SpanishHelp()
{
	writeText('¿CÓMO DOY ORDENES AL PERSONAJE?');
	writeText(STR_NEWLINE);
	writeText('Utiliza órdenes en imperativo o infinitivo: ABRE PUERTA, COGER LLAVE, SUBIR, etc.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('¿CÓMO ME MUEVO POR EL JUEGO?');
	writeText(STR_NEWLINE);
	writeText('Por regla general, mediante los puntos cardinales como norte (abreviado "N"), sur (S), este (E), oeste (O) o direcciones espaciales (arriba, abajo, bajar, subir, entrar, salir, etc.). Algunas aventuras permiten también cosas como "ir a pozo". Normalmente podrás saber en que dirección puedes ir por la descripción del sitio, aunque algunos juegos facilitan el comando "SALIDAS" que te dirá exactamente cuales hay.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('¿CÓMO PUEDO SABER QUE OBJETOS LLEVO?');
	writeText(STR_NEWLINE);
	writeText('Teclea INVENTARIO (abreviado "I")');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('¿CÓMO USO LOS OBJETOS?');
	writeText(STR_NEWLINE);
	writeText('Utiliza el verbo correcto, en lugar de USAR ESCOBA escribe BARRER.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('¿CÓMO PUEDO MIRAR DE CERCA UN OBJETO U OBSERVARLO MÁS DETALLADAMENTE?');
	writeText(STR_NEWLINE);
	writeText('Con el verbo examinar: EXAMINAR PLATO. Generalmente se puede usar la abreviatura "EX" : EX PLATO.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('¿CÓMO PUEDO VER DE NUEVO LA DESCRIPCIÓN DEL SITIO DONDE ESTOY?');
	writeText(STR_NEWLINE);
	writeText('Escribe MIRAR (abreviado "M").');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('¿CÓMO HABLO CON LOS PERSONAJES?');
	writeText(STR_NEWLINE);
	writeText('Los modos más comunes son [PERSONAJE, FRASE] o [DECIR A PERSONAJE "FRASE"]. Por ejemplo: [LUIS, HOLA] o [DECIR A LUIS "HOLA"]. En algunas aventuras también se puede utilizar el formato [HABLAR A LUIS]. ');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('¿CÓMO METO ALGO EN UN CONTENEDOR? ¿COMO SACO ALGO?');
	writeText(STR_NEWLINE);
	writeText('METER LLAVE  EN CAJA. SACAR LLAVE DE CAJA');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('¿CÓMO PONGO ALGO SOBRE ALGO? ¿COMO LO QUITO?');
	writeText(STR_NEWLINE);
	writeText('PONER LLAVE EN MESA. COGER LLAVE DE MESA');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('¿CÓMO GRABO Y CARGO LA PARTIDA?');
	writeText(STR_NEWLINE);
	writeText('Usa las órdenes SAVE y LOAD, o CARGAR Y GRABAR.');
	writeText(STR_NEWLINE + STR_NEWLINE);
}