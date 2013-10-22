$('#document_table').html("<%=j render :partial => 'table', :@documents => @documents %>");
$(function() {
	var searchString = $("#query").val();
	if ($("tr").length <= 1){
		$('#document_table').html("<tr class='inform'><td colspan='9'>По запросу &laquo;"+ searchString +"&raquo; - ничего не найдено.</td></tr>");
	}
});
$("tr").click(appendTr);
