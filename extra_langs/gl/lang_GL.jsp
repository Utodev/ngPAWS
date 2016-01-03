//LIB lang_GL

//-----------------------------------------------------------
//  Esta funcion personaliza las secuencias de escape {OREF} y 
//  {OBJECT} para su uso con el idioma gallego.
//----------------------------------------------------------

// Aux functions
function getObjectFixArticles_lang_GL(objno)
{
	var object_text = getObjectText(objno);
	var object_words = object_text.split(' ');
	if (object_words.length == 1) return object_text;
	var candidate = object_words[0];
	object_words.splice(0, 1);
	if ( (candidate!='un') && (candidate!='unha') && (candidate!='unhos') && (candidate!='unhas') && (candidate!='algunha') && (candidate!='algunhos') && (candidate!='algunhas') && (candidate!='algun')) return object_text;
	var gender = getAdvancedGender(objno);
	if (gender == 'F') return 'a ' + object_words.join(' ');
	if (gender == 'M') return 'o ' + object_words.join(' ');
	if (gender == 'N') return 'o ' + object_words.join(' ');
	if (gender == 'PF') return 'as ' + object_words.join(' ');
	if (gender == 'PM') return 'os ' + object_words.join(' ');
	if (gender == 'PN') return 'os ' + object_words.join(' ');
}


// Sequence tag replacement




var old_writeHook_lang_GL = h_sequencetag;
var h_sequencetag = function (tagparams)
{
	var tag = tagparams[0].toUpperCase();
	switch (tag)
	{
	case 'OREF':
		if (tagparams.length != 1) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
   		if(objects[getFlag(FLAG_REFERRED_OBJECT)]) return getObjectFixArticles_lang_GL(getFlag(FLAG_REFERRED_OBJECT)); else return '';
   		break;
	case 'OBJECT':
		if (tagparams.length != 2) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
		if(objects[getFlag(tagparams[1])]) return getObjectFixArticles_lang_GL(getFlag(tagparams[1])); else return '';
		break;
	default:
		return old_writeHook_lang_GL(tagparams);
	}
}

