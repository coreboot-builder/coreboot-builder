class StatusUpdater {
  constructor(element, interval_ms = 3000) {
    this.element = element;
    this.interval_ms = interval_ms;

    this.build_state = this.element.data('build-state');
    this.build_id = this.element.data('build-id');

    if (this.build_state != undefined) {
      this.poll();
    }
  }

  poll() {
    // Get state from remote
    $.ajax({
      url: `/api/v1/builds/${this.build_id}/state`
    }).done(function(data) {
      if (data.state != this.build_state) {
        this.element.location.reload(true);
      }

      setTimeout(() => {
        this.poll();
      }, this.interval_ms);
    });
  }
}
