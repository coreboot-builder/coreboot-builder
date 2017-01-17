$(function() {
  new DeviceInput(
    $('#build_device_vendor'),
    $('#build_device_model'),
    '/api/v1/vendors.json',
    '/api/v1/devices.json'
  );

  new StatusUpdater($('section.build_state'));
});
