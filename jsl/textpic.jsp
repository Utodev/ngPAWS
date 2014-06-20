//CND TEXTPIC A 2 2 0 0

function ACCtextpic(picno, align)
{
	var style = '';
	var br = '<br />';
	switch(align)
	{
		case 1: style = 'float:left'; br=''; break;
		case 2: style = 'float:right'; br=''; break;
	}
	filename = getResourceById(RESOURCE_TYPE_IMG, picno);
	if (filename)
	texto = "<img class='textpic' style='"+style+"' src='"+filename+"' />"+br;
	writeText(texto);
}