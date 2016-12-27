class DeviceInput {
  constructor(vendor_input, device_input, vendor_endpoint, device_endpoint) {

    const disable_device_input = function() {
      $(device_input).siblings('label').removeClass('active');
      $(device_input).prop("disabled", true).val('');
    };

    const select_callback = function( event, ui ) {
      $.ajax({
        url: device_endpoint,
        data: { vendor_id: ui.item.id }
      }).done(function(data) {
        device_input.autocomplete({
          source: data
        }).prop("disabled", false).prop('value', null)
        .on('autocompleteselect', function(event, ui) {
          $('#build_device_id').prop('value', ui.item.id);
        });
      }).error(function(data) {
        disable_device_input();
      });
    };

    // autocompletion for vendors
    vendor_input.autocomplete({
      source: vendor_endpoint,
      minLength: 2,
      select: select_callback
    }).on("autocompletechange", function( event, ui ) {
      if (ui.item == null) {
        disable_device_input();
      }
    });
  }
}
