//CND QPOP A 2 1 0 0

function ACCqpop(queueno, flagno)
{
	if ((queueno>MAX_QUEUE) || (queueno<1)) return;
	queueno--;
	if (queues[queueno].length == 0) return;
	retval = queues[queueno][0];
	queues[queueno].splice(0,1);
	setFlag(flagno, retval);
}
