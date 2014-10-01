	// This file is (C) Carlos Sanchez 2014, released under the MIT license



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                         Auxiliary functions                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// General functions
String.prototype.rights= function(n){
    if (n <= 0)
       return "";
    else if (n > String(this).length)
       return this;
    else {
       var iLen = String(this).length;
       return String(this).substring(iLen, iLen - n);
    }
}


String.prototype.firstToLower= function()
{
	return  this.charAt(0).toLowerCase() + this.slice(1);	
	return a;
}
 

// Returns true if using Internet Explorer 9 or below, where some features are not supported
function isBadIE () {
  var myNav = navigator.userAgent.toLowerCase();
  if (myNav.indexOf('msie') == -1) return false;
  ieversion =  parseInt(myNav.split('msie')[1]);
  return (ieversion<10);
}


function runningLocal()
{
	return (window.location.protocol == 'file:');
}



// waitKey helper for ANYKEY and GETKEY

function waitKey(callbackFunction)
{
	anykey_return_function = callbackFunction;
	disableInterrupt();
   	$('.block_layer').css('display','none');
    $('.block_text').html('');
    $('.block_graphics').html('');
    $('.block_layer').css('background','transparent');
    $('.block_layer').css('display','block');
    $('.input').hide();
}

function waitKeyCallback()
{
 			var callback = anykey_return_function;
     		anykey_return_function = null;
			hideBlock();    		
     		callback();
     		if (describe_location_flag) descriptionLoop();  		
}


// Check DOALL entry

function skipdoall(entry)
{
	return  ((doall_flag==true) && (entry_for_doall!='') && (entry_for_doall > entry));
}

// Dynamic attribute use functions
function getNextFreeAttribute()
{
	var value = nextFreeAttr;
	nextFreeAttr++;
	return value;
}


// Gender functions

function getSimpleGender(objno)  // Simple, for english
{
 	isPlural = objectIsAttr(objno, ATTR_PLURALNAME);
 	if (isPlural) return "P";
 	isFemale = objectIsAttr(objno, ATTR_FEMALE);
 	if (isFemale) return "F";
 	isMale = objectIsAttr(objno, ATTR_MALE);
 	if (isMale) return "M";
    return "N"; // Neuter
}

function getAdvancedGender(objno)  // Complex, for spanish
{
 	var isPlural = objectIsAttr(objno, ATTR_PLURALNAME);
 	var isFemale = objectIsAttr(objno, ATTR_FEMALE);
 	var isMale = objectIsAttr(objno, ATTR_MALE);

 	if (!isPlural) 
 	{
	 	if (isFemale) return "F";
	 	if (isMale) return "M";
	    return "N"; // Neuter
 	}
 	else
 	{
	 	if (isFemale) return "PF";
	 	if (isMale) return "PM";
	 	return "PN"; // Neuter plural
 	}

}

function getLang()
{
	var value = bittest(getFlag(FLAG_PARSER_SETTINGS),5);
	if (value) return "ES"; else return "EN";
}

function getObjectFixArticles(objno)
{
	var object_text = getObjectText(objno);
	var object_words = object_text.split(' ');
	if (object_words.length == 1) return object_text;
	var candidate = object_words[0];
	object_words.splice(0, 1);
	if (getLang()=='EN')
	{
		if ((candidate!='an') && (candidate!='a') && (candidate!='some')) return object_text;
		return 'the ' + object_words.join(' ');
	}
	else
	{
		if ( (candidate!='un') && (candidate!='una') && (candidate!='unas') && (candidate!='unas') && (candidate!='alguna') && (candidate!='algunos') && (candidate!='algunas') && (candidate!='alguno')) return object_text;
		var gender = getAdvancedGender(objno);
		if (gender == 'F') return 'la ' + object_words.join(' ');
		if (gender == 'M') return 'el ' + object_words.join(' ');
		if (gender == 'N') return 'el ' + object_words.join(' ');
		if (gender == 'PF') return 'las ' + object_words.join(' ');
		if (gender == 'PM') return 'los ' + object_words.join(' ');
		if (gender == 'PN') return 'los ' + object_words.join(' ');
	}	


}



// JS level log functions
function console_log(string)
{
	if (typeof console != "undefined") console.log(string);
}


// Resources functions
function getResourceById(resource_type, id)
{
	for (var i=0;i<resources.length;i++)
	 if ((resources[i][0] == resource_type) && (resources[i][1]==id)) return resources[i][2];
	return false; 
}

// Flag read/write functions
function getFlag(flagno)
{
	 return flags[flagno];
}

function setFlag(flagno, value)
{
	 flags[flagno] = value;
}

// Locations functions
function loc_here()  // Returns current location, avoid direct use of flags
{
	 return getFlag(FLAG_LOCATION);
}


// Connections functions

function setConnection(locno1, dirno, locno2)
{
	connections[locno1][dirno] = locno2;
}

function getConnection(locno, dirno)
{
	return connections[locno][dirno];
}

// Objects text functions

function getObjectText(objno)
{
	return objects[objno];
}


// Output processing functions

