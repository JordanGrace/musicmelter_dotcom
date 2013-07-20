
$(document).ready(function() {
	$('input[type=checkbox]').click(function() {
		if ($(this).val() === 'Other' && $('#hidden-other').hasClass("hidden")) {
			$('#hidden-other').removeClass("hidden");
		} else {
			$('#hidden-other').addClass("hidden");
		}
	})
})
