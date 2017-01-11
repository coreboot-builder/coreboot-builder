class DeviceInput {

  constructor(vendor_input, device_input, vendor_endpoint, device_endpoint) {
    const device_select_callback = function(event, ui) {
      $('input[name="build[device_id]"]').val(ui.item.id);
    };
    const vendor_select_callback = function( event, ui ) {
      const vendor_id = event.params.data.id;
      $(device_input).prop("disabled", null).prop('value', null).select2({
        theme: 'classic',
        allowClear: true,
        ajax: {
          url: device_endpoint,
          device_id: vendor_id,
          quietMillis: 50,
          processResults: function (data) {
            return {
              results: $.map(data.items, function (item) {
                return {
                  text: item.value,
                  id: item.id
                }
              })
            };
          }
        },
      });
    };

    

    $(vendor_input).select2({
      theme: 'classic',
      allowClear: true,
      ajax: {
        url: vendor_endpoint,
        quietMillis: 50,
        processResults: function (data) {
          return {
            results: $.map(data.items, function (item) {
              return {
                text: item.value,
                id: item.id
              }
            })
          };
        }
      },
    }).on('select2:select', vendor_select_callback);


    $(device_input).select2({
      disabled: true
    });





    // const device_input = function() {
    //   $(model_input).siblings('label').removeClass('active');
    //   $(model_input).prop("disabled", true).val('');
    // };

    // 

    

    // // autocompletion for vendors
    // vendor_input.autocomplete({
    //   source: vendor_endpoint,
    //   minLength: 2,
    //   select: vendor_select_callback
    // }).on("autocompletechange", function( event, ui ) {
    //   if (ui.item == null) {
    //     disable_model_input();
    //   }
    // });
  }
}
