//CND SOFTBLOCK A 2 0 0 0

function ACCsoftblock(procno)
{
   inBlock = true;
   disableInterrupt();

   $('.block_layer').css('display','none');
   $('.block_text').html('');
   $('.block_graphics').html('');
   $('.block_layer').css('background','transparent');
   if (procno == 0 ) unblock_process ==null; else unblock_process = procno;
   $('.block_layer').css('display','block');
}