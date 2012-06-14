// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require_self
//= require lib.js
//= require editor.js
//= require layout.js
//= require events.js
//= require commands.js
//= require cursor.js
//= require input.js
//= require selection.js
//= require parser.js
//= require undomanager.js
//= require_tree .

$(function(){  
  var data_el = $('.post_edit_values')
  if (data_el) {
    var post = new Post(data_el.data())
    console.log(post)
  };
})