// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require bootstrap-table.min
//= require bootstrap-table-sticky-header.min
//= require colors
//= require highstock
//= require turbolinks
//= require util
//= require_tree ./_extensions

$("#menu-toggle").click(function(e) {
    e.preventDefault();
    $("#wrapper").toggleClass("toggled");
    if($("#wrapper").hasClass("toggled")) {
        $(this).animate({left: '-=210'}, 300)
        $(this).html('<i class="glyphicon glyphicon-arrow-right"></i>')
        $(this).css('border-radius', '0px 0px 10px 0px');
    } else {
        $(this).animate({left: '+=210'}, 300)
        $(this).html('<i class="glyphicon glyphicon-arrow-left"></i>')
        $(this).css('border-radius', '0px 0px 0px 10px');
    }
});
