//CND CONV A 2 1 0 0

function ACCconv(convno, flagno)
{
	ACCcommand(0);
	eval ('runConv' +convno + '(' + flagno + ')');
}
