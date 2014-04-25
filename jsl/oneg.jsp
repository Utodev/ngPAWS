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
