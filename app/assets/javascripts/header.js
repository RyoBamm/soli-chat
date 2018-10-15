$(function(){
  $('.user-information-wrapper').on('click', function(e){
    var clickCondition = $('.user-nav').css('display');
    console.log(clickCondition);
    if (clickCondition == 'block') {
      $('.user-nav').css('display', 'none')
    }else{
      $('.user-nav').css('display', 'block')
    }
  });
});
