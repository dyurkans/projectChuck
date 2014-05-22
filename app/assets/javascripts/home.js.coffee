# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery -> $('.tournTable').dataTable({
          "bDestroy" : true,
          "aoColumnDefs" : [ {
          "bSortable" : false,
          "aTargets" : [ "no-sort" ]
          } ],
          "aLengthMenu": [
            [10, 25, 50, 100, -1],
            [10, 25, 50, 100, "All"]
          ]
        }); 
