//= require ./sliding_widget

class Presenter {
  constructor(element, speed = 300) {
    this.element = element;
    this.speed = speed;

    this.slides = this.element.find('[data-animated-slide]').map((index, elm) => {
      return new SlidingWidget(elm, this.speed);
    });

    this.slides.each((index, currentSlide) => {
      const nextSlide = this.slides[index + 1];

      if (index != (this.slides.length - 1)) {
        currentSlide.nextButton.click(() => {
          nextSlide.slideCenter();
        });
      }

      if (index != 0) {
        currentSlide.prevButton.click(() => {
          currentSlide.slideRight();
        });
      }

      currentSlide.slideRight();
    });

    this.slides[0].slideCenter();
  }
}
