describe("Homepage", function () {
var welcome;
  beforeEach(function () {
    $('body').css('background', 'white');
  });

  describe("toggling login vs about information", function () {
    beforeEach(function () {
      jQuery.fx.off = true;
    });

    afterEach(function () {
      $('#jasmine_content').empty();
      jQuery.fx.off = false;
    });

    it("hides #welcomebox and shows #about_welcomebox when a user clicks on .js_welcome_toggle", function () {
      var fixture = '<div id="welcome_container" class="center"><a class="js_welcome_toggle main_link" href="#">About this project</a></div><div id="about_welcome_container" class="center" hidden><a class="js_welcome_toggle main_link" href="#">Back to Login</a></div>'
      $('#jasmine_content').append(fixture);
      welcome = new Welcome();
      welcome.toggleWelcomeBoxes();
      $('.js_welcome_toggle:first').click();
      expect($('#welcome_container')).toBeHidden();
      expect($('#about_welcome_container')).not.toBeHidden();

      $('.js_welcome_toggle:last').click();
      expect($('#welcome_container')).not.toBeHidden();
      expect($('#about_welcome_container')).toBeHidden();
    });

  });

});
