//LIB stack_queue_lib.jsp

// This library implements the base code for supporting the queue and stacks condacts. It uses hooks to make sure stacks and queues are saved into the savegames
// and ensures the queues and stacks are emptied on game restart.


MAX_QUEUE = 4;
MAX_STACK = 4;

var queues;
var stacks;

var old_stackqueue_h_restart = h_restart;

var h_restart = function() 
{
	old_stackqueue_h_restart();
	queues = new Array();	
	for (var i=0;i<MAX_QUEUE;i++) queues.push(new Array());
	stacks = new Array();
	for (var j=0;j<MAX_STACK;j++) stacks.push(new Array());
}


var old_stackqueue_h_saveGame = h_saveGame;

var h_saveGame = function(savegame_object)
{
	savegame_object.queues = queues.slice();
	savegame_object.stacks = stacks.slice();
	old_stackqueue_h_saveGame(savegame_object);
	return savegame_object;
}

var old_stackqueue_h_restoreGame = h_restoreGame;

var h_restoreGame = function(savegame_object)
{
	queues = savegame_object.queues.slice();
	stacks = savegame_object.stacks.slice();
	old_stackqueue_h_restoreGame(savegame_object);
}