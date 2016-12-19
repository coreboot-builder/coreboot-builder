class DeviceInput {
  constructor(vendor_input, model_input, vendor_endpoint, device_endpoint) {
    const disable_model_input = function() {
      $(model_input).siblings('label').removeClass('active');
      $(model_input).prop("disabled", true).val('');
      
    };

    const select_callback = function( event, ui ) {
      $.ajax({
        url: device_endpoint,
        data: { vendor_id: ui.item.id }
      }).done(function(data) {
        model_input.autocomplete({
          source: data
        }).prop("disabled", false).prop('value', null);
      }).error(function(data) {
        disable_model_input();
      });
    };

    // autocompletion for vendors
    vendor_input.autocomplete({
      source: vendor_endpoint,
      minLength: 2,
      select: select_callback
    }).on("autocompletechange", function( event, ui ) {
      if (ui.item == null) {
        disable_model_input();
      }
    });
  }
}
