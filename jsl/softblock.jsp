//CND SOFTBLOCK A 2 0 0 0

function ACCsoftblock(procno)
{
   disableInterrupt();
   $('.block_text').html('');
   $('.block_graphics').html('');
   $('.block_layer').css('background','transparent');
   $('.block_layer').show();
   if (procno == 0 ) unblock_process ==null; else unblock_process = procno;
}