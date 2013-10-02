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
		myFunction();
	});
	
	
	
	
});



$(function() {
    $( "#datepicker" ).datepicker();
});

function myFunction() {
  	if ($('.document_operation:checked').length == 1) {
	$( "input[name$='prepare'], #create_copy_link, #edit_link, #approve_link, #send_link" ).removeClass('disabled').addClass('btn-success');
	$("#edit_link").attr("href", "/documents/" + $(this).val() + "/edit");
	$("#create_copy_link").attr("href", "/documents/" + $(this).val() + "/copy");
  } else if ($('.document_operation:checked').length > 1)  {
	$( "input[name$='prepare'], #approve_link, #send_link" ).removeClass('disabled').addClass('btn-success');
	$( "#create_copy_link, #edit_link" ).removeClass('btn-success').addClass('disabled');
  } else {
    $( "input[name$='prepare'], #create_copy_link, #edit_link, #approve_link, #send_link" ).removeClass('btn-success').addClass('disabled');
  }
};



