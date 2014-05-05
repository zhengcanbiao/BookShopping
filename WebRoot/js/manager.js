// JavaScript Document
$(document).ready(function() {
//-----------------------------------------------------------------------
/*    var css_active = "user_selected"
    var icon_white = "#fff"
    var icon_gray = "gray"

    var book_url = window.location.href

    var str = /booking_msg/

    if(str.test(book_url)) {
        $('.bt_booking_room span').removeClass(css_active);
        $('.bt_select span').addClass(css_active);

        $(".bt_booking_room i").css("color", icon_gray);
        $(".bt_select i").css("color", icon_white);
    }*/
    
    $("#dingdang_paixu option").bind('click', function() {
        $(".selected-status").text($(this).text())
    })

})
