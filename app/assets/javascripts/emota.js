$(document).ready(function(){
  var uID = Math.floor((Math.random()*100)+1)

  var pusher = new Pusher(Rails.application.secrets.PUSHER_APP_KEY)
  var channel = pusher.subscribe('emotum_process_'+uID)

  channel.bind('update', function(data) {
    var messageBox = $('#create-account-form-with-realtime').children('.messages')
    var progressBar = $('#realtime-progress-bar')

    progressBar.width(data.progress+"%")
    messageBox.html(data.message)

    if (data.progress == 100) {
      messageBox.html('Was it better with this process?')
    }
  });
})
