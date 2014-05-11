//CND PUSH A 2 2 0 0

function ACCpush(stackno, value)
{
	
	if ((stackno>MAX_STACK) || (stackno<1)) return;
	stackno--;
	stacks[stackno].push(value);
}
