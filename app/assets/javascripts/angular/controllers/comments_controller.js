(function () {
  var app = angular.module('app', []);

  app.filter('fromNow', function () {
    return function (date) {
      return moment(date).fromNow();
    };
  });

  app.controller("CommentsController", ['$scope', '$http', function ($scope, $http) {
    $scope.form = {message: 'Add Comment'};
    $scope.showForm = false;
    $scope.comments = [];
    $scope.filter_by = '-created_at';

    $scope.toggleForm = function () {
      $scope.showForm = !$scope.showForm;
      $scope.toggleFormMessage();
    };

    $scope.toggleFormMessage = function () {
      if ($scope.showForm) {
        $scope.form.message = "Hide Comments Form"
      } else if ($scope.showForm === false) {
        $scope.form.message = "Add Comment"
      }
    };

    $scope.addComment = function (recording_id) {
      var csrfToken = $('meta[name=csrf-token]').attr('content');
      var csrfParam = $('meta[name=csrf-param]').attr('content');

      var post_data = {
        csrfToken: csrfParam,
        comment: {
          recording_id: recording_id,
          body: $scope.comment.body
        }
      };
      $http.post("/comments", post_data).success(function (data) {
        $scope.comments.push(data);
        $scope.resetComment();
      });
    };

    $scope.resetComment = function () {
      $scope.comment = {}
    };

  }]);
})();