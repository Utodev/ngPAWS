//CND BLOCK A 14 2 2 0

function ACCblock(writeno, picno, procno)
{
   disableInterrupt();
   text = writemessages[writeno]
   text = h_writeText(text); // hook
   text = filterText(text)
   $('.block_text').html(text);
   
	var filename = getResourceById(RESOURCE_TYPE_IMG, picno);
	if (filename)
	{
		var imgsrc = '<img class="block_picture" src="' + filename + '" />';
		$('.block_graphics').html(imgsrc);
	}
    $('.block_layer').show();
    if (procno == 0 ) unblock_process ==null; else unblock_process = procno;
}