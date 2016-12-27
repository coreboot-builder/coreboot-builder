//= require ./sliding_widget

class Presenter {
  constructor(element, speed = 300) {
    this.element = element;
    this.speed = speed;
    this.currentSlide = 0;

    this.slides = this.element.find('[data-animated-slide]').map((index, elm) => {
      return new SlidingWidget(elm, this.speed);
    });

    this.slides.each((index, currentSlide) => {
      const nextSlide = this.slides[index + 1];

      if (index != (this.slides.length - 1)) {
        currentSlide.nextButton.click(() => {
          nextSlide.slideCenter();
          this.processSlide(currentSlide, nextSlide);
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

  addSlide()

  processSlide(currentSlide, nextSlide) {
    const form = currentSlide.form;
    console.log(form);
    if (form.length > 0) {
      const action = form.prop('action');
      const method = form.prop('method');

      $.ajax({
        url: action,
        method: method,
        data: form.serialize()
      }).done(function(data) {
        nextSlide.setContent(data);
        if ($(data).find('#device-vendor')) {
          new DeviceInput(
            $('#device-vendor'),
            $('#device-model'),
            'api/v1/vendors.json',
            'api/v1/devices.json'
          );
        }
          
      }).error(function(data) {
        
      });  
    }
    
  }
}