function implementTag(tag)
{
	tagparams = tag.split('|');
	for (var tagindex=0;tagindex<tagparams.length-1;tagindex++) tagparams[tagindex] = tagparams[tagindex].trim();
	if (tagparams.length == 0) {writeText(STR_INVALID_TAG_SEQUENCE_EMPTY); return ''}

	switch(tagparams[0].toUpperCase())
	{
		case 'URL': if (tagparams.length != 3) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
					return '<a target="_blank" href="' + tagparams[1]+ '">' + tagparams[2] + '</a>';
					break;
		case 'CLASS': if (tagparams.length != 3) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
					  return '<span class="' + tagparams[1]+ '">' + tagparams[2] + '</span>';
					  break;
		case 'STYLE': if (tagparams.length != 3) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
					  return '<span style="' + tagparams[1]+ '">' + tagparams[2] + '</span>';
					  break;
		case 'INK': if (tagparams.length != 3) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
					  return '<span style="color:' + tagparams[1]+ '">' + tagparams[2] + '</span>';
					  break;
		case 'PAPER': if (tagparams.length != 3) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
					  return '<span style="background-color:' + tagparams[1]+ '">' + tagparams[2] + '</span>';
					  break;
		case 'OBJECT': if (tagparams.length != 2) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
					   if(objects[getFlag(tagparams[1])]) return getObjectFixArticles(getFlag(tagparams[1])); else return '';
					   break;
		case 'WEIGHT': if (tagparams.length != 2) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
					   if(objectsWeight[getFlag(tagparams[1])]) return objectsWeight[getFlag(tagparams[1])]; else return '';
					   break;
		case 'OLOCATION': if (tagparams.length != 2) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
					      if(objectsLocation[getFlag(tagparams[1])]) return objectsLocation[getFlag(tagparams[1])]; else return '';
					      break;
		case 'MESSAGE':if (tagparams.length != 2) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
					   if(messages[getFlag(tagparams[1])]) return messages[getFlag(tagparams[1])]; else return '';
					   break;
		case 'SYSMESS':if (tagparams.length != 2) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
					   if(sysmessages[getFlag(tagparams[1])]) return sysmessages[getFlag(tagparams[1])]; else return '';
					   break;
		case 'LOCATION':if (tagparams.length != 2) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
					   if(locations[getFlag(tagparams[1])]) return locations[getFlag(tagparams[1])]; else return '';
					   break;
		case 'PROCESS':if (tagparams.length != 2) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
					   callProcess(tagparams[1]);
					   break;
		case 'ACTION': if (tagparams.length != 3) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
					   return '<a href="javascript: void(0)" onclick="orderEnteredLoop(\'' + tagparams[1]+ '\')">' + tagparams[2] + '</a>';
					   break;
		case 'RESTART': if (tagparams.length != 2) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
					    return '<a href="javascript: void(0)" onclick="restart()">' + tagparams[1] + '</a>';
					    break;
		case 'EXTERN': if (tagparams.length != 3) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
					    return '<a href="javascript: void(0)" onclick="' + tagparams[1] + ' ">' + tagparams[2] + '</a>';
					    break;
		case 'TEXTPIC': if (tagparams.length != 3) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
						var style = '';
						var post = '';
						var pre = '';
						align = tagparams[2];
						switch(align)
						{
							case 1: style = 'float:left'; break;
							case 2: style = 'float:right'; break;
							case 3: post = '<br />';
							case 4: pre='<center>';post='</center>';break;
						}
						return pre + "<img class='textpic' style='"+style+"' src='"+ RESOURCES_DIR + tagparams[1]+"' />" + post;
					    break;
		case 'HTML': if (tagparams.length != 2) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
						return tagparams[1];
					    break;
		case 'FLAG': if (tagparams.length != 2) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
						return getFlag(tagparams[1]);
					    break;
		case 'OREF': if (tagparams.length != 1) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
   			        if(objects[getFlag(FLAG_REFERRED_OBJECT)]) return getObjectFixArticles(getFlag(FLAG_REFERRED_OBJECT)); else return '';
					break;
		case 'OPRO': if (tagparams.length != 1) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};  // returns the pronoun for a given object, used for english start database
					 switch (getSimpleGender(getFlag(FLAG_REFERRED_OBJECT)))
					 {
					 	case 'M' : return "him";
					 	case "F" : return "her";
					 	case "N" : return "it";
					 	case "P" : return "them";  // plural returns them
					 }
					break;
			default : return h_sequencetag(tagparams);
	}
}

function processTags(text)
{
	//Apply the {} tags filtering
	var pre, post, innerTag;
	tagfilter:
	while (text.indexOf('{') != -1)
	{
		if (( text.indexOf('}') == -1 ) || ((text.indexOf('}') < text.indexOf('{'))))
		{
			writeText(STR_INVALID_TAG_SEQUENCE + text);
			break tagfilter;
		}
		pre = text.substring(0,text.indexOf('{'));
		var openbracketcont = 1;
		pointer = text.indexOf('{') + 1;
		innerTag = ''
		while (openbracketcont>0)
		{
			if (text.charAt(pointer) == '{') openbracketcont++;
			if (text.charAt(pointer) == '}') openbracketcont--;
			innerTag = innerTag + text.charAt(pointer);
			pointer++;
		}
		innerTag = innerTag.substring(0,innerTag.length - 1);
		post = text.substring(pointer);
		if (innerTag.indexOf('{') != -1 ) innerTag = processTags(innerTag); 
		innerTag = implementTag(innerTag);
		text = pre + innerTag + post;
	}
	return text;
}

function filterText(text)
{
	// ngPAWS sequences
	text = processTags(text);


	// Superglus sequences (only \n remains)
    text = text.replace(/\n/g, STR_NEWLINE);

	// PAWS sequences (only underscore)
	objno = getFlag(FLAG_REFERRED_OBJECT);
	if ((objno != EMPTY_OBJECT) && (objects[objno]))	text = text.replace(/_/g,getObjectText(objno).firstToLower()); else text = text.replace(/_/g,'');

	return text;
}

// Text Output functions
function writeText(text)
{
	text = h_writeText(text); // hook
	text = filterText(text)
	$('.text').append(text);
	$(".text").scrollTop($(".text")[0].scrollHeight);
	addToTranscript(text);
	focusInput();
}

function addToTranscript(text)
{
	transcript = transcript + text;		
}

function writelnText(text)
{
	writeText(text + STR_NEWLINE);
}

function writeMessage(mesno)
{
	if (messages[mesno]!=null) writeText(messages[mesno]); else writeText(STR_NEWLINE + STR_WRONG_MESSAGE + ' [' + mesno + ']');
}

function writeSysMessage(sysno)
{
		if (sysmessages[sysno]!=null) writeText(sysmessages[sysno]); else writeText(STR_NEWLINE + STR_WRONG_SYSMESS + ' [' + sysno + ']');
		$(".text").scrollTop($(".text")[0].scrollHeight);
}

function writeWriteMessage(writeno)
{
		writeText(writemessages[writeno]); 
}

