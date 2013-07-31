
$(document).ready(function() {
	$('input[type=checkbox]').click(function() {
		if ($(this).attr('id') === 'other' && $('#hidden-other').hasClass("hidden")) {
			$('#hidden-other').removeClass("hidden");
		} else {
			$('#hidden-other').addClass("hidden");
		}
	})

	if ($('#other:checked').length > 0) {
		$('#hidden-other').removeClass("hidden");
	}

	$('#user_age').regexMask(/^\d+$/);
})
