	function jsonTr() {
		var  current_row = $(this).closest('tr');
		$.getJSON( "/documents/" + document_id + ".json", function(data) {
			$("<tr class='inform'><td colspan='9'><ul class='expanded'><li><span class='exp_type'>Тип:</span>" + data.type + "</li><li><span class='exp_date'>Номер и дата:</span>" + data.sn + " / " + data.date + "</li><li><span class='exp_title'>Тема:</span>" + data.title + "</li><li class='exp_fromto'>"  + data.sender_organization + " &rarr; " + data.organization + "</li><li><span class='exp_exec'>Исполнитель:</span>" + data.executor + "</li><li><span class='exp_exec'>Отправитель:</span>" + data.sender + "</li><li><span class='exp_exec'>Отправитель:</span>" + data.attachments + "</li></ul></td></tr>").insertAfter(current_row);
	})};

	function appendTr() {
	var  current_row = $(this).closest('tr');
	document_id = $(this).find('.document_id').html();
	if (!!$(current_row).next(".inform").length){
			$(".inform").remove();
			}
	else if (!!$(".inform").not(current_row).length){
		$(".inform").not(current_row).remove();
	  	$(jsonTr);
			}
	else {
			$(jsonTr);
	}

};


$(document).ready(function(){
	

	

	
	$('#select_all_documents').on("click", function() {	
		checked = $("#document_confidential").is(':checked')
		  if (checked == true) {
			$('#document_recipient_id').show();
		  } else {
		    $('#document_recipient_id').hide();
		  }
	});
	
	
	
	$('#document_executor_id').on("change", function() {
		  if ($('#document_executor_id option:selected').val() == "") {
			$('#executor_tel').hide();
		  } else {
		    $('#executor_tel').show();
		  }
		$.ajax({
		    url: "/document/executor_phone",
		    type: "GET",
		    data: 'user=' + $('#document_executor_id option:selected').val(),
		  })		
});


$("tr").click(appendTr);
	
	
	$('#document_organization_ids').chosen();
	$('#select_all_organizations').click(function(){
		$('#document_organization_ids').find("option").attr('selected', 'selected');
		$("#document_organization_ids").trigger("chosen:updated");
	});
	
	$('#select_all_documents').on("click", function() {	
		$(document).find(':checkbox').prop('checked', this.checked);
		myFunction();
	});
	
	$('.document_operation').on("change", function() {
		elem = $(this)
		myFunction(elem);
	});
	
	$('#text-search_button').on("click", function() {	
		$('#text-search').submit();
	});
	
	
});



$(function() {
    $( "#datepicker" ).datepicker();
});

function myFunction(elem) {
  	if ($('.document_operation:checked').length == 1) {
	$( "input[name$='prepare'], #create_copy_link, #edit_link, #approve_link, #send_link, #reply_link" ).removeClass('disabled').addClass('btn-success');
	$("#edit_link").attr("href", "/documents/" + elem.val() + "/edit");
	$("#create_copy_link").attr("href", "/documents/" + elem.val() + "/copy");
	$("#reply_link").attr("href", "/documents/" + elem.val() + "/reply");
  } else if ($('.document_operation:checked').length > 1)  {
	$( "input[name$='prepare'], #approve_link, #send_link, #reply_link" ).removeClass('disabled').addClass('btn-success');
	$( "#create_copy_link, #edit_link, #reply_link" ).removeClass('btn-success').addClass('disabled');
  } else {
    $( "input[name$='prepare'], #create_copy_link, #edit_link, #approve_link, #send_link, #reply_link" ).removeClass('btn-success').addClass('disabled');
  }
};

$(function() {
  $("#text-search input").keyup(function() {
    $.get($("#text-search").attr("action"), $("#text-search").serialize(), null, "script");
    return false;
  });
});