function writeObject(objno)
{
	writeText(getObjectText(objno));
}

function clearTextWindow()
{
	$('.text').empty();
}


function clearInputWindow()
{
	$('.prompt').val('');
}


function writeLocation(locno)
{
	if (locations[locno]!=null) writeText(locations[locno] + STR_NEWLINE); else writeText(STR_NEWLINE + STR_WRONG_LOCATION + ' [' + locno + ']');
}

// Screen control functions

function clearGraphicsWindow()
{
	$('.graphics').empty();	
}


function clearScreen()
{
	clearInputWindow();
	clearTextWindow();
	clearGraphicsWindow();
}

function copyOrderToTextWindow(player_order)
{
	last_player_order = player_order;
	clearInputWindow();
	writeText(STR_PROMPT);
	writelnText(player_order);
}



// Graphics functions


function hideGraphicsWindow()
{
		$('.text').removeClass('half_text');
		$('.text').addClass('all_text');
		$('.graphics').removeClass('half_graphics');
		$('.graphics').addClass('hidden');
		if ($('.location_picture')) $('.location_picture').remove();
}



function drawPicture(picno)  
{
	var pictureDraw = false;
	if (graphicsON) 
	{
		if ((isDarkHere()) && (!lightObjectsPresent())) picno = 0;
		var filename = getResourceById(RESOURCE_TYPE_IMG, picno);
		if (filename)
		{
			$('.graphics').removeClass('hidden');
			$('.graphics').addClass('half_graphics');
			$('.text').removeClass('all_text');
			$('.text').addClass('half_text');
			$('.graphics').html('<img class="location_picture" src="' +  filename + '" />');
			$('.location_picture').css('height','100%');
			pictureDraw = true;
		}
	}

	if (!pictureDraw) hideGraphicsWindow();
}




function clearPictureAt() // deletes all pictures drawn by "pictureAT" condact
{
	$.each($('.graphics img'), function () {
		if ($(this)[0].className!= 'location_picture') $(this).remove();
	});

}

// Turns functions

function incTurns()
{
	turns = getFlag(FLAG_TURNS_LOW) + 256 * getFlag(FLAG_TURNS_HIGH)  + 1;
	setFlag(FLAG_TURNS_LOW, turns % 256);
	setFlag(FLAG_TURNS_HIGH, Math.floor(turns / 256));
}

// input box functions

function disableInput()
{
	$(".input").prop('disabled', true); 
}

function enableInput()
{
	$(".input").prop('disabled', false); 
}

function focusInput()
{
	$(".prompt").focus();
	timeout_progress = 0;
}

// Object default attributes functions

function objectIsNPC(objno)
{
	if (objno > last_object_number) return false;
	return bittest(getObjectLowAttributes(objno), ATTR_NPC);
}

function objectIsLight(objno)
{
	if (objno > last_object_number) return false;
	return bittest(getObjectLowAttributes(objno), ATTR_LIGHT);
}

function objectIsWearable(objno)
{
	if (objno > last_object_number) return false;
	return bittest(getObjectLowAttributes(objno), ATTR_WEARABLE);
}

function objectIsContainer(objno)
{
	if (objno > last_object_number) return false;
	return bittest(getObjectLowAttributes(objno), ATTR_CONTAINER);
}

function objectIsAttr(objno, attrno)
{
	if (attrno > 63) return false;
	attrs = getObjectLowAttributes(objno);
	if (attrno > 31)
	{
		attrs = getObjectHighAttributes(objno);
		attrno = attrno - 32;
	}
	return bittest(attrs, attrno);
}

function isAccesibleContainer(objno)
{
	if (objectIsAttr(objno, ATTR_SUPPORTER)) return true;   // supporter
	if ( objectIsContainer(objno) && !objectIsAttr(objno, ATTR_OPENABLE) ) return true;  // No openable container
	if ( objectIsContainer(objno) && objectIsAttr(objno, ATTR_OPENABLE) && objectIsAttr(objno, ATTR_OPEN)  )  return true;  // No openable & open container
	return false;
}

//Objects and NPC functions

function findMatchingObject(locno)
{
	for (var i=0;i<num_objects;i++)
		if ((locno==-1) || (getObjectLocation(i) == locno))
		 if (((objectsNoun[i]) == getFlag(FLAG_NOUN1)) && (((objectsAdjective[i]) == EMPTY_WORD) || ((objectsAdjective[i]) == getFlag(FLAG_ADJECT1))))  return i;
	return EMPTY_OBJECT;
}

function getReferredObject()
{
	var objectfound = EMPTY_OBJECT; 
	refobject_search: 
	{
		object_id = findMatchingObject(LOCATION_CARRIED);
		if (object_id != EMPTY_OBJECT)	{objectfound = object_id; break refobject_search;}	

		object_id = findMatchingObject(LOCATION_WORN);
		if (object_id != EMPTY_OBJECT)	{objectfound = object_id; break refobject_search;}	

		object_id = findMatchingObject(loc_here());
		if (object_id != EMPTY_OBJECT)	{objectfound = object_id; break refobject_search;}	

		object_id = findMatchingObject(-1);
		if (object_id != EMPTY_OBJECT)	{objectfound = object_id; break refobject_search;}	
	}
	return objectfound;
}


function getObjectLowAttributes(objno)
{
	return objectsAttrLO[objno];
}

function getObjectHighAttributes(objno)
{
	return objectsAttrHI[objno]
}


function setObjectLowAttributes(objno, attrs)
{
	objectsAttrLO[objno] = attrs;
}

function setObjectHighAttributes(objno, attrs)
{
	objectsAttrHI[objno] = attrs;
}


function getObjectLocation(objno)
{
	if (objno > last_object_number) 
		writeText(STR_INVALID_OBJECT + ' [' + objno + ']');
	return objectsLocation[objno];
}

