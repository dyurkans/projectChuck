$(document).ready(function(){

  function fadeAlert(){
    $('.alert-temp').removeClass('in');
  }

  function removeAlert(){
    $('.alert-temp').remove();
  }

  window.setTimeout(fadeAlert,3000);
  window.setTimeout(removeAlert,7000);

//   $("#myToggleNavbar").click(function() {
//     $(.collapse).collapse("toggle");
//   });
  
});