// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery
//= require jquery_ujs
/*global $*/
$(window).on('scroll', function(){

  var scrollTop = $(window).scrollTop();
  var bgPosition = scrollTop / 2; //スクロール後のポジションを指定（値を大きくすると移動距離が小さくなる）

  if(bgPosition){
    $('#top-image').css('background-position', 'center top -'+ bgPosition + 'px');
    $('#notifications').css('background-position', 'center top -'+ bgPosition + 'px');
    $('.novel_index').css('background-position', 'center top -'+ bgPosition + 'px');
  }
});

document.addEventListener("turbolinks:load", function () {
  $('turbolinks:load',function(){
    $('.markdown_text').each(function() {
      $(this).html(
        $(this).html()
          .replace(/《《(.+?)》》/g, '<strong>$1</strong>')
          /* 半角または全角の縦棒以降の文字をベーステキスト、括弧内の文字をルビテキストとします。 */
          .replace(/[\|｜](.+?)《(.+?)》/g, '<ruby>$1<rt>$2</rt></ruby>')
          .replace(/[\|｜](.+?)（(.+?)）/g, '<ruby>$1<rt>$2</rt></ruby>')
          .replace(/[\|｜](.+?)\((.+?)\)/g, '<ruby>$1<rt>$2</rt></ruby>')
          /* 漢字の連続の後に括弧が存在した場合、一連の漢字をベーステキスト、括弧内の文字をルビテキストとします。 */
          .replace(/([一-龠]+)《(.+?)》/g, '<ruby>$1<rt>$2</rt></ruby>')
          /* ただし丸括弧内の文字はひらがなかカタカナのみを指定できます。 */
          .replace(/([一-龠]+)（([ぁ-んァ-ヶー]+?)）/g, '<ruby>$1<rt>$2</rt></ruby>')
          .replace(/([一-龠]+)\(([ぁ-んァ-ヶー]+?)\)/g, '<ruby>$1<rt>$2</rt></ruby>')
          /* 括弧を括弧のまま表示したい場合は、括弧の直前に縦棒を入力します。 */
          .replace(/[\|｜]《(.+?)》/g, '《$1》')
          .replace(/[\|｜]（(.+?)）/g, '（$1）')
          .replace(/[\|｜]\((.+?)\)/g, '($1)')
      );
    });
  });
});

