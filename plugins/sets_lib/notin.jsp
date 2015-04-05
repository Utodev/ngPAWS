//CND NOTIN C 2 2 0 0

function CNDnotin(setno, value)
{
	if ((setno>=MAX_SETS) || (setno<0)) return false;
    setno--;
	return sets[setno].indexOf(value)==-1;
}
