//CND SPOP A 2 2 0 0

function ACCspop(setno, value)
{
	if ((setno>MAX_SETS) || (setno<1)) return;
	setno--;
	position = sets[setno].indexOf(value);
	if (position>0) sets[setno].splice(position,1);
}
