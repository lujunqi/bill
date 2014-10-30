jQuery.fn.mygrid = function(o){
var tableRowCheckboxToggleClasses=new Array('odd_row', 'even_row');
// give me a class name you want to add to the table row when there are checkboxes checked
var tableRowCheckboxCheckedClass='marked';
// by default, this script will apply to checkboxes within the rows specified
// HOWEVER, you may manually exclude certain checkboxes based on their name, id or class
// specify below


	var tableRowCheckboxes = new Array;
	// array used to remember the checkbox state for the checkboxes applicable
	// traverse all rows
	
	$('.dataTable tr').each(function(i,row) {
		$(row).removeAttr("class");
		if(i % 2==0){
			$(row).addClass('odd_row');
		}else{
			$(row).addClass('even_row');
		}
		$(row).click(function() {
		// toggle the checked state
			$(".dataTable tr:eq("+i+") :checkbox").each(function(j,checkbox) {
				if(applicableCheckbox(checkbox)) {
					// toggle checkbox states
					//alert(checkbox.checked);
					if (!checkbox.checked) {
						$(row).addClass(tableRowCheckboxCheckedClass);
						checkbox.checked = true;
					} else {
						$(row).removeClass(tableRowCheckboxCheckedClass);
						checkbox.checked = false;
					}
					//checkbox.checked = tableRowCheckboxes[uniqueId];
				}// end of if applicable checkbox
			});
		}); // end of click event
});

	function applicableCheckbox(checkbox) {
	var applicable = true;
	// not applicable if the checkbox is disabled
	if(checkbox.disabled) {
		applicable = false;
	}
	return applicable;
}
};