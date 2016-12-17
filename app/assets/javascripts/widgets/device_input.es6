class DeviceInput {
  constructor(vendor_input, model_input, vendor_endpoint, device_endpoint) {
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
    vendor_input.autocomplete({
      source: vendor_endpoint,
      minLength: 2,
      select: select_callback
    });
  }
}
