var UserShow;

UserShow = function UserShow() {
  UserShow.prototype.initialize = function () {
    $(document).on('change', 'input[type=checkbox]', function (event) {
      var recording_id = $(event.target).data('recording-id');
      var data;
      if (event.target.checked) {
        data = 1;
      } else {
        data = 0;
      }
      $.ajax({
        url: '/twilio/recordings',
        type: 'PATCH',
        data: {value: data, recording_id: recording_id}
      });
    });
  };
};