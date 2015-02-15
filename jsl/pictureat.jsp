//CND PICTUREAT A 2 2 2 0

function ACCpictureat(x,y,picno)
{
	var filename = getResourceById(RESOURCE_TYPE_IMG, picno);
	if (!filename) return;

	var screenImage = $('.location_picture');
	if (!screenImage) return;

	// Create a new image with the contents of current image, to be able to calculate original height of image
	var theImage = new Image();

	// Get curent height 
		theImage.onload = function()
		{
			var screenImageHeight = screenImage.height();
			var screenImageX = Math.floor((parseInt($('.graphics').width()) - screenImage.width())/2);;
	    	var imageHeight    = theImage.height; 
			// Calculate scale and x, Y position
			var scale =  screenImageHeight / imageHeight;
			x = Math.floor(x * scale);
			y = Math.floor(y * scale);


			// now load new image
			id = 'pictureat_' + picno;
			// add new image
			$('.graphics').append('<img  alt="" id="'+id+'" style="display:none" />');

			var newImage = new Image();
			newImage.onload = function ()
			{
				newimageHeight = Math.floor(newImage.height * scale);
				$('#' + id).css('position','absolute');
				$('#' + id).css('left', x + screenImageX + 'px');
				$('#' + id).css('top',y + 'px');
				$('#' + id).css('z-index','100');
				$('#' + id).attr('src', filename);
				$('#' + id).css('height',newimageHeight + 'px');
				$('#' + id).show();
			}
			newImage.src = filename;
			};
	theImage.src = screenImage.attr("src");

}
