
$(document).ready(function() {
	$('input[type=checkbox]').click(function() {
		console.log($(this))
		if ($(this).val() === 'Other' && $(this).attr('checked')) {
			$('#hidden-other').removeClass('hidden')
		} else {
			$('#hidden-other').addClass('hidden')
		}
	})
})
