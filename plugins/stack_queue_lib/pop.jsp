//CND POP A 2 1 0 0

function ACCpop(stackno, flagno)
{
	if ((stackno>MAX_STACK) || (stackno<1)) return;
	stackno--;
	if (stacks[stackno].length == 0) return;
	retval = stacks[stackno][stacks[stackno].length -1];
	stacks[stackno].splice(stacks[stackno].length -1,1);
	setFlag(flagno, retval);
}
