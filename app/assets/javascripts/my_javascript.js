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