//LIB drawPicture
//This changes the way we show svg images, so they can be composed
var drawPicture = function (picno)  
{
	var pictureDraw = false;
	if (graphicsON) 
	{
		if ((isDarkHere()) && (!lightObjectsPresent())) picno = 0;
		var filename = getResourceById(RESOURCE_TYPE_IMG, picno);
		if (filename)
		{
			$('.graphics').removeClass('hidden');
			$('.graphics').addClass('half_graphics');
			$('.text').removeClass('all_text');
			$('.text').addClass('half_text');
			if (filename.slice(-3) === "svg") 
			{
				$('.graphics').html('<object type="image/svg+xml" class="location_picture" data="' +  filename + '" />');
			} else	$('.graphics').html('<img alt="" class="location_picture" src="' +  filename + '" />');
			$('.location_picture').css('height','100%');
			pictureDraw = true;
		}
	}

	if (!pictureDraw) hideGraphicsWindow();
}

