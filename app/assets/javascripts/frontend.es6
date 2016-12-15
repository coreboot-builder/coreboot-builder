//= require ./widgets/presenter

$(function() {
  new Presenter($('[data-presenter]'), 500);

  const model_input = $( "#device-model" );
  const vendor_endpoint = 'api/v1/vendors.json';
  const device_endpoint = 'api/v1/devices.json';

  const select_callback = function( event, ui ) {
    $.ajax({
      url: device_endpoint,
      data: { vendor_id: ui.item.id }
    }).done(function(data) {
      model_input.autocomplete({
        source: data
      }).prop("disabled", false).prop('value', null);
    }).error(function(data) {
      model_input.prop("disabled", true);
    });
  };

  // autocompletion for vendors
  $('#device-vendor').autocomplete({
    source: vendor_endpoint,
    minLength: 2,
    select: select_callback
  });
 
});
