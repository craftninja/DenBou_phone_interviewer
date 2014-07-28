var Welcome;

Welcome = function Welcome() {

  Welcome.prototype.initialize = function () {
    this.toggleWelcomeBoxes();
  };

  Welcome.prototype.toggleWelcomeBoxes = function () {
    $(".js_welcome_toggle").on("click", function (event) {
      event.preventDefault();
      $("#welcome_container").toggle('300ms');
      $("#about_welcome_container").toggle('300ms');
    });
  };
};
