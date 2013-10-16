$('#document_table').html("<%=j render :partial => 'table', :@documents => @documents %>");
$("tr").click(function() {
	// $(this).hide();
	document_id = $(this).find('.document_id').html()
	$.ajax({
	    url: "/documents/" + document_id,
	    dataType: 'json',
	  })	
});