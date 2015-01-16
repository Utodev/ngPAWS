//CND VOLUMEVIDEO A 2 0 0 0


function ACCvolumevideo(value)
{
	if (typeof videoElement != 'undefined') 
		videoElement.volume = value  / 65535;
}
