$(document).ready(function(){

  function fadeAlert(){
    $('.alert-temp').removeClass('in');
  }

  function removeAlert(){
    $('.alert-temp').remove();
  }

  window.setTimeout(fadeAlert,3000);
  window.setTimeout(removeAlert,10000);

//   $("#myToggleNavbar").click(function() {
//     $(.collapse).collapse("toggle");
//   });
  
});

$("#myContinue").click(function() { 
	judge.validate(document.getElementById('email'), 
	{
	  valid: function(element) {
	    element.style.border = '1px solid green';
	  },
	  invalid: function(element, messages) {
	    element.style.border = '1px solid red';
	    alert(messages.join(','));
	  }
	});
});