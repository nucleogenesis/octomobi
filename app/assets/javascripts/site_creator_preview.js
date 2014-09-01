$(document).ready(function() {
	var features = {};
// Add Listeners for Each Modal Form Type
	$("#introduction_feature_modal," + 
	  "#content_page_feature_modal").bind("ajax:success", function(e, data, status, xhr) {
		var id = this.id.replace("modal", "");
		features.id = data;
	});
});
