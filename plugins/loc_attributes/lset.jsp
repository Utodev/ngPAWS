//CND LSET A 8 2 0 0

function ACClset(lcono, attrno)
{
	if (attrno > 63) return;
	if (attrno <= 31)
	{
		var attrs = locsAttrLO[locno];
		attrs = bitset(attrs, attrno);
		locsAttrLO[locno] = attrs;
		return;
	}
	var attrs = locsAttrHI[locno];
	attrno = attrno - 32;
	attrs = bitset(attrs, attrno);
	locsAttrHI[locno] = attrs;

}