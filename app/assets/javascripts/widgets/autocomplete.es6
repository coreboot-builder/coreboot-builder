class AutoComplete {
  constructor(element, data) {
    $(element).autocomplete({
      source: data
    });
  }
}