function setObjectLocation(objno, locno)
{
	if (objectsLocation[objno] == LOCATION_CARRIED) setFlag(FLAG_OBJECTS_CARRIED_COUNT, getFlag(FLAG_OBJECTS_CARRIED_COUNT) - 1);
	objectsLocation[objno] = locno;
	if (objectsLocation[objno] == LOCATION_CARRIED) setFlag(FLAG_OBJECTS_CARRIED_COUNT, getFlag(FLAG_OBJECTS_CARRIED_COUNT) + 1);
}



// Sets all flags associated to  referred object by current LS  
function setReferredObject(objno) 
{
	if (objno == EMPTY_OBJECT)
	{
		setFlag(FLAG_REFERRED_OBJECT, EMPTY_OBJECT);
		setFlag(FLAG_REFERRED_OBJECT_LOCATION, LOCATION_NONCREATED);
		setFlag(FLAG_REFERRED_OBJECT_WEIGHT, 0);
		setFlag(FLAG_REFERRED_OBJECT_LOW_ATTRIBUTES, 0);
		setFlag(FLAG_REFERRED_OBJECT_HIGH_ATTRIBUTES, 0);
		return;
	}
	setFlag(FLAG_REFERRED_OBJECT, objno);
	setFlag(FLAG_REFERRED_OBJECT_LOCATION, getObjectLocation(objno));
	setFlag(FLAG_REFERRED_OBJECT_WEIGHT, getObjectWeight(objno));
	setFlag(FLAG_REFERRED_OBJECT_LOW_ATTRIBUTES, getObjectLowAttributes(objno));
	setFlag(FLAG_REFERRED_OBJECT_HIGH_ATTRIBUTES, getObjectHighAttributes(objno));

}


function getObjectWeight(objno) 
{
	var weight = objectsWeight[objno];
	if ( ((objectIsContainer(objno)) || (objectIsAttr(objno, ATTR_SUPPORTER))) && (weight!=0)) // Container with zero weigth are magic boxes, anything you put inside weigths zero
  		weight = weight + getLocationObjectsWeight(objno);
	return weight;
}


function getLocationObjectsWeight(locno) 
{
	var weight = 0;
	for (var i=0;i<num_objects;i++)
	{
		if (getObjectLocation(i) == locno) 
		{
			objweight = objectsWeight[i];
			weight += objweight;
			if (objweight > 0)
			{
				if (  (objectIsContainer(i)) || (objectIsAttr(i, ATTR_SUPPORTER)) )
				{	
					weight += getLocationObjectsWeight(i);
				}
			}
		}
	}
	return weight;
}

function getObjectCountAt(locno) 
{
	var count = 0;
	for (i=0;i<num_objects;i++)
	{
		if (getObjectLocation(i) == locno) 
		{
			attr = getObjectLowAttributes(i);
			if (!bittest(getFlag(FLAG_PARSER_SETTINGS),3)) count ++;  // Parser settings say we should include NPCs as objects
			 else if (!objectIsNPC(i)) count++;     // or object is not an NPC
		}
	}
	return count;
}


function getObjectCountAtWithAttr(locno, attrno) 
{
	var count = 0;
	for (i=0;i<num_objects;i++)
		if (   (getObjectLocation(i) == locno)  && (objectIsAttr(i, attrno))) count++;
	return count;
}


function getNPCCountAt(locno) 
{
	var count = 0;
	for (i=0;i<num_objects;i++)
		if ((getObjectLocation(i) == locno) &&  (objectIsNPC(i))) count++;
	return count;
}


// Location light function

function lightObjectsAt(locno) 
{
	return getObjectCountAtWithAttr(locno, ATTR_LIGHT) > 0;
}


function lightObjectsPresent() 
{
  if (lightObjectsAt(LOCATION_CARRIED)) return true;
  if (lightObjectsAt(LOCATION_WORN)) return true;
  if (lightObjectsAt(loc_here())) return true;
  return false;
}


function isDarkHere()
{
	return (getFlag(FLAG_LIGHT) != 0);
}

// Sound functions


function preloadsfx()
{
	for (var i=0;i<resources.length;i++)
	 	if (resources[i][0] == 'RESOURCE_TYPE_SND') 
	 	{
	 		var fileparts = resources[i][2].split('.');
			var basename = fileparts[0];
			var mySound = new buzz.sound( basename, {  formats: [ "ogg", "mp3" ] , preload: true} );
	 	}
}

function sfxplay(sfxno, channelno, times, method)
{

	if (!soundsON) return;
	if ((channelno <0) || (channelno >MAX_CHANNELS)) return;
	if (times == 0) times = -1; // more than 4000 million times
	var filename = getResourceById(RESOURCE_TYPE_SND, sfxno);
	if (filename)
	{
		var fileparts = filename.split('.');
		var basename = fileparts[0];
		var mySound = new buzz.sound( basename, {  formats: [ "ogg", "mp3" ] });
		if (soundChannels[channelno]) soundChannels[channelno].stop();
		soundLoopCount[channelno] = times;
		mySound.bind("ended", function(e) {
			for (sndloop=0;sndloop<MAX_CHANNELS;sndloop++)
				if (soundChannels[sndloop] == this)
				{
					if (soundLoopCount[sndloop]==-1) {this.play(); return }
					soundLoopCount[sndloop]--;
					if (soundLoopCount[sndloop] > 0) {this.play(); return }
					sfxstop(sndloop);
					return;
				}
		});
		soundChannels[channelno] = mySound;
		if (method=='play')	mySound.play(); else mySound.fadeIn(2000);
	}
}

function playLocationMusic(locno)
{
	if (soundsON) 
		{
			sfxstop(0);
			sfxplay(locno, 0, 0, 'play');
		}
}

function musicplay(musicno, times)  
{
	sfxplay(musicno, 0, times);
}

function channelActive(channelno)
{
	if (soundChannels[channelno]) return true; else return false;
}


function sfxstopall() 
{
	for (channelno=0;channelno<MAX_CHANNELS;channelno++) sfxstop(channelno);

}


function sfxstop(channelno)
{
	if (soundChannels[channelno]) 
		{
			soundChannels[channelno].unbind('ended');
			soundChannels[channelno].stop();
			soundChannels[channelno] = null;
		}
}

