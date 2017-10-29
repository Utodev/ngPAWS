//LIB longdescription_lib.jsp

var objects_longdescription = [];

var examine_longdescription = 30;

var old_longdesc_h_code = h_code;

h_code = function(str) 
{
	if (str=="RESPONSE_USER")
	{
		if (getFlag(33)==examine_longdescription) // Examinar
			if (getFlag(51)!=EMPTY_OBJECT)  // Es un objeto
				if (objects_longdescription[getFlag(51)]!='') // Tiene descrpción larga
					if (CNDpresent(getFlag(51))) // Está presente
					{
						writeText(filterText(objects_longdescription[getFlag(51)])); 	
						var viewContents = false;
						// Time to list contents if...
						// It's a supporter
						if (objectIsAttr(getFlag(51),ATTR_SUPPORTER)) viewContents = true;   
						// It's a transparent container
						if ((objectIsAttr(getFlag(51),ATTR_CONTAINER)) && (objectIsAttr(getFlag(51),ATTR_TRANSPARENT))) viewContents = true;
						// It's a not openable container
						if ((objectIsAttr(getFlag(51),ATTR_CONTAINER)) && (!objectIsAttr(getFlag(51),ATTR_OPENABLE))) viewContents = true;
						// It's an openable container that is open
						if ((objectIsAttr(getFlag(51),ATTR_CONTAINER)) && (objectIsAttr(getFlag(51),ATTR_OPENABLE)) && (objectIsAttr(getFlag(51),ATTR_OPEN))) viewContents = true;
						// but if there is nothing inside/over, then no need to list
						if (getObjectCountAt(getFlag(51))==0) viewContents = false;
						if (viewContents) ACClistcontents(getFlag(51));
						writeSysMessage(SYSMESS_LISTEND);
						ACCnewline();
						ACCdone();
					}
	}
	old_longdesc_h_code(str);
}

var old_longdesc_h_init = h_init;

h_init = function()
{
	for (var i=0;i<objects.length;i++)
	{
		var sharppos = objects[i].indexOf('#');
		if (sharppos != -1)
		{
			objects_longdescription[i] = objects[i].substring(sharppos + 1);
			objects[i] = '{TOOLTIP|' + objects_longdescription[i] + '|' + objects[i].substring(0,sharppos) + '}';
		}
		else objects_longdescription[i] = '';
	}
	old_longdesc_h_init();
}


