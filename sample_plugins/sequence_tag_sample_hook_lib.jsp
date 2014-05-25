//LIB sequence_tag_sample_hook_lib.jsp

var old_sequence_tag_hook = h_sequencetag;

h_sequencetag = function(tagparams) 
{
	if (tagparams[0]=='DATE') return new Date().toString();
	if (tagparams[0]=='UNIXTIME') return new Date().getTime();
	if (tagparams[0]=='SUMFLAGS') return getFlag(tagparams[1]) + getFlag(tagparams[2]);
	return old_sequence_tag_hook(tagparams);
}

