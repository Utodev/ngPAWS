//LIB lang_CA

//-----------------------------------------------------------
//  Aquesta funció personalitza les sequències d'escapament 
//  {OREF} i {OBJECT} per fer-les servir en català.
//----------------------------------------------------------

// Aux functions
function getApostrophe(objno)
{
	var ATTR_APOSTROPHE = 22;
	var mustApostropheWord = objectIsAttr(objno, ATTR_APOSTROPHE);
	return mustApostropheWord;
}

function getObjectFixArticles_lang_CA(objno)
{
	var object_text = getObjectText(objno);
	var object_words = object_text.split(' ');
	if (object_words.length == 1) return object_text;
	var candidate = object_words[0];
	object_words.splice(0, 1);
	if ( (candidate!='un') && (candidate!='una') && (candidate!='uns') && (candidate!='unes') && (candidate!='algun') && (candidate!='algunes') ) return object_text;
	var gender = getAdvancedGender(objno);
	var shouldApostrophe = getApostrophe(objno);
	if ((gender == 'F' || gender == 'M' || gender == 'N') && shouldApostrophe) return "l'" + object_words.join(' ');
	if (gender == 'F') return 'la ' + object_words.join(' ');
	if (gender == 'M') return 'el ' + object_words.join(' ');
	if (gender == 'N') return 'el ' + object_words.join(' ');
	if (gender == 'PF') return 'les ' + object_words.join(' ');
	if (gender == 'PM') return 'els ' + object_words.join(' ');
	if (gender == 'PN') return 'els ' + object_words.join(' ');
}


// Sequence tag replacement

var old_writeHook_lang_CA = h_sequencetag;
var h_sequencetag = function (tagparams)
{
	var tag = tagparams[0].toUpperCase();
	switch (tag)
	{
	case 'OREF':
		if (tagparams.length != 1) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
   		if(objects[getFlag(FLAG_REFERRED_OBJECT)]) return getObjectFixArticles_lang_CA(getFlag(FLAG_REFERRED_OBJECT)); else return '';
   		break;
	case 'OBJECT':
		if (tagparams.length != 2) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
		if(objects[getFlag(tagparams[1])]) return getObjectFixArticles_lang_CA(getFlag(tagparams[1])); else return '';
		break;
	default:
		return old_writeHook_lang_CA(tagparams);
	}
}


// Personalized normalize function adapted for Catalan language

normalize = function(player_order)
	// Removes accented characters and makes sure every sentence separator (colon, semicolon, quotes, etc.) has one space before and after. Also, all separators are converted to comma
{
	player_order = player_order.replace(/l'/gi, "").replace(/'l/gi, "-ho").replace(/d'/gi, "de ").replace(/'n/gi, " en").replace(/'t/gi, "te")
	var originalchars = 'áéíóúäëïöüâêîôûàèìòùÁÉÍÓÚÄËÏÖÜÂÊÎÔÛÀÈÌÒÙ';
	var i;
	var output = '';
	var pos;

	for (i=0;i<player_order.length;i++) 
	{
		pos = originalchars.indexOf(player_order.charAt(i));
		if (pos!=-1) output = output + "aeiou".charAt(pos % 5); else 
		{
			ch = player_order.charAt(i);
				if ((ch=='.') || (ch==',') || (ch==';') || (ch=='"') || (ch=='\'') || (ch=='«') || (ch=='»')) output = output + ' , '; else output = output + player_order.charAt(i);
		}

	}
	return output;
}

//CND HELP A 0 0 0 0
//Catalan help responses

function ACChelp()
{
	writeText('<b>• Com dono ordres al joc?</b>');
	writeText(STR_NEWLINE);
	writeText('Utilitzeu ordres en imperatiu o infinitiu: OBRE PORTA, AGAFAR CLAU, PUJAR, etc.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com em puc moure pel joc?</b>');
	writeText(STR_NEWLINE);
	writeText('Generalment, mitjançant els punts cardinals com NORD (abreujat «N»), SUD (S), EST (E), OEST (O) o amb direccions espacials (AMUNT, AVALL, BAIXAR, PUJAR, ENTRAR, SORTIR, etc.). Algunes aventures permeten també ordres com «ANAR AL POU». Normalment sabreu cap a quina direcció podreu anar per la descripció que rebreu. A alguns jocs podreu escriure «SORTIDES» perquè us mostri exactament de quines disposau.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com puc saber quins objectes duc?</b>');
	writeText(STR_NEWLINE);
	writeText('Teclegeu INVENTARI (abreujat «I»)');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com uso els objectes?</b>');
	writeText(STR_NEWLINE);
	writeText('Utilizeu un verb el més concret que pogueu, en lloc de «USAR ESCOMBRA» escriviu «ESCOMBRAR».');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com puc mirar de prop un objecte o observar-lo més detalladament?</b>');
	writeText(STR_NEWLINE);
	writeText('AMB el verb «EXAMINAR»: «EXAMINAR PLAT». Generalment es pot usar l\'abreviatura «EX»: «EX PLAT».');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com puc tornar a veure la descripció del lloc on sóc?</b>');
	writeText(STR_NEWLINE);
	writeText('Escriviu «MIRAR» (abreujat «M»).');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com parlo amb els personatges?</b>');
	writeText(STR_NEWLINE);
	writeText('Les formes més comunes són [PERSONATGE, FRASE] o [DIR A PERSONATGE «FRASE»]. Per exemple: «LLUÍS, HOLA» o «DIR A LLUÍS "HOLA"». A algunes aventures també es pot utilitzar «PARLAR A LLUÍS». ');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com poso quelcom dins un contenidor? Com ho trec?</b>');
	writeText(STR_NEWLINE);
	writeText('«FICAR CLAU DINS CAIXA». «TREU CLAU DE CAIXA»');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com poso quelcom a sobre una altra cosa? Com ho trec?</b>');
	writeText(STR_NEWLINE);
	writeText('«POSAR CLAU DAMUNT TAULA». «AGAFAR CLAU DE TAULA');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com deso i carrego la partida?</b>');
	writeText(STR_NEWLINE);
	writeText('Usa les ordres «DESAR» i «CARREGAR».');
	writeText(STR_NEWLINE + STR_NEWLINE);
}	

