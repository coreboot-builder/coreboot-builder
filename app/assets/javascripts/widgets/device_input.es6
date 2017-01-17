class DeviceInput {

  constructor(vendor_input, device_input, vendor_endpoint, device_endpoint) {
    const device_select_callback = function(event, ui) {
      console.log('yay');
      $('input[name="build[device_id]"]').val(ui.item.id);
    };

    const vendor_select_callback = function( event, ui ) {
      const vendor_id = event.params.data.id;

      $.ajax({
        url: device_endpoint,
        data: {
          vendor_id: vendor_id
        }
      }).done(function(response) {
        $(device_input).prop("disabled", null).prop('value', null);
        $(device_input).find('option').remove();

        $(device_input).select2({
          theme: 'classic',
          data: response
        }).on('select2:select', device_select_callback);
      });
    };

    $(vendor_input).select2({
      theme: 'classic',
      ajax: {
        url: vendor_endpoint,
        quietMillis: 50,
        processResults: function (data) {
          var results =  {
            results: $.map(data.items, function (item) {
              return {
                text: item.value,
                id: item.id
              }
            })
          };
          return results;
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
