//= require ./widgets/presenter
//= require ./widgets/autocomplete

$(function() {
  new Presenter($('[data-presenter]'), 500);

  // autocompletion for the device vendor
  new AutoComplete($('#device-vendor'), {
    'Lenovo': null,
    'Intel': null,
    'Dell': null,
    'HP': null,
    'ACER': null,
    'ASUS': null,
  });

  // autocompletion for the device model
  new AutoComplete($('#device-model'), {
    'Lenovo': null,
    'Intel': null,
    'Dell': null,
    'HP': null,
    'ACER': null,
    'ASUS': null,
  });
});
