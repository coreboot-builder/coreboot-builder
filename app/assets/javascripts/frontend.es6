$(function() {
  new Presenter($('[data-presenter]'), 400);

  new DeviceInput(
    $('#device-vendor'),
    $('#device-model'),
    'api/v1/vendors.json',
    'api/v1/devices.json'
  );
});
