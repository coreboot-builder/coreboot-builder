$(function() {
  new DeviceInput(
    $('#device-vendor'),
    $('#device-model'),
    '/api/v1/vendors.json',
    '/api/v1/devices.json'
  );

  $('select').material_select();

  new StatusUpdater($('section.build_state'));
});
