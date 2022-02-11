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
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require countdown_timer.js



$( document ).ready(function() {

function change_bc(el){
    if(el.parent().hasClass("pink-back")){
        el.parent().removeClass("pink-back").addClass("red-back");

    }else{
        el.parent().removeClass("red-back").addClass("pink-back");
    }

}

function final_check(){
    var trigger = $(".hide").length;

    if(trigger == 4){
        $(".gn_message").addClass("gn-big");
    }
}

$(".timer").each(function(){
    var clock = $(this).find(".clock");
    var endTime = clock.data("endtime");


    clock.countdown(endTime, function(event) {
        var timer = $(this);
        var secs = (event.offset.hours * 60 + event.offset.minutes)*60 + event.offset.seconds;

        if(secs == 0){
            $(this).parent().removeClass("big small").addClass("hide");
            final_check();
        }else if(secs <= 300){
            timer.parent().removeClass("small").addClass("big");
            change_bc(timer);
        }

        $(this).html(event.strftime('%H:%M:%S'));

    }).on('finish.countdown', function(){
        timer.parent().removeClass("big small").addClass("hide");
        final_check();
    });

});

});