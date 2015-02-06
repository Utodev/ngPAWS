//CND ISMOV C 0 0 0 0

function CNDismov()
{
	if ((getFlag(FLAG_VERB)<NUM_CONNECTION_VERBS) && (getFlag(FLAG_NOUN1)==EMPTY_WORD)) return true;

	if ((getFlag(FLAG_NOUN1)<NUM_CONNECTION_VERBS) && (getFlag(FLAG_VERB)==EMPTY_WORD)) return true;

    if ((getFlag(FLAG_VERB)<NUM_CONNECTION_VERBS) && (getFlag(FLAG_NOUN1)<NUM_CONNECTION_VERBS)) return true;
    
    return false;
}
