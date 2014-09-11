//CND MOD A 1 2 0 0

function ACCmod(flagno, valor)
{
	if (valor == 0) return;
	setFlag(flagno, Math.floor(getFlag(flagno) % valor));
}