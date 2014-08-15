describe("CommentsController", function () {
  describe("the comment form", function () {

    var $rootScope, $httpBackend, $controller;

    beforeEach(module('app'));

    beforeEach(inject(function ($injector) {
      $httpBackend = $injector.get('$httpBackend');
      $rootScope = $injector.get('$rootScope');
      $controller = $injector.get('$controller');

      CreateController = function () {
        return $controller('CommentsController', {$scope: $rootScope});
      };
    }));

    afterEach(function () {
      $httpBackend.verifyNoOutstandingExpectation();
      $httpBackend.verifyNoOutstandingRequest();
    });

    it("assigns variables when the controller is created", function () {
      CreateController();
      expect($rootScope.form).toEqual({message: 'Add Comment'});
      expect($rootScope.showForm).toEqual(false);
      expect($rootScope.comments).toEqual([]);
      expect($rootScope.filter_by).toEqual('-created_at');
    });

    it("can toggle the form", function () {
      CreateController();
      expect($rootScope.showForm).toEqual(false);
      expect($rootScope.form).toEqual({message: 'Add Comment'});

      $rootScope.toggleForm();

      expect($rootScope.showForm).toEqual(true);
      expect($rootScope.form).toEqual({message: 'Hide Comments Form'});

      $rootScope.toggleForm();

      expect($rootScope.showForm).toEqual(false);
      expect($rootScope.form).toEqual({message: 'Add Comment'});
    });

    it("can toggle the form message", function () {
      CreateController();
      expect($rootScope.form).toEqual({message: 'Add Comment'});

      $rootScope.toggleForm();

      expect($rootScope.form).toEqual({message: 'Hide Comments Form'});

      $rootScope.toggleForm();

      expect($rootScope.form).toEqual({message: 'Add Comment'});
    });

    it("can reset the comment form", function () {
      CreateController();
      $rootScope.comment = {
        body: 'A comment',
        user_first_name: 'Nate',
        created_at: new Date('2014-08-14 10:04:07 -0600')
      };

      $rootScope.resetComment();

      expect($rootScope.comment).toEqual({});
    });

    it("can add a comment", function () {
      var data = {
        body: 'A comment',
        user_first_name: 'Nate',
        created_at: new Date('2014-08-14 10:04:07 -0600')
      };

      $httpBackend.when("POST", "/comments").respond(
        200,
        data
      );

      CreateController();

      var recording_id = 1;
      $rootScope.comment = {body: 'A comment'};

      $rootScope.addComment(recording_id);
      $httpBackend.flush();

      expect($rootScope.comments).toEqual([data])
    });

  });
});