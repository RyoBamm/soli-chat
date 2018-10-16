$(function(){
$(document).on('turbolinks:load', function() {
  $('.user-information-wrapper').on('click', function(e){
    var clickCondition = $('.user-nav').css('display');
    console.log(clickCondition);
    if (clickCondition == 'block') {
      $('.user-nav').css('display', 'none');
      $('.user-information-wrapper a').text("Menu");
    }else{
      $('.user-nav').css('display', 'block');
      $('.user-information-wrapper a').text("Close");
    }
  });
});
});
