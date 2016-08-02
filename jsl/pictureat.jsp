//CND PICTUREAT A 2 2 2 0

/*
In order to determine the actual size of both background image and pictureat image they should be loaded, thus two chained "onload" are needed. That is, 
background image is loaded to determine its size, then pictureat image is loaded to determine its size. Size of currently displayed background image cannot
be used as it may have been already stretched.
*/

function ACCpictureat(x,y,picno)
{
	var filename = getResourceById(RESOURCE_TYPE_IMG, picno);
	if (!filename) return;

	// Check location has a picture, otherwise exit
	var currentBackgroundScreenImage = $('.location_picture');
	if (!currentBackgroundScreenImage) return;

	// Create a new image with the contents of current background image, to be able to calculate original height of image
	var virtualBackgroundImage = new Image();
	// Pass required data as image properties in order to be avaliable at "onload" event
	virtualBackgroundImage.bg_data=[];
	virtualBackgroundImage.bg_data.filename = filename; 
	virtualBackgroundImage.bg_data.x = x;
	virtualBackgroundImage.bg_data.y = y;
	virtualBackgroundImage.bg_data.picno = picno;
	virtualBackgroundImage.bg_data.currentBackgroundScreenImage = currentBackgroundScreenImage;


	// Event triggered when virtual background image is loaded
	virtualBackgroundImage.onload = function()
		{
			var originalBackgroundImageHeight = this.height;
			var scale = this.bg_data.currentBackgroundScreenImage.height() / originalBackgroundImageHeight;

			// Create a new image with the contents of picture to show with PICTUREAT, to be able to calculate height of image
			var virtualPictureAtImage = new Image();
			// Also pass data from background image as property so they are avaliable in the onload event
			virtualPictureAtImage.pa_data = [];
			virtualPictureAtImage.pa_data.x = this.bg_data.x;
			virtualPictureAtImage.pa_data.y = this.bg_data.y;
			virtualPictureAtImage.pa_data.picno = this.bg_data.picno;
			virtualPictureAtImage.pa_data.filename = this.bg_data.filename;
			virtualPictureAtImage.pa_data.scale = scale;
			virtualPictureAtImage.pa_data.currentBackgroundImageWidth = this.bg_data.currentBackgroundScreenImage.width();
			
			// Event triggered when virtual PCITUREAT image is loaded
			virtualPictureAtImage.onload = function ()
			{
		    		var imageHeight = this.height; 
					var x = Math.floor(this.pa_data.x * this.pa_data.scale);
					var y = Math.floor(this.pa_data.y * this.pa_data.scale);
					var newimageHeight = Math.floor(imageHeight * this.pa_data.scale);
					var actualBackgroundImageX = Math.floor((parseInt($('.graphics').width()) - this.pa_data.currentBackgroundImageWidth)/2);;
					var id = 'pictureat_' + this.pa_data.picno;

					// Add new image, notice we are not using the virtual image, but creating a new one
					$('.graphics').append('<img  alt="" id="'+id+'" style="display:none" />');				
					$('#' + id).css('position','absolute');
					$('#' + id).css('left', actualBackgroundImageX + x  + 'px');
					$('#' + id).css('top',y + 'px');
					$('#' + id).css('z-index','100');
					$('#' + id).attr('src', this.pa_data.filename);
					$('#' + id).css('height',newimageHeight + 'px');
					$('#' + id).show();
			}

			// Assign the virtual pictureat image the destinationsrc to trigger the "onload" event
			virtualPictureAtImage.src = this.bg_data.filename;
			};

	// Assign the virtual background image same src as current background to trigger the "onload" event
	virtualBackgroundImage.src = currentBackgroundScreenImage.attr("src");

}
