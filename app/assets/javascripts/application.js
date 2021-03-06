// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// Setup Materialize components
$(document).ready(function(){
  if($('#home-side-bar').length) { // Only do this if this element is present (on home page) b/c it breaks forms.
    $('#home-side-bar').pushpin({top: $('#2-col-wrapper').offset().top,
                                 bottom: $('main').offset().top + $('main').height() - $('#home-side-bar').height()});
    $('.modal-trigger').leanModal();
  }
  $(".dropdown-button").dropdown({hover: false});
  $(".button-collapse").sideNav();
  $('.parallax').parallax();
  $('.collapsible').collapsible({
    accordion : false
  });
  $('select').material_select();
});

