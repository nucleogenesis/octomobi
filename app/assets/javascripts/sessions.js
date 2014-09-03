$(document).ajaxComplete(function(event, xhr, settings) {
	var csrfParam = xhr.getResponseHeader('X-CSRF-Param');
	var csrfToken = xhr.getResponseHeader('X-CSRF-Token');

	if (csrfParam) {
		$('meta[name="csrf-param"]').attr('content', csrfParam);
	}
	if (csrfToken) {
		$('meta[name="csrf-token"]').attr('content', csrfToken);
	}
});
