//控制子菜单出现
$(".icon_c").click(
    function(){
        $(this).toggleClass("icon_c_s").siblings(".icon_c").removeClass("icon_c_s")
        $(this).next(".sub_menu_box").slideToggle(100).siblings(".sub_menu_box").slideUp(100);
    }
);