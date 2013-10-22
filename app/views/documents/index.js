$('#document_table').html("<%=j render :partial => 'table', :@documents => @documents %>");
$(function() {
	var searchString = $("#query").val();
	if ($("tr").length <= 1){
		$('#document_table').html("<tr class='inform'><td colspan='9'>По запросу &laquo;"+ searchString +"&raquo; - ничего не найдено.</td></tr>");
	}
});
$("tbody tr").click(appendTr);
$("tbody td.not_this").click(function(e){
    e.stopPropagation()
})