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
//= require datatables.js
//= require_tree .


$( document ).ready(function() {


    if (window.location.href.indexOf("/admin") > -1) {
        $('#nav_admin').addClass('active');
    }else if (window.location.href.indexOf("/my_items") > -1){
        $('#nav_items').addClass('active');
    }else{
        $('#nav_auctions').addClass('active');
    };


    $('.simple_form.bid').submit(false);

    $('#auction_data, #section_data, #item_data').DataTable();

    $('.load_spinner').click(function() {
        $("#loading_modal").removeClass('d-none');
    });

    gon.timers.forEach(a => {
        let sect_id = a[0]
        let time = a[1]

        $('.section_timer_'+sect_id).countdown({
            date: time,
            offset: -6,
            day: 'Day',
            days: 'Days',
            hour: 'Hour',
            hours: 'Hours',
            minute: 'Minute',
            minutes: 'Minutes',
            second: 'Second',
            seconds: 'Seconds'
        }, function (container) {
            $("#section_card_"+sect_id).addClass('d-none');
        });
    });


    $('.bid_submit_but').click(function() {
        let sub_but = $(this);
        let $item_id = $(this).attr('data-itemid');
        let $user_id = $(this).attr('data-userid');
        let $bid_field = $("#modal_bid_"+$item_id);
        let $bid = $bid_field.val();
        let $form = $('#bid_form_'+$item_id);

        $("#modal_message_"+$item_id).addClass('d-none');
        $("#modal_message_"+$item_id).removeClass('alert-danger');
        $("#modal_message_"+$item_id).removeClass('alert-success');
        $form.parsley().validate();

        if($form.parsley().isValid()){

            if (confirm('Are you sure you would like to bid $'+parseInt($bid).toLocaleString()+'?')) {

                $.get("/a/create_a_bid/"+$item_id+"/"+$user_id+"/"+$bid+".json", function(data, status){
                    switch(data.status) {
                        case 'ok':
                            $("#modal_bid_"+$item_id).val(data.valid_bid);
                            $("#modal_min_bid_"+$item_id).html(data.valid_bid.toLocaleString());
                            $("#item_bid_show_"+$item_id).html(data.highest.toLocaleString());
                            $("#modal_message_"+$item_id).addClass('alert-success');
                            $bid_field.attr('data-parsley-min',data.valid_bid);
                            $("#loading_modal").addClass('d-none');
                            break;
                        case 'closed':
                            sub_but.addClass('d-none');
                            $("#modal_user_actions_"+$item_id).addClass('d-none');
                            $("#modal_bid_"+$item_id).addClass('d-none');
                            $("#bid_pop_"+$item_id).addClass('d-none');
                            $("#modal_message_"+$item_id).addClass('alert-danger');
                            $("#loading_modal").addClass('d-none');
                            break;
                        case 'outbid':
                            $("#modal_bid_"+$item_id).val(data.valid_bid);
                            $("#modal_min_bid_"+$item_id).html(data.valid_bid.toLocaleString());
                            $("#item_bid_show_"+$item_id).html(data.highest.toLocaleString());
                            $("#modal_message_"+$item_id).addClass('alert-danger');
                            $bid_field.attr('data-parsley-min',data.valid_bid);
                            $("#loading_modal").addClass('d-none');
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