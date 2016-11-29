$(document).ready(function () {

  $("#work_order_customer_id").chosen({
    width: "100%"
  });
  $("#work_order_vehicle_id").chosen({
    width: "100%"
  });

  $("#work_order_received_by_id").chosen({
    width: "100%"
  });
  $("#work_order_worked_by_id").chosen({
    width: "100%"
  });
  $("#work_order_delivered_by_id").chosen({
    width: "100%"
  });

  $("#work_order_fuel").chosen({
    width: "100%"
  });

  $('#work_order_date_in').datetimepicker({
    language:  'es',
    weekStart: 1,
    autoclose: 1,
    todayHighlight: 1,
    format: "dd MM yyyy - hh:ii"
  });

  $('#work_order_table').dataTable({
    "aoColumnDefs": [{ "bSortable": false, "aTargets": [ 8,9 ] }],
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
  });




  $("#work_order_customer_id").chosen().change( function () {
    var id = $(this).val();
    if(id == "" ) {
      id = 0;
    }
    $.get('/customers/' + id + '/vehicles', function (data) {
      var select_vehicles = $(".collect-vehi select");
      $(".collect-vehi select").remove();
      $("#work_order_vehicle_id_chosen").remove();
      $(".collect-vehi").append(data);
      $(".collect-vehi select").chosen({ width: "100%" });;
    });
  });

  $("#work_order_vehicle_id").chosen().change( function () {
    var id = $(this).val();
    $.get('/vehicles/' + id + '/owner', function (data) {
      $("#work_order_customer_id").val(data["id"]).trigger("chosen:updated");
    });
  });

  $('.work-dones-field').blur(function () {
    var sum = 0;
    $('.work-dones-field').each(function() {
        sum += Number($(this).val());
    });
    $('.subtot-wor-do').val(sum);
  });

  $('.rep-field').blur(function () {
    var sum = 0;
    $('.rep-field').each(function() {
        sum += Number($(this).val());
    });
    $('.sub-tot-rep').val(sum);
  });

  $('.work-dones-field, .rep-field').blur(function () {
    var sum = 0;
    $('.sub-tot').each(function() {
        sum += Number($(this).val());
    });
    $('.total-budget').val(sum);
  });

  $('.go-budget').click(function (e) {
    e.preventDefault();
    var rowCount = $('#work-done-table tr').length;
    if (rowCount < 1 ){
      alert("Ingrese los trabajos realizados y repuestos luego podra reliazar la factura");
    } else {
      var id = $('#work_order_number').text();
      window.location.replace("/work_orders/"+ id +"/budget");
    }
  });

});

