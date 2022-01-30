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
//= require parsley
//= require countdown.js
//= require_tree .

$( document ).ready(function() {

    gon.timers.forEach(a => {
        let sect_id = a[0]
        let time = a[1]

        $('.section_timer_'+sect_id).countdown({
            date: time,
            day: 'Day',
            days: 'Days',
            hour: 'Hour',
            hours: 'Hours',
            minute: 'Minute',
            minutes: 'Minutes',
            second: 'Second',
            seconds: 'Seconds'
        }, function () {
        });
    });

    $('.bid_submit_but').click(function() {
        let sub_but = $(this);
        let $item_id = $(this).attr('data-itemid');
        let $user_id = $(this).attr('data-userid');
        let $bid = $("#modal_bid_"+$item_id).val();
        let $form = $('#bid_form_'+$item_id);

        $("#modal_message_"+$item_id).addClass('d-none');
        $("#modal_message_"+$item_id).removeClass('alert-danger');
        $("#modal_message_"+$item_id).removeClass('alert-success');
        $form.parsley().validate();

        if($form.parsley().isValid()){

            if (confirm('Are you sure you would like to bid $'+$bid+'?')) {

                $.get("/a/create_a_bid/"+$item_id+"/"+$user_id+"/"+$bid+".json", function(data, status){

                    switch(data.status) {
                        case 'ok':
                            $("#modal_bid_"+$item_id).val(data.valid_bid);
                            $("#modal_min_bid_"+$item_id).html(data.valid_bid);
                            $("#item_bid_show_"+$item_id).html(data.highest);
                            $("#modal_message_"+$item_id).addClass('alert-success');
                            break;
                        case 'closed':
                            sub_but.addClass('d-none');
                            $("#modal_user_actions_"+$item_id).addClass('d-none');
                            $("#modal_bid_"+$item_id).addClass('d-none');
                            $("#bid_pop_"+$item_id).addClass('d-none');
                            $("#modal_message_"+$item_id).addClass('alert-danger');
                            break;
                        case 'outbid':
                            $("#modal_bid_"+$item_id).val(data.valid_bid);
                            $("#modal_min_bid_"+$item_id).html(data.valid_bid);
                            $("#item_bid_show_"+$item_id).html(data.highest);
                            $("#modal_message_"+$item_id).addClass('alert-danger');
                            break;
                        default:
                        // code block
                    };

                    $("#modal_message_"+$item_id).removeClass('d-none');
                    $("#modal_message_"+$item_id).html(data.message);

                });
            };
        };
    });

});