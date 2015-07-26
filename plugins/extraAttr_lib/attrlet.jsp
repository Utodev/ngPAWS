//CND ATTRLET A 14 4 2 0

function ACCattrlet(writeno, objno, value)
{
	if (typeof (eval('objExtraAttr.' + writemessages[writeno])) == 'undefined') eval('objExtraAttr.' + writemessages[writeno] + '=[]');
    eval('objExtraAttr.' + writemessages[writeno] + '['+objno+']=' + value);
}