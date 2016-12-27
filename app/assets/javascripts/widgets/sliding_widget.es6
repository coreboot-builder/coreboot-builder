class SlidingWidget {
  constructor(element, speed = 300) {
    this.element = $(element);
    this.content = $(element).find('.content-canvas');
    this.nextButton = this.element.find('[data-next-button]');
    this.prevButton = this.element.find('[data-prev-button]');
    this.form = this.element.find('form');
    this.speed = speed;
  }

  setContent(html) {
    this.content.html(html);
  }

  slideRight() {
    this.animateLeft('110%');
  }

  slideLeft() {
    this.animateLeft('-110%');
  }

  slideCenter() {
    this.animateLeft('0');
  }

  animateLeft(value) {
    this.element.animate({left: value}, this.speed);
  }
}
