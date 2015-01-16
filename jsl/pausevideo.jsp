//CND PAUSEVIDEO A 0 0 0 0


function ACCpausevideo()
{
	if (typeof videoElement != 'undefined') 
		if (!videoElement.ended) 
		if (!videoElement.paused)
		   videoElement.pause();
}
