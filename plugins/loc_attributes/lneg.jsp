//CND LNEG A 8 2 0 0

function ACConeg(locno, attrno)
{
	if (attrno > 63) return;
	if (attrno <= 31)
	{
		var attrs = locsAttrLO[locno];
		attrs = bitneg(attrs, attrno);
		locsAttrLO[locno] = attrs;
		return;
	}
	var attrs = locsAttrHI[locno];
	attrno = attrno - 32;
	attrs = bitneg(attrs, attrno);
	locsAttrHI[locno] = attrs;
}
