$(document).ready(function () {

  $('#customers_table').dataTable({
    "aoColumnDefs": [{ "bSortable": false, "aTargets": [ 7,8,9 ] }],
    "bLengthChange": false,
    "bProcessing": true,
    /*"bServerSide": true,*/
    "bDestroy": true,

    "fnInitComplete": function(oSettings, json) {
      var search_input = (this).closest('.dataTables_wrapper').find('div[id$=_filter] input');
      search_input.attr('placeholder', 'Buscar');
      search_input.addClass('form-control input-small');
      search_input.css('width', '250px');
    },
    "sAjaxSource": $(this).data('source'),
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
    "fnDrawCallback": function( oSettings ) {
      $(this).find("img").tooltip();
    },
    "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
        if ( aData[10] == "" ){
          nRow.className = "active";
        }
        return nRow;
    }
  });

  $('body').on('click', '.new_vehicle', function (e) {
    e.preventDefault();
    $('#new-vehicle').modal({ fadeDuration: 250, keyboard: true });
  });


});

