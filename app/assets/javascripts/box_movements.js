$(document).ready(function () {


  $("#box_movement_cost_center").chosen({
      width: "100%"
  });

  $("#box_movement_box_movement_type").chosen({
      width: "100%"
  });
    $("#box_movement_currency_id").chosen({
      width: "100%"
  });

  $("#box_movement_user_id").chosen({
      width: "100%"
  });

  $('#box_movement_date').datetimepicker({
    language:  'es',
    weekStart: 1,
    autoclose: 1,
    todayHighlight: 1,
    format: "dd MM yyyy - hh:ii"
  });

  $().button('toggle');

  $('.chbx-mon, .chbx-day').on("change", function (e) {
    filterMovement();
  });

  $('.elboton').on("click", function (e) {
    balance($("tr.park"), "parking");
    balance($("tr.tall"), "taller");
    balance($("tr.lava"), "lava");
    balance($("tr.cyp"), "cyp");
    balance($("tr.vent"), "ventauto");
    balance($("tr.adm"), "admin");
    balance($("tr.comp"), "comp");
  });

  $("#box_movement_cost_center").chosen().change( function () {
    var value = $(this).val();
    if (value == 'Taller' || value == 'Chapa y Pintura') {
      $.get('/box_movements/extra_data/', function (data) {
        $(data).insertAfter(".cost-center-fields");
        $("#box_movement_work_order_id").chosen({ width: "100%" });
      });
    }else{
      $(".work-ord-data").remove();
    }
  });



  setDefaultMonth();

});


function setDefaultMonth() {
  var d = new Date();
  var actual_month = d.getMonth() +   1 ;
  var chbox = $(".months-group :checkbox[value="+ actual_month +"]")
  chbox.prop("checked","true");
  chbox.parent().addClass("active");
  filterMovement();
}

function filterMovement() {
  months = $(".months-group input:checked").map(function() { return $( this ).val(); }).get().join( "," );
  days = $(".days-group input:checked").map(function() { return $( this ).val(); }).get().join( "," );
  $.ajax({
    method: "GET",
    url: "/box_movements",
    data: { months: months, days: days }
  })  .done(function( data) {
    $('#tab_box_cont').html(data);
    setDataTable();
  });
}

function setDataTable(){
  $('#box_movement_table').dataTable({
    "aoColumnDefs": [{ "bSortable": false, "aTargets": [ 7,8 ] }],
    "pageLength": 50,
    "bLengthChange": false,
    "bProcessing": true,
    "fnInitComplete": function(oSettings, json) {
      var search_input = (this).closest('.dataTables_wrapper').find('div[id$=_filter] input');
      search_input.attr('placeholder', 'Buscar');
      search_input.addClass('form-control input-small');
      search_input.css('width', '250px');
    },
    "oLanguage": {  "sProcessing": "Procesando...",
                    "sLoadingRecords": "Cargando...",
                    "sLengthMenu": "Mostrar _MENU_ registros",
                    "sZeroRecords": "No se encontraron resultados",
                    "sInfo": "Mostrando desde _START_ hasta _END_ de _TOTAL_ registros",
                    "sInfoEmpty": "No existen registros",
                    "sInfoFiltered": "(filtrado de un total de _MAX_ líneas)",
                    "sInfoPostFix": "",
                    "sSearch": "",
                    "sUrl": "",
                    "oPaginate": { "sFirst":    "Primero",
                                   "sPrevious": "Anterior",
                                   "sNext":     "Siguiente",
                                   "sLast":     "Último" }
    },
    "footerCallback": function ( row, data, start, end, display ) {
      $(".tot-data").each(function(){
        $(this).text(0);
      });
      balance($("tr.park"), "parking");
      balance($("tr.tall"), "taller");
      balance($("tr.lava"), "lava");
      balance($("tr.cyp"), "cyp");
      balance($("tr.vent"), "vent");
      balance($("tr.adm"), "adm");
      balance($("tr.comp"), "comp");
      }
  });
}


function balance(selector, name ) {
  var total_in_pesos = 0
  var total_out_pesos = 0
  var total_in_dollar = 0
  var total_out_dollar = 0
  selector.each(function(i){
    if ($($(this).children()[4]).text() ==  'Entrada') {
      if ($($(this).children()[6]).text() ==  '$') {
        total_in_pesos = total_in_pesos + parseInt($($(this).children()[5]).text())
      }else{
        if ($($(this).children()[6]).text() ==  'U$S') {
          total_in_dollar = total_in_dollar + parseInt($($(this).children()[5]).text())
        }
      }
    }else{
      if ($($(this).children()[4]).text() ==  'Salida') {
        if ($($(this).children()[6]).text() ==  '$') {
          total_out_pesos = total_out_pesos+ parseInt($($(this).children()[5]).text())
        }else{
          if ($($(this).children()[6]).text() ==  'U$S') {
            total_out_dollar = total_out_dollar + parseInt($($(this).children()[5]).text())
          }
        }
      }
    }
  });
  var total_pesos = total_in_pesos - total_out_pesos;
  var total_dollar = total_in_dollar - total_out_dollar;

  $("#in_"+name+"_pesos").text(total_in_pesos);
  $("#out_"+name+"_pesos").text(total_out_pesos);
  $("#tot_"+name+"_pesos").text(total_pesos);
  $("#in_"+name+"_dollar").text(total_in_dollar);
  $("#out_"+name+"_dollar").text(total_out_dollar);
  $("#tot_"+name+"_dollar").text(total_dollar);
  sumTotals(total_in_pesos, total_out_pesos, total_pesos, total_in_dollar,total_out_dollar,total_dollar);
}


function sumTotals(total_in_pesos, total_out_pesos, total_pesos, total_in_dollar,total_out_dollar,total_dollar) {
  $("#in_pesos_tot").text( parseInt($("#in_pesos_tot").text()) + total_in_pesos );
  $("#out_pesos_tot").text( parseInt($("#out_pesos_tot").text()) + total_out_pesos);
  $("#tot_pesos").text( parseInt($("#tot_pesos").text()) + total_pesos);
  $("#in_dollar_tot").text( parseInt($("#in_dollar_tot").text()) + total_in_dollar);
  $("#out_dollar_tot").text( parseInt($("#out_dollar_tot").text()) +  total_out_dollar);
  $("#tot_dollar").text( parseInt($("#tot_dollar").text()) + total_dollar);
}
