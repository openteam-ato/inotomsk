// jquery.iepngfix adds IE5/6/7/8 support for transparent PNGs and
// fixes issue where black blobs appear on non-binary alpha channel
// areas of PNGs when using CSS opacity or fading with jquery.cycle.
//
// It accomplishes this by setting the AlphaImageLoader filter in IE,
// adding support for PNG transparency in IE > 5.5
//
// THE PITFALLS
// source: http://24ways.org/2007/supersleight-transparent-png-in-ie6
// Please read the above link's "The pitfalls" section to better
// understand performance issues and other limitations of this method.
(function( $ ) {

	$.fn.fixPNG = function(options) {
		
		// Don't bother with non-IE browsers
		if (!($.browser.msie)) return this;
		
		// This fix only applies to IE 5/6/7/8
		var MIN_IE_VERSION = 5;
		var MAX_IE_VERSION = 8;
		var ieVersion = parseInt(jQuery.browser.version, 10);
		if (ieVersion < MIN_IE_VERSION || ieVersion > MAX_IE_VERSION) return this;
		
		// Empty 1x1px GIF, Base 64 encoded
		// src: Comment by George Stephanis at http://allinthehead.com/retro/338/supersleight-jquery-plugin
		var SHIM_IMAGE = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAAAAAA6fptVAAAACXZwQWcAAAABAAAAAQDHlV/tAAAAAnRSTlMA/1uRIrUAAAAKSURBVAjXY/gPAAEBAQAbtu5WAAAAAElFTkSuQmCC';
		
		// classname of div wrapper for the divWrapImages option
		var DIV_WRAPPER_CLASS = 'iepngfix-wrapper';
		
		// Set up default options
		var defaults = {
			divWrapImages: false
		};
		
		// Overwrite default options with user provided
		// ones and merge them into "options"
		options = $.extend({}, defaults, options);
		
		return this.each(function(i, elem) {

			// fix IMG elements for PNGs
			if($.nodeName(elem, "img") && $(elem).attr('src').match(/\.png/i) !== null) {
				var styles = {
					// Manually set the CSS width and height so
					// that the shim properly expands to fill the image
					'width'  : $(elem).width() + 'px',
					'height' : $(elem).height() + 'px',
					
					// Set the "AlphaImageLoader" proprietary IE filter
					'filter' : "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + $(elem).attr('src') + "', sizingMethod='scale')"
				};
				
				// apply the CSS styles
				$(elem).css(styles);
				
				// apply the shim image
				$(elem).attr('src', SHIM_IMAGE);
				
				if(options.divWrapImages) {
					// wrap IMG in a div for jquery.cycle support
					$(elem).wrap('<div class="'+DIV_WRAPPER_CLASS+'">');
				}
			}
			
			// fix other elements that have CSS background-image PNGs
			else if($(elem).css('background-image').match(/\.png/i) !== null) {
				var imageName = $(elem).css('backgroundImage');
				var src = imageName.substring(5,imageName.length-2);
				
				// set the AlphaImageLoader filter's sizingMethod
				// to 'scale' for repeating BGs, 'crop' for non-repeating BGs
				var sizingMethod = ($(elem).css('background-repeat') == 'no-repeat' ? 'crop' : 'scale');
				
				var styles = {
					// setup the shim image
					'backgroundImage' : 'url(' + SHIM_IMAGE + ')',
					
					// Set the "AlphaImageLoader" proprietary IE filter
					'filter'          : "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "', sizingMethod='" + sizingMethod + "')"
				}
				
				// apply the CSS styles
				$(elem).css(styles);
			}
		});
	}
})( jQuery );