// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//
//= require jquery.min
//= require bootstrap.min
//= require jquery.dataTables
//= require dataTables.responsive
//= require dataTables.bootstrap
//= require bootstrap-datetimepicker
//= require bootstrap-datetimepicker.es

//= require raphael
//= require cocoon
//= require chosen.jquery
//= require metisMenu
//= require sb-admin-2
//= require customers
//= require work_orders
//= require users
//= require vehicles
//= require box_movements
//= require notify

$(document).ready(function () {

  if ($('#have_alert').text() != 0 ){
    var type    = $('#have_alert').data('type');
    var message = $('#have_alert').text();
    $.notify(
      message,
      { position:"top center",
        className: type
      }
    );
    $('#have_alert').remove();
  };


});

function show_alert(type, message){
  switch (type){
    case 'error':
      title = "Error!";
      if (message == ""){
        message = "Algo no esta del todo bien intente nuevamente";
      }
      break;
    case 'info':
      title = "Atención!";
      break;
    case 'success':
      title = "Ok!";
      if (message == ""){
        message = "La transacción se ha completado con éxito";
      }
      break;
  }
}


