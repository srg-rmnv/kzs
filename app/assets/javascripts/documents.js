 
	function jsonTr() {
		current_row.hide();
		$.getJSON( "/documents/" + document_id + ".json", function(data) {
			$("<tr class='inform'><td colspan='9'><ul class='expanded'></ul></td></tr>").insertAfter(current_row);
			$("<li><span>Тип:</span><p class='exp_type'>" + data.type + "</p></li><li><span>Номер и дата:</span><p class='exp_date'><a href='#'>" + data.sn + "</a> / " + data.date + "</p></li>").appendTo('.inform td ul');
			$("<li><span>Тема:</span><p class='exp_title'><a href='#'>" + data.title + "</a></p></li>").appendTo('.inform td ul');
			$("<li><p class='exp_fromto'><a href='#'>"  + data.sender_organization + "</a> &rarr; <a href='#'>" + data.organization + "</a></p></li>").appendTo('.inform td ul');
			$("<li><span>Исполнитель:</span><p class='exp_exec'><a href='#'>" + data.executor + "</a></p></li>").appendTo('.inform td ul');
			$("<li><span>Отправитель:</span><p class='exp_exec'><a href='#'>" + data.sender + "</a></p></li>").appendTo('.inform td ul');
			if (data.attachments.length != 0){
				$("<li class='attach'><span>Приложения:</span></li>").appendTo('.inform td ul');
				$.each(data.attachments, function(i,attachment_file_name){
						$("<p class='exp_attach'>" + data.attachments[i].attachment_file_name + "</p></li>").appendTo('.attach');
				});
			}
			$("<img class='doc_sample' src='assets/blanc-sample.png'>").appendTo('.inform td');
			$("<input class='btn btn-success btn-large' data-confirm='Вы уверены?' id='send_link' name='send' type='submit' value='Отправить'>").appendTo('.inform td');
			$("<input class='btn disabled' data-confirm='Вы уверены?' id='send_link' name='send' type='submit' value='Удалить'>").appendTo('.inform td');
			$("<input class='btn disabled' data-confirm='Вы уверены?' id='send_link' name='send' type='submit' value='Открыть'>").appendTo('.inform td');
			$('.label').filter(":hidden").clone().appendTo(".inform td");
			$('.control').filter(":hidden").clone().prependTo(".inform td");
	});
	};

	function appendTr() {
	current_row = $(this).closest('tr');
	document_id = $(this).find('.document_id').html();
	if (!!$(current_row).next(".inform").length){
			$(".inform").remove();
			}
	else if (!!$(".inform").not(current_row).length){
		$(".inform").not(current_row).remove();
	  	jsonTr();
	  	$( "tr:hidden" ).not(this).show(0);
			}
	else {
			jsonTr();
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


$("tbody tr").click(appendTr);
$("tbody td.not_this").click(function(e){
    e.stopPropagation()
})
	
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
	$("#delete_link").attr("href", "/documents/" + elem.val());
	$("#create_copy_link").attr("href", "/documents/" + elem.val() + "/copy");
	$("#reply_link").attr("href", "/documents/" + elem.val() + "/reply");
  } else if ($('.document_operation:checked').length > 1)  {
	$( "input[name$='prepare'], #approve_link, #send_link, #reply_link" ).removeClass('disabled').addClass('btn-success');
	$( "#create_copy_link, #edit_link, #reply_link" ).removeClass('btn-success').addClass('disabled');
  } else {
    $( "input[name$='prepare'], #create_copy_link, #edit_link, #approve_link, #send_link, #reply_link" ).removeClass('btn-success').addClass('disabled');
  }
};
$('#delete_link').click(function() {
    $.post(this.href, { _method: 'delete' }, null, "script");
    return false;
  });
$(function() {
  $("#text-search input").keyup(function() {
    $.get($("#text-search").attr("action"), $("#text-search").serialize(), null, "script");
    return false;
  });
});

