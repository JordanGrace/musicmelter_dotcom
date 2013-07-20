
$(document).ready(function() {
	$('input[type=checkbox]').click(function() {
		if ($(this).val() === 'Other') {
			$('#hidden-other').toggle();
		}
	})
})
