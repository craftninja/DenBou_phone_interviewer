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

    it("hides #welcomebox and shows #about_welcomebox when a user clicks on .link_like", function () {
      var fixture = '<div id="welcomebox"><p><span class="switch link_like">About this project</span></p></div><div id="about_welcomebox" hidden><p><span class="switch link_like">Back to Login</span></p></div>'
      $('#jasmine_content').append(fixture);
      welcome = new Welcome();
      welcome.toggleWelcomeBoxes();
      $('.link_like:first').click();
      expect($('#welcomebox')).toBeHidden();
      expect($('#about_welcomebox')).not.toBeHidden();

      $('.link_like:last').click();
      expect($('#welcomebox')).not.toBeHidden();
      expect($('#about_welcomebox')).toBeHidden();
    });

  });

});
