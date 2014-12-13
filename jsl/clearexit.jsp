//CND CLEAREXIT A 2 0 0 0

function ACCclearexit(wordno)
{
	if ((wordno >= NUM_CONNECTION_VERBS) || (wordno< 0 )) return;
	setConnection(loc_here(),wordno, -1);
}