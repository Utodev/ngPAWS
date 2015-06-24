//LIB sequence_tag_sample_hook_lib.jsp

var old_condact_sequence_tag_hook = h_sequencetag;

h_sequencetag = function(tagparams) 
{
	if (tagparams[0].substring(0,2)=='C:')
	{
		var condact_to_run = 'ACC' + tagparams[0].toLowerCase().substring(2) + '('+ tagparams.slice(1).join()  +')';
		console_log(condact_to_run);
		eval(condact_to_run);
		return '';
	}
	return old_condact_sequence_tag_hook(tagparams);
}