function sfxvolume(channelno, value)
{
	if (soundChannels[channelno]) soundChannels[channelno].setVolume(Math.floor( value * 100 / 65535)); // Inherited volume condact uses a number among 0 and 65535, buzz library uses 0-100.
}

function isSFXPlaying(channelno)
{
	if (!soundChannels[channelno]) return false;
	return true;
}


function sfxfadeout(channelno, value)
{
	if (!soundChannels[channelno]) return;
	soundChannels[channelno].fadeOut(value, function() { sfxstop(channelno) });
}

// Process functions

function callProcess(procno)
{
	var prostr = procno.toString(); 
	while (prostr.length < 3) prostr = "0" + prostr;
	if (procno==0) in_response = true;
	if (doall_flag && in_response) done_flag = false;
	if (!in_response) done_flag = false;
	eval("pro" + prostr + "()");
	if (procno==0) in_response = false;
	
}

// Bitwise functions

function bittest(value, bitno)
{
	mask = 1 << bitno;
	return ((value & mask) != 0);
}

function bitset(value, bitno)
{

	mask = 1 << bitno;
	return value | mask;
}

function bitclear(value, bitno)
{
	mask = 1 << bitno;
	return value & (~mask);
}


function bitneg(value, bitno) 
{
	mask = 1 << bitno;
	return value ^ mask;

}

// Savegame functions
function getSaveGameObject()
{
	var savegame_object = new Object();
	// Notice that slice() is used to make sure a copy of each array is assigned to the object, no the arrays themselves
	savegame_object.flags = flags.slice();
	savegame_object.objectsLocation = objectsLocation.slice();
	savegame_object.objectsWeight = objectsWeight.slice();
	savegame_object.objectsAttrLO = objectsAttrLO.slice();
	savegame_object.objectsAttrHI = objectsAttrHI.slice();
	savegame_object.connections = connections.slice();
	savegame_object = h_saveGame(savegame_object);
	return savegame_object;
}

