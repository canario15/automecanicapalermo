  $(document).ready(function () {

  $("#work_order_customer_id").chosen({
    width: "90%"
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

  $('#work_order_deliver_date').datetimepicker({
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

  $('.btn-save-bud').click(function (e) {
    e.preventDefault();
    save_form($('.form-budg'));
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

  $('.input-group-addon select').on('change' , function () {
    sum_totals_bugets();
  });

  $('.work-dones-field, .rep-field').blur(function () {
    sum_totals_bugets();
  });

  $('.go-budget').click(function (e) {
    e.preventDefault();
    var rowCount = $('#work-done-table tr').length;
    if (rowCount < 1 ){
      $.notify(
        "Ingrese los trabajos realizados y repuestos luego podra reliazar la factura",
        { position:"top center",
          className: "error"
        }
      );
    } else {
      var id = $('#work_order_number').text();
      window.location.replace("/work_orders/"+ id +"/budget");
    }
  });

  $('#print_budget').click(function (e) {
    e.preventDefault();
    save_form($('.form-budg'));
    var id = $('#work_order_id').val();
    var url = "/work_orders/"+ id +"/budget.pdf";
    window.open(url,'_blank');
  });


  $('#save_wo_customer').click(function (e) {
    $('#customer_owner').parent().parent().removeClass('has-error');
    $('#customer_phone').parent().parent().removeClass('has-error');
    $('#customer_vehicles_attributes_0_year').parent().parent().removeClass('has-error');
    $('#customer_vehicles_attributes_0_model').parent().parent().removeClass('has-error');
    $('#customer_vehicles_attributes_0_plate').parent().parent().removeClass('has-error');
    $('#customer_vehicles_attributes_0_color').parent().parent().removeClass('has-error');
    $('#new_customer .span-err').remove();
    $.ajax({
      type    : 'POST',
      url     : '/customers',
      data    : $('#new_customer').serialize(),
      dataType  : 'json'
    }).done(function(data) {
      if ( data.status == 'OK') {
        noty_alert(data.message, "success");
        var customer = jQuery.parseJSON( data.customer );
        update_customers_select(customer.id, customer.owner);
        $.get('/customers/' + customer.id + '/vehicles', function (data) {
          var select_vehicles = $(".collect-vehi select");
          $(".collect-vehi select").remove();
          $("#work_order_vehicle_id_chosen").remove();
          $(".collect-vehi").append(data);
          $(".collect-vehi select").chosen({ width: "100%" });;
        });
        $('#customer_modal').modal('hide');

      }else{
        if (data.errors.owner) {
          $('#customer_owner').parent().parent().addClass('has-error');
          $('#customer_owner').parent().append("<span class='span-err'> <i class='fa fa-exclamation-triangle'></i>"+ data.errors.owner + "</span>");
        }
        if (data.errors.phone) {
          $('#customer_phone').parent().parent().addClass('has-error');
          $('#customer_phone').parent().append("<span class='span-err'> <i class='fa fa-exclamation-triangle'></i>"+ data.errors.phone + "</span>");
        }
        if (data.errors["vehicles.year"]) {
          $('#customer_vehicles_attributes_0_year').parent().parent().addClass('has-error');
          $('#customer_vehicles_attributes_0_year').parent().append("<span class='span-err'> <i class='fa fa-exclamation-triangle'></i>"+ data.errors["vehicles.year"] + "</span>");
        }
        if (data.errors["vehicles.model"]) {
          $('#customer_vehicles_attributes_0_model').parent().parent().addClass('has-error');
          $('#customer_vehicles_attributes_0_model').parent().append("<span class='span-err'> <i class='fa fa-exclamation-triangle'></i>"+ data.errors["vehicles.model"] + "</span>");
        }
        if (data.errors["vehicles.plate"]) {
          $('#customer_vehicles_attributes_0_plate').parent().parent().addClass('has-error');
          $('#customer_vehicles_attributes_0_plate').parent().append("<span class='span-err'> <i class='fa fa-exclamation-triangle'></i>"+ data.errors["vehicles.plate"] + "</span>");
        }
        if (data.errors["vehicles.color"]) {
          $('#customer_vehicles_attributes_0_color').parent().parent().addClass('has-error');
          $('#customer_vehicles_attributes_0_color').parent().append("<span class='span-err'> <i class='fa fa-exclamation-triangle'></i>"+ data.errors["vehicles.color"] + "</span>");
        }
      }
    })
    .fail(function(data) {
      noty_alert("No se pudo guardar, cierre e intente nuevamente", "error");

    });

  });

});


function sum_totals_bugets(){
  /*SUM WORK DOES SUB TOTAL*/
  var sum_work_dones = 0;
  $('.work-dones-field').each(function() {
    sum_work_dones += Number($(this).val());
  });
  $('.subtot-wor-do').val(sum_work_dones);

  /*SUM REPLACEMENT SUB TOTAL*/
  var sum_rep_subtotal = 0;
  var sum_rep_subtotal_dol = 0;
  $('.rep-field').each(function() {
    if (($($($($(this)).prev()).children()[0]).val()) == "$" ) {
        sum_rep_subtotal += Number($(this).val());
    }else{
      if (($($($($(this)).prev()).children()[0]).val()) == "U$S" ) {
        sum_rep_subtotal_dol += Number($(this).val());
      }
    }
  });
  $('.sub-tot-rep').val(sum_rep_subtotal);
  $('.sub-tot-rep-dol').val(sum_rep_subtotal_dol);

  /* SUM BOX MOVEMENTS BY CURRENCY*/
  var sum_adl_pes = 0;
  var sum_adl_dol = 0;
  $('.curr-type').each(function() {
    if ($(this).text() == "$") {
      sum_adl_pes += Number($($(this).next()).text());
    } else {
      if ($(this).text() == "U$S") {
        sum_adl_dol += Number($($(this).next()).text());
      }
    }
  });

  /*SET ALL TOTALS*/
  $('.total-budget-dol').val(sum_rep_subtotal_dol - sum_adl_dol);
  $('.total-budget').val(sum_work_dones + sum_rep_subtotal - sum_adl_pes);

}

function save_form(form) {
  $.post($(form).attr('action'), $(form).serialize(), function(response){
    var type    = response["status"];
    var message = response["message"];
    $.notify(
      message,
      { position:"top center",
        className: type
     }
    );

  },'json');
  return false;
}

function update_customers_select(customer_id, customer_name) {
  $("#work_order_customer_id").append("<option value="+ customer_id +">"+ customer_name + "</option>");
  $("#work_order_customer_id").val(customer_id);
  $("#work_order_customer_id").trigger("chosen:updated");
}
