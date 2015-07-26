//CND ATTRGET A 14 4 1 0

function ACCattrget(writeno, objno, flagno)
{
	if (typeof (eval('objExtraAttr.' + writemessages[writeno])) == 'undefined') 
		{
			setFlag(flagno, 0);
			return;
		}

    eval('setFlag(flagno,objExtraAttr.' + writemessages[writeno] + '['+objno+'])');
    if (typeof (getFlag(flagno)) =='undefined') setFlag(flagno, 0);
}