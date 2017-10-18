//控制子菜单出现
$(".icon_c").click(
    function(){
        $(this).toggleClass("icon_c_s").siblings(".icon_c").removeClass("icon_c_s");
        $(this).next(".sub_menu_box").slideToggle(100).siblings(".sub_menu_box").slideUp(100);
    }
);
//控制检索选项颜色
$(".search_first_b_a input").click(
    function(){
        $(".search_first_b_a").toggleClass("search_first_b_s");
    }
);
$(".search_first_b_b input").click(
    function(){
        $(".search_first_b_b").toggleClass("search_first_b_s");
    }
);

$(".bt_search_second_b_a input").click(
    function(){
        $(".bt_search_second_b_a").toggleClass("bt_search_second_b_s");
    }
);
$(".bt_search_second_b_b input").click(
    function(){
        $(".bt_search_second_b_b").toggleClass("bt_search_second_b_s");
    }
);
$(".bt_search_second_b_c input").click(
    function(){
        $(".bt_search_second_b_c").toggleClass("bt_search_second_b_s");
    }
);
//添加部分
$(".order_state_a").click(
    function(){
        $(".order_state_a").addClass("order_state_s");
        $(".order_state_b").removeClass("order_state_s");
    }
);
$(".order_state_b").click(
    function(){
        $(".order_state_b").addClass("order_state_s");
        $(".order_state_a").removeClass("order_state_s");
    }
);
$(".order_state_a input").click(
    function(){
        $(".order_state_a").addClass("order_state_s");
        $(".order_state_b").removeClass("order_state_s");
    }
);
$(".order_level_a input").click(
    function(){
        $(".order_level_a").addClass("order_level_s");
        $(".order_level_b").removeClass("order_level_s");
        $(".order_level_c").removeClass("order_level_s");
    }
);
$(".order_level_b input").click(
    function(){
        $(".order_level_b").addClass("order_level_s");
        $(".order_level_a").removeClass("order_level_s");
        $(".order_level_c").removeClass("order_level_s");
    }
);
$(".order_level_c input").click(
    function(){
        $(".order_level_c").addClass("order_level_s");
        $(".order_level_a").removeClass("order_level_s");
        $(".order_level_b").removeClass("order_level_s");
    }
);
//控制添加窗口
$(".add_bt").click(
    function(){
        $(".add_data_box").fadeIn();
        $(".keep").show();
    }
)
$(".close_add_data").click(
    function(){
        $(".add_data_box").hide();
        $(".keep").fadeOut();
    }
)
//控制子元素滚动页面不滚动
$.fn.scrollUnique = function() {
    return $(".main_add_data").each(function() {
        var eventType = 'mousewheel';
        // 火狐是DOMMouseScroll事件
        if (document.mozHidden !== undefined) {
            eventType = 'DOMMouseScroll';
        }
        $(".main_add_data").on(eventType, function(event) {
            var scrollTop = this.scrollTop,
                scrollHeight = this.scrollHeight,
                height = this.clientHeight;
            var delta = (event.originalEvent.wheelDelta) ? event.originalEvent.wheelDelta : -(event.originalEvent.detail || 0);
            if ((delta > 0 && scrollTop <= delta) || (delta < 0 && scrollHeight - height - scrollTop <= -1 * delta)) {
                this.scrollTop = delta > 0? 0: scrollHeight;
                // 向上滚 || 向下滚
                event.preventDefault();
            }
        });
    });
};
$().scrollUnique();