function restoreSaveGameObject(savegame_object)
{
	flags = savegame_object.flags;
	// Notice that slice() is used to make sure a copy of each array is assigned to the object, no the arrays themselves
	objectsLocation = savegame_object.objectsLocation.slice();
	objectsWeight = savegame_object.objectsWeight.slice();
	objectsAttrLO = savegame_object.objectsAttrLO.slice();
	objectsAttrHI = savegame_object.objectsAttrHI.slice();
	connections = savegame_object.connections.slice();
	h_restoreGame(savegame_object);
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                        The parser                                                      //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function loadPronounSufixes()
{

    var swapped;

	for (var j=0;j<vocabulary.length;j++) if (vocabulary[j][VOCABULARY_TYPE] == WORDTYPE_PRONOUN)
			 pronoun_suffixes.push(vocabulary[j][VOCABULARY_WORD]);
	// Now sort them so the longest are first, so you rather replace SELOS in (COGESELOS=>COGE SELOS == >TAKE THEM) than LOS (COGESELOS==> COGESE LOS ==> TAKExx THEM) that woul not be understood (COGESE is not a verb, COGE is)
    do {
        swapped = false;
        for (var i=0; i < pronoun_suffixes.length-1; i++) 
        {
            if (pronoun_suffixes[i].length < pronoun_suffixes[i+1].length) 
            {
                var temp = pronoun_suffixes[i];
                pronoun_suffixes[i] = pronoun_suffixes[i+1];
                pronoun_suffixes[i+1] = temp;
                swapped = true;
            }
        }
    } while (swapped);
}


function findVocabulary(word)  // Pending: sort the vocabulary at the beginning so search may be binary at least
{
	for (var j=0;j<vocabulary.length;j++)
		if (vocabulary[j][VOCABULARY_WORD] == word)
			 return vocabulary[j];
	return null;
}

function normalize(player_order)   
// Removes accented characters and makes sure every sentence separator (colon, semicolon, quotes, etc.) has one space before and after. Also, all separators are converted to comma
{
	var originalchars = 'áéíóúäëïöüâêîôûàèìòùÁÉÍÓÚÄËÏÖÜÂÊÎÔÛÀÈÌÒÙ';
	output = '';

	for (var i=0;i<player_order.length;i++) 
	{
		pos = originalchars.indexOf(player_order.charAt(i));
		if (pos!=-1) output = output + "aeiou".charAt(pos % 5); else 
		{
			ch = player_order.charAt(i);
			if ((ch=='.') || (ch==',') || (ch==';') || (ch=='"') || (ch=='\'')) output = output + ' , '; else output = output + player_order.charAt(i); 
		}

	}
	return output;
}

function toParserBuffer(player_order)  // Converts a player order in a list of sentences separated by dot.
{
     player_order = normalize(player_order);
	 player_order = player_order.toUpperCase();

	 words = player_order.split(' ');
	 for (var q=0;q<words.length;q++)
	 {
	 	words[q] = words[q].trim();
	 	if  (words[q]!=',')
	 	{
	 		words[q] = words[q].trim();
	 		foundWord = findVocabulary(words[q]);
	 		if (foundWord)
	 		{
	 			if (foundWord[VOCABULARY_TYPE]==WORDTYPE_CONJUNCTION)
	 			{
	 			words[q] = ','; // Replace conjunctions with dots
		 		} 
	 		}
	 	}
	 }

	 output = '';
	 for (q=0;q<words.length;q++)
	 {
	 	if (words[q] == ',') output = output + ','; else output = output + words[q] + ' ';
	 }
	 output = output.replace(/ ,/g,',');
	 output = output.trim();
	 player_order_buffer = output;
}

function getSentencefromBuffer()
{
	var sentences = player_order_buffer.split(',');
	var result = sentences[0];
	sentences.splice(0,1);
	player_order_buffer = sentences.join();
	return result;
}

function processPronounSufixes(words)  
{
	// This procedure will split pronominal sufixes into separated words, so COGELA will become COGE LA at the end, and work exactly as TAKE IT does.
	// it's only for spanish so if lang is english then it makes no changes
	if (getLang() == 'EN') return words;
	verbFound = false;
	if (!bittest(getFlag(FLAG_PARSER_SETTINGS),0)) return words;  // If pronoun sufixes inactive, just do nothing
	// First, we clear the word list from any match with pronouns, cause if we already have something that matches pronouns, probably is just concidence, like in COGE LA LLAVE
	var filtered_words = [];
	for (var q=0;q < words.length;q++)
	{
		foundWord = findVocabulary(words[q]);
		if (foundWord) 
			{
				if (foundWord[VOCABULARY_TYPE] != WORDTYPE_PRONOUN) filtered_words[filtered_words.length] = words[q];
			}
			else filtered_words[filtered_words.length] = words[q];
	}
	words = filtered_words;

	// Now let's start trying to get sufixes
	new_words = [];
	for (var k=0;k < words.length;k++)
	{
		words[k] = words[k].trim();
		foundWord = findVocabulary(words[k]);
		if (foundWord) if (foundWord[VOCABULARY_TYPE] == WORDTYPE_VERB) verbFound = true;  // If we found a verb, we don't look for pronoun sufixes, as they have to come together with verb
		suffixFound = false;
		pronunsufix_search:
		for (var l=0;(l<pronoun_suffixes.length) && (!suffixFound) && (!verbFound);l++)
			if (pronoun_suffixes[l] == words[k].rights(pronoun_suffixes[l].length))
			{
				var verb_part = words[k].substring(0,words[k].length - pronoun_suffixes[l].length);
				var checkWord = findVocabulary(verb_part);
				if ((!checkWord)  || (checkWord[VOCABULARY_TYPE] != WORDTYPE_VERB))  // If the part before the supposed-to-be pronoun sufix is not a verb, then is not a pronoun sufix
				{
					new_words.push(words[k]);	
					continue pronunsufix_search;
				}
				new_words.push(verb_part);  // split the word in two parts: verb + pronoun. Since that very moment it works like in english (COGERLO ==> COGER LO as of TAKE IT)
				new_words.push(pronoun_suffixes[l]);
				suffixFound = true;
				verbFound = true;
			}
		if (!suffixFound) new_words.push(words[k]);
	}
	return new_words;
}

function getLogicSentence()
{
	parser_word_found = false; ;
	aux_verb = -1;
	aux_noun1 = -1;
	aux_adject1 = -1;
	aux_adverb = -1;
	aux_pronoun = -1
	aux_pronoun_adject = -1
	aux_preposition = -1;
	aux_noun2 = -1;
	aux_adject2 = -1;
	initializeLSWords();
	SL_found = false;

	order = getSentencefromBuffer();
	setFlag(FLAG_PARSER_SETTINGS, bitclear(getFlag(FLAG_PARSER_SETTINGS),1)); // Initialize flag that says an unknown word was found in the sentence


	words = order.split(" ");
	words = processPronounSufixes(words);
	wordsearch_loop:
	for (var i=0;i<words.length;i++)
	{
		original_word = currentword = words[i];
		if (currentword.length>10) currentword = currentword.substring(0,MAX_WORD_LENGHT);
		foundWord = findVocabulary(currentword);
		if (foundWord)
		{
			wordtype = foundWord[VOCABULARY_TYPE];
			word_id = foundWord[VOCABULARY_ID];

			switch (wordtype)
			{
				case WORDTYPE_VERB: if (aux_verb == -1)  aux_verb = word_id; 
				        			break;

				case WORDTYPE_NOUN: if (aux_noun1 == -1) aux_noun1 = word_id; else if (aux_noun2 == -1) aux_noun2 = word_id;
									break;

				case WORDTYPE_ADJECT: if (aux_adject1 == -1) aux_adject1 = word_id; else if (aux_adject2 == -1) aux_adject2 = word_id;
									  break;

				case WORDTYPE_ADVERB: if (aux_adverb == -1) aux_adverb = word_id;
				        			  break;

				case WORDTYPE_PRONOUN: if (aux_pronoun == -1) 
											{
												aux_pronoun = word_id;
												if ((previous_noun != EMPTY_WORD) && (aux_noun1 == -1))
												{
													aux_noun1 = previous_noun;
													if (previous_adject != EMPTY_WORD) aux_adject1 = previous_adject;
												}
											}

				        			   break;

				case WORDTYPE_CONJUNCTION: break wordsearch_loop; // conjunction or nexus. Should not appear in this function, just added for security
				
				case WORDTYPE_PREPOSITION: if (aux_preposition == -1) aux_preposition = word_id;
										   if (aux_noun1!=-1) setFlag(FLAG_PARSER_SETTINGS, bitset(getFlag(FLAG_PARSER_SETTINGS),2));  // Set bit that determines that a preposition word was found after first noun
										   break;
			}

			// Nouns that can be converted to verbs
			if ((aux_noun1!=-1) && (aux_verb==-1) && (aux_noun1 < NUM_CONVERTIBLE_NOUNS))
			{
				aux_verb = aux_noun1;
				aux_noun1 = -1;
			}

			if ((aux_verb==-1) && (aux_noun1!=-1) && (previous_verb!=EMPTY_WORD)) aux_verb = previous_verb;  // Support "TAKE SWORD AND SHIELD" --> "TAKE WORD AND TAKE SHIELD"

			if ((aux_verb!=-1) || (aux_noun1!=-1) || (aux_adject1!=-1 || (aux_preposition!=-1) || (aux_adverb!=-1))) SL_found = true;



		} else if (aux_verb!=-1) setFlag(FLAG_PARSER_SETTINGS, bitset(getFlag(FLAG_PARSER_SETTINGS),1));  // Set bit that determines that an unknown word was found after the verb
	}

	if (SL_found)
	{
		if (aux_verb != -1) setFlag(FLAG_VERB, aux_verb);
		if (aux_noun1 != -1) setFlag(FLAG_NOUN1, aux_noun1);
		if (aux_adject1 != -1) setFlag(FLAG_ADJECT1, aux_adject1);
		if (aux_adverb != -1) setFlag(FLAG_ADVERB, aux_adverb);
		if (aux_pronoun != -1) 
			{
				setFlag(FLAG_PRONOUN, aux_noun1);
				setFlag(FLAG_PRONOUN_ADJECT, aux_adject1);
			}
			else
			{
				setFlag(FLAG_PRONOUN, EMPTY_WORD);
				setFlag(FLAG_PRONOUN_ADJECT, EMPTY_WORD);
			}
		if (aux_preposition != -1) setFlag(FLAG_PREP, aux_preposition);
		if (aux_noun2 != -1) setFlag(FLAG_NOUN2, aux_noun2);
		if (aux_adject2 != -1) setFlag(FLAG_ADJECT2, aux_adject2);
		setReferredObject(getReferredObject());
		previous_verb = aux_verb;
		if ((aux_noun1!=-1) && (aux_noun1>=NUM_PROPER_NOUNS))
		{
			previous_noun = aux_noun1;
			if (aux_adject1!=-1) previous_adject = aux_adject1;
		}
		
	}
	if ((aux_verb + aux_noun1+ aux_adject1 + aux_adverb + aux_pronoun + aux_preposition + aux_noun2 + aux_adject2) != -8) parser_word_found = true;

	return SL_found;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                        Main functions and main loop                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// Interrupt functions

function enableInterrupt()
{
	interruptDisabled = false;
}

function disableInterrupt()
{
	interruptDisabled = true;
}

function timer()
{
	// Timeout control
	timeout_progress=  timeout_progress + 1/32;  //timer happens every 40 milliseconds, but timeout counter should only increase every 1.28 seconds (according to PAWS documentation)
	timeout_length = getFlag(FLAG_TIMEOUT_LENGTH);
	if ((timeout_length) && (timeout_progress> timeout_length))  // time for timeout
	{
		timeout_progress = 0;
		if (($('.prompt').val() == '')  || (($('.prompt').val()!='') && (!bittest(getFlag(FLAG_TIMEOUT_SETTINGS),0))) )  // but first check there is no text type, or is allowed to timeout when text typed already
		{
			setFlag(FLAG_TIMEOUT_SETTINGS, bitset(getFlag(FLAG_TIMEOUT_SETTINGS),7)); // Clears timeout bit
			writeSysMessage(SYSMESS_TIMEOUT);	
			callProcess(PROCESS_TURN);
		}
	}	

	// Interrupt process control
	if (!interruptDisabled)
	if (interruptProcessExists)
	{
		callProcess(interrupt_proc);
		setFlag(FLAG_PARSER_SETTINGS, bitclear(getFlag(FLAG_PARSER_SETTINGS), 4));  // Set bit at flag that marks that a window resize happened 
	}

	// Set timer again
	setTimeout(function (){
	     	timer();
     },TIMER_MILLISECONDS);
}

// Initialize and finalize functions

function farewell()
{
	writeSysMessage(SYSMESS_FAREWELL);
	ACCnewline();
}


function initializeConnections()
{
  connections = [].concat(connections_start);
}

function initializeObjects()
{
  for (i=0;i<objects.length;i++)
  {
  	objectsAttrLO = [].concat(objectsAttrLO_start);
  	objectsAttrHI = [].concat(objectsAttrHI_start);
  	objectsLocation = [].concat(objectsLocation_start);
  	objectsWeight = [].concat(objectsWeight_start);
  }
}

function  initializeLSWords()
{
  setFlag(FLAG_PREP,EMPTY_WORD);
  setFlag(FLAG_NOUN2,EMPTY_WORD);
  setFlag(FLAG_ADJECT2,EMPTY_WORD);
  setFlag(FLAG_PRONOUN,EMPTY_WORD);
  setFlag(FLAG_ADJECT1,EMPTY_WORD);
  setFlag(FLAG_VERB,EMPTY_WORD);
  setFlag(FLAG_NOUN1,EMPTY_WORD);
  setFlag(FLAG_ADJECT1,EMPTY_WORD);
  setFlag(FLAG_ADVERB,EMPTY_WORD);
}


function initializeFlags()
{
  flags = [];
  for (var  i=0;i<FLAG_COUNT;i++) flags.push(0);
  setFlag(FLAG_MAXOBJECTS_CARRIED,4);
  setFlag(FLAG_PARSER_SETTINGS,9); // Pronoun sufixes active, DOALL and others ignore NPCs, etc. 00001001
  setFlag(FLAG_MAXWEIGHT_CARRIED,10);
  initializeLSWords();
  setFlag(FLAG_OBJECT_LIST_FORMAT,64); // List objects in a single sentence (comma separated)
  setFlag(FLAG_OBJECTS_CARRIED_COUNT,carried_objects);  // FALTA: el compilador genera esta variable, hay que cambiarlo en el compilador, ERA numero_inicial_de_objetos_llevados
}

function initializeInternalVars()
{
	num_objects = last_object_number + 1;
	transcript = '';
	timeout_progress = 0;
	previous_noun = EMPTY_WORD;
	previous_verb = EMPTY_WORD;
	previous_adject = EMPTY_WORD;
	player_order_buffer = '';
	last_player_order = '';
	graphicsON = true; 
	soundsON = true; 
	interruptDisabled = false;
	unblock_process = null;
	done_flag = false;
	describe_location_flag =false;
	in_response = false;
	success = false;
	doall_flag = false;
	entry_for_doall	= '';
}

function initializeSound()
{
	sfxstopall();
}




function initialize()
{
	preloadsfx();
	initializeInternalVars();
	initializeSound();
	initializeFlags();
	initializeObjects();
	initializeConnections();
}



// Main loops

function descriptionLoop()
{
	describe_location_flag = false;
	clearTextWindow();
	if ((isDarkHere()) && (!lightObjectsPresent())) writeSysMessage(SYSMESS_ISDARK); else writeLocation(loc_here()); 
	h_description_init();
	playLocationMusic(loc_here());
	if (loc_here()) drawPicture(loc_here()); else hideGraphicsWindow(); // Don't show picture at location 0
	ACCminus(FLAG_AUTODEC2,1);
	if (isDarkHere()) ACCminus(FLAG_AUTODEC3,1);
	if ((isDarkHere()) && (lightObjectsAt(loc_here())==0)) ACCminus(FLAG_AUTODEC4,1);
	callProcess(PROCESS_DESCRIPTION);
	h_description_post();
	if (describe_location_flag) descriptionLoop();
	describe_location_flag = false;
	callProcess(PROCESS_TURN);
	if (describe_location_flag) descriptionLoop();
	describe_location_flag = false;
	focusInput();

}

function orderEnteredLoop(player_order)
{
	previous_verb = EMPTY_WORD;
	setFlag(FLAG_TIMEOUT_SETTINGS, bitclear(getFlag(FLAG_TIMEOUT_SETTINGS),7)); // Clears timeout bit
	if (player_order == '') {writeSysMessage(SYSMESS_SORRY); ACCnewline(); return; };	
	copyOrderToTextWindow(player_order);
	player_order = h_playerOrder(player_order); //hook
	toParserBuffer(player_order);
	do 
	{
		describe_location_flag = false;
		ACCminus(FLAG_AUTODEC5,1);
		ACCminus(FLAG_AUTODEC6,1);
		ACCminus(FLAG_AUTODEC7,1);
		ACCminus(FLAG_AUTODEC8,1);
		if (isDarkHere()) ACCminus(FLAG_AUTODEC9,1);
		if ((isDarkHere()) && (lightObjectsAt(loc_here())==0)) ACCminus(FLAG_AUTODEC10,1);
		
		if (describe_location_flag) 
		{
			descriptionLoop();
			return;
		};

		if (getLogicSentence())
		{
			incTurns();
			done_flag = false;
			callProcess(PROCESS_RESPONSE); // Response table
			if (describe_location_flag) 
			{
				descriptionLoop();
				return;
			};
			if (!done_flag) 
			{
				if ((getFlag(FLAG_VERB)<NUM_CONNECTION_VERBS) && (CNDmove(FLAG_LOCATION)))
				{
					descriptionLoop();
					return;
				} else if (getFlag(FLAG_VERB)<NUM_CONNECTION_VERBS) {writeSysMessage(SYSMESS_WRONGDIRECTION);ACCnewline();}	else {writeSysMessage(SYSMESS_CANTDOTHAT);ACCnewline();};

			}
		} else
		{
			h_invalidOrder(player_order);
			if (parser_word_found) {writeSysMessage(SYSMESS_IDONTUNDERSTAND);   ACCnewline() }
			    		      else {writeSysMessage(SYSMESS_NONSENSE_SENTENCE); ACCnewline() };	
		}  
		callProcess(PROCESS_TURN);
	} while (player_order_buffer !='');
	previous_verb = ''; // Can't use previous verb if a new order is typed (we keep previous noun though, it can be used)
	focusInput();
}


function restart()
{
	location.reload();	
}


function hideBlock()
{
	clearInputWindow();
    $('.block_layer').hide('slow');
    enableInterrupt();   	
    $('.input').show();  
    focusInput();
}
//called when the block layer is closed
function closeBlock()
{
	if (!unblock_process) return;
	hideBlock();
    var proToCall = unblock_process;
	unblock_process = null;
	callProcess(proToCall);
	if (describe_location_flag) descriptionLoop();
}

// Exacution starts here, called by the html file on document.ready()
function start()
{
	h_init(); //hook
	$('.graphics').addClass('half_graphics');
	$('.text').addClass('half_text');
	if (isBadIE()) alert(STR_BADIE)
	loadPronounSufixes();	

	// Assign keypress action for input box (detect enter key press)
	$('.prompt').keypress(function(e) {  
    	if (e.which == 13) 
    	{ 
    		player_order = $('.prompt').val();
    		if (player_order.charAt(0) == '#')
    		{
    			addToTranscript(player_order + STR_NEWLINE);
    			clearInputWindow();
    		} 
    		else
    		if (player_order!='') 
    				orderEnteredLoop(player_order);
    	}
    });

	// Assign arrow up key press to recover last order
    $('.prompt').keyup( function(e) {
    	if (e.which  == 38) $('.prompt').val(last_player_order);
    });

    //Detect resize to change flag 12
     $(window).resize(function () {
     	setFlag(FLAG_PARSER_SETTINGS, bitset(getFlag(FLAG_PARSER_SETTINGS), 4));  // Set bit at flag that marks that a window resize happened 
     	clearPictureAt();
     	return;
     });


     // assign any click on block layer --> close it
     $(document).click( function(e) {
     	if (unblock_process!=null)
     	{
     		closeBlock();
     		e.preventDefault();
     		return;
     	}

     	if ((anykey_return_function!=null) && (getkey_return_flag==null))  // return for ANYKEY, accepts mouse click
     	{
     		waitKeyCallback();
     		e.preventDefault();
     		return;
    	}

     });
     

	$(document).keydown(function(e) {
		// if keypress and block displayed, close it
     	if (unblock_process!=null)
     		{
     			closeBlock();
     			e.preventDefault();
     			return;
     		}

		if ((anykey_return_function!=null) && (getkey_return_flag!=null))  // return for getkey
     	{
     		setFlag(getkey_return_flag, e.keyCode);
     		getkey_return_flag = null;
     		waitKeyCallback();
     		e.preventDefault();
     		return;
      	}


     	if ((anykey_return_function!=null) && (getkey_return_flag==null))  // return for anykey
     	{
     		waitKeyCallback();
     		e.preventDefault();
     		return;
     	}

     	

     	// if ESC pressed and transcript layer visible, close it
     	if (($('.transcript_layer').css('display')  == 'block') &&  (e.keyCode == 27)  ) 
     		{
     			$('.transcript_layer').hide();
     			e.preventDefault();
     			return;
     		}


	});

	initialize();
	descriptionLoop();
	focusInput();
	
	h_post();  //hook

    // Start interrupt process
    setTimeout(function (){
    	timer();
    },TIMER_MILLISECONDS);

}

