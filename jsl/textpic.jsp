//CND TEXTPIC A 2 2 0 0

function ACCtextpic(picno, align)
{
	filename = getResourceById(RESOURCE_TYPE_IMG, picno);
	if (filename)
	texto = "<img src='"+filename+"' />";
	writeText(texto);
}