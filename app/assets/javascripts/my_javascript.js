$(function(){
  $( "input.datepicker" ).datepicker({"dateFormat": "DD, d MM, yy"}).val;
  
  // styling for dataTables
  $( "div[id*='DataTables_Table'][id$='info']" ).css("float", "right");
  $( "select[name*='DataTables_Table'][name$='length']" ).addClass("btn btn-default");
  $( ".dataTables_length" ).addClass("col-xs-12 col-sm-12 col-md-12 col-lg-12");
  $( ".dataTables_length > label" ).addClass("col-xs-12 col-sm-12 col-md-12 col-lg-12")
  $( ".dataTables_info" ).parent().addClass("col-xs-12 col-sm-12 col-md-12 col-lg-12");
  $( ".dataTables_paginate" ).parent().addClass("col-xs-12 col-sm-12 col-md-12 col-lg-12");

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