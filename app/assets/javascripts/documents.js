$(document).ready(function(){
	
	$('#document_confidential').on("click", function() {
		
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
	
	

});

$(function() {
    $( "#datepicker" ).datepicker();
});



