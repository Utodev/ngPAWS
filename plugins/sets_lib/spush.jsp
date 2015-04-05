//CND SPUSH A 2 2 0 0

function ACCspush(setno, value)
{
	
	if ((setno>=MAX_SETS) || (setno<0)) return;
	setno--;
	if (sets[setno].indexOf(value)==-1) sets[setno].push(value);
}
