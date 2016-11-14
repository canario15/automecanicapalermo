$(document).ready(function () {

  $("#work_order_customer_id").chosen({
    width: "100%"
  });
  $("#work_order_vehicle_id").chosen({
    width: "100%"
  });

  $("#work_order_user_id").chosen({
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

  $("#work_order_customer_id").chosen().change( function () {
    var id = $(this).val();
    if(id == "" ) {
      id = 0;
    }
    $.get('/customers/' + id + '/vehicles', function (data) {
      var select_vehicles = $("#work_order_vehicle_id");
      select_vehicles.empty();
      $.each(data, function (idx, obj) {
        select_vehicles.append('<option value="' + obj.id + '">' + obj.brand + ' ' + obj.model + ' - ' + obj.plate + '  </option>');
      });
      select_vehicles.trigger("chosen:updated");
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

});

