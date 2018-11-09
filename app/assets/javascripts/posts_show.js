$(function(){
// $(document).on('turbolinks:load', function() {

  // コメント表示画面のHTMLを作成
  function buildHTML(comment){
    var html =
 `<p class = "comment_text">${comment.comment}</p>
  <a href = "/posts/${comment.post_id}/comments/${comment.id}/edit" class = 'comment_edit_btn fas fa-cog' >
  </a>`
    return html;
  }

  // コメント編集画面のHTMLを作成
  function buildEditHTML(comment){
    var html =
 `<textarea class="edit_comment_area">${comment.comment}</textarea>
  <div class = "edit_box_btns_wrapper">
    <a class="edit_box_btn comment_cancel_btn" href="/posts/${comment.post_id}/comments/${comment.id}">Cancel</a>
    <a class="edit_box_btn comment_delete_btn" href="/posts/${comment.post_id}/comments/${comment.id}" data-confirm="このコメントを削除しますか？" data-method="delete">Delete</a>
    <a class="edit_box_btn comment_update_btn" href="/posts/${comment.post_id}/comments/${comment.id}">Update</a>
  </div>`
    return html;
  }

  // 編集画面を表示
  $(document).on('click', '.comment_edit_btn', function(e){
    e.preventDefault();
    var url = $(this).attr('href');
    $.ajax({
      type: 'GET',
      url: url,
      dataType: 'json'
    })
    .done(function(comment){
      var comment_id = '#comment_' + comment.id
      var edit_html = buildEditHTML(comment);
      $(comment_id).html(edit_html).hide().show(500);
    })
  })

  // 編集をCANCEL
  $(document).on('click', '.comment_cancel_btn',function(e){
    e.preventDefault();
    var url = $(this).attr('href');
    $.ajax({
      type: 'GET',
      url: url,
      dataType: 'json'
    })
    .done(function(comment){
      var comment_id = '#comment_' + comment.id;
      var update_html = buildHTML(comment);
      $(comment_id).html(update_html).hide().show(500);
    })
  })

  // 編集をUPDATE
  $(document).on('click', '.comment_update_btn', function(e){
    e.preventDefault();
    var celectedArea = $(this).parent().parent().find(".edit_comment_area");
    var wordCount = $(celectedArea).val().replace(/\s+/g,'').length;
    if (wordCount != 0){
      var url = $(this).attr('href');
      var updateComment = $(celectedArea).val();
      $.ajax({
        type: 'PUT',
        url: url,
        data: {comment: updateComment},
        dataType: 'json'
      })
      .done(function(comment){
        var comment_id = '#comment_' + comment.id;
        var update_html = buildHTML(comment);
        $(comment_id).html(update_html).hide().show(500);
      })
    } else {
      alert('1文字以上入力してください');
    }
  })
});
