$('#document_table').html("<%=j render :partial => 'table', :@documents => @documents %>");
$("tr").click(function() {
	document_id = $(this).find('.document_id').html()
	$.getJSON( "/documents/" + document_id + ".json", function(data) {
	  alert(data.organization);
	})
});


