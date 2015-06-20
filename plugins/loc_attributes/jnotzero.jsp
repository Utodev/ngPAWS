//CND LNOTZERO C 8 2 0 0


function CNDlnotzero(locno, attrno)
{
	if (attrno > 63) return false;
	return locIsAttr(locno, attrno);
}