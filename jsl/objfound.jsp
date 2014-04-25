//CND OBJFOUND C 2 9 0 0

function CNDobjfound(attrno, locno)
{

	for (i=0;i<num_objects;i++) 
		if ((getObjectLocation(i) == locno) && (CNDonotzero(i,attrno))) return true;
	return false;
}
