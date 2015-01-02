//CND EXCLUDE A 2 0 0 0

function ACCexclude(value)
{
	position = conv_active_sentences.indexOf(value);
	if (position > 0) conv_active_sentences.splice(position,1);
}
