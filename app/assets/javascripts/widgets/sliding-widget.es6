class SlidingWidget {
  constructor(element, speed = 300) {
    this.element = $(element);
    this.nextButton = this.element.find('[data-next-button]');
    this.prevButton = this.element.find('[data-prev-button]');
    this.speed = speed;
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
