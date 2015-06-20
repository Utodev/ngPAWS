//CND LCLEAR A 8 2 0 0

function ACClclear(lcono, attrno)
{
	if (attrno > 63) return;
	if (attrno <= 31)
	{
		var attrs = locsAttrLO[locno];
		attrs = bitclear(attrs, attrno);
		locsAttrLO[locno] = attrs;
		return;
	}
	var attrs = locsAttrHI[locno];
	attrno = attrno - 32;
	attrs = bitclear(attrs, attrno);
	locsAttrHI[locno] = attrs;

}