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
        this.attachNextClickHandler(currentSlide, index);
      }

      if (index != 0) {
        this.attachPrevClickHandler(currentSlide, index);
      }

      currentSlide.slideRight();
    });

    this.slides[0].slideCenter();
  }

  attachPrevClickHandler(slide, index) {
    if (index != 0) {
      slide.prevButton.click(() => {
        slide.slideRight();
        this.currentSlide--;
      });
    }
  }

  attachNextClickHandler(slide, index) {
    const nextSlide = this.slides[index + 1];
    if (nextSlide) {
      slide.reload().nextButton.click(() => {
        nextSlide.slideCenter();
        this.processSlide();
        this.currentSlide++;
      });  
    }
  }



  processSlide() {
    const currentSlide = this.slides[this.currentSlide];
    const nextSlide = this.slides[this.currentSlide + 1];
    const form = currentSlide.form;
    const self = this;

    if (form.length > 0) {
      const action = form.prop('action');
      const method = form.prop('method');
      const params = form.serialize();

      var fileSelect = document.getElementById('build_blob_file');
      
      if (fileSelect) {
        var files = fileSelect.files;
        var formData = new FormData();
        
        $(files).each((index, file) => {
          var file = files[index];
          var url_params = form.serializeArray();
          $(url_params).each(function(index, element) {
            formData.append(element.name, element.value);
          });

          formData.append('build[blob_file]', file, file.name);

          const xhr = new XMLHttpRequest();
          // Open the connection.
          xhr.open('post', action, true);

          xhr.onload = function () {
            if (xhr.status === 200) {
              // File(s) uploaded.
            } else {
              alert('An error occurred!');
            }
          };
          // Send the Data.
          xhr.send(formData);
        });
      } else {
        $.ajax({
          url: action,
          method: method,
          data: params,
          contentType: form.contentType
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
          self.attachNextClickHandler(nextSlide, self.currentSlide);
          self.attachPrevClickHandler(nextSlide, self.currentSlide);
        }).error(function(data) {
          
        });  
      }  
    }
  }
}
