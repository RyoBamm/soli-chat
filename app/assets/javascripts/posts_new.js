$(function(){

  // post_type_selecter変更時の処理
  $(document).on("change", '.post_type_selecter', function() {
    var typeVal = $('.post_type_selecter').val();
    if (typeVal == 'video'){
      $('.input_url_youtube').val('');
      $('#input_youtube_player')[0].src = '';
      $('.input_video_form').css('display', 'block');
      $('.input_youtube_form').css('display', 'none');
      $('.description_form').css('margin-top', '420px');
      $('video').load();
    } else if (typeVal == 'youtube'){
      $('.input_video_name').text('ファイルが選択されていません');
      $('.input_file_video').val('');
      $('#input_video_player')[0].src = '';
      $('video').load();
      $('.input_video_form').css('display', 'none');
      $('.input_youtube_form').css('display', 'block');
      $('.description_form').css('margin-top', '40px');
    }
  });

  // videoファイル選択時の処理
  $(document).on("change", '.input_file_video', function() {
    var source = $('#input_video_player');
    $('.input_video_name').text(this.files[0].name);
    source[0].src = URL.createObjectURL(this.files[0]);
    source.parent()[0].load();
  });

  // youtubeのurl入力時の処理
  $(document).on("keyup", '.input_url_youtube', function() {
    var customized_youtube_url = $('.input_url_youtube').val().replace('https://www.youtube.com/watch?v=', '') .split('&')[0];
    $('#input_youtube_player')[0].src = "https://www.youtube.com/embed/" + customized_youtube_url;
  });

  // category_selecter変更時の処理
  $(document).on("change", '.category_selecter', function() {
    $('.category_selecter').css('display', 'inline-block');
    if ($('.category_selecter1 option:selected').val() == "" || !$('.category_selecter1 option:selected').length){
      $('.category_selecter2').css('display', 'none');
      $('.category_selecter2').attr("checked",false);
      $(".category_selecter2 option").attr("selected",false);
      $('.category_selecter3').css('display', 'none');
      $('.category_selecter3').attr("checked",false);
      $(".category_selecter3 option").attr("selected",false);
    }
    if ($('.category_selecter2 option:selected').val() == "" || !$('.category_selecter2 option:selected').length ){
      $('.category_selecter3').css('display', 'none');
      $('.category_selecter3').attr("checked",false);
      $(".category_selecter3 option").attr("selected",false);
    }
  });

  // category_selecter2,3の初期化
  $(document).ready( function(){
    $('.category_selecter2').attr("checked",false);
    $(".category_selecter2 option").attr("selected",false);
    $('.category_selecter3').attr("checked",false);
    $(".category_selecter3 option").attr("selected",false);
  });
});
