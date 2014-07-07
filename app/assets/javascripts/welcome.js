var Welcome;

Welcome = function Welcome() {

  Welcome.prototype.initialize = function () {
    this.toggleWelcomeBoxes();
  };

  Welcome.prototype.toggleWelcomeBoxes = function () {
    $(".switch").on("click", function () {
      $("#welcomebox").toggle('slow');
      $("#about_welcomebox").toggle('slow');
    });
  };
};
