//CND QPUSH A 2 2 0 0

function ACCqpush(queueno, value)
{
	
	if ((queueno>MAX_QUEUE) || (queueno<1)) return;
	queueno--;
	queues[queueno].push(value);
}
