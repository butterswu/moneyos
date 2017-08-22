package ssm.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import ssm.model.User;
import ssm.service.UserService;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    private Logger log = Logger.getLogger(UserController.class);
    @Resource
    private UserService userService;

    @RequestMapping("/showUser")
    public String showUser(HttpServletRequest request, Model model){
        log.info("查询所有用户信息");
        List<User> userList = userService.getAllUser();
        model.addAttribute("userList",userList);
        return "showUser";
    }
    @RequestMapping("/loginpage")
    public  String loginpage(HttpServletRequest request, Model model){
        log.info("进入登陆界面");
        return "lgin";
    }
    @RequestMapping("/login")
    public ModelAndView login(User user){
       log.info("点击登陆");
        user = userService.login(user);
        if (user==null){

            ModelAndView mav = new ModelAndView("login");
            return mav;
        }
        else {

            ModelAndView mav = new ModelAndView("index");
                    return mav;
        }


    }
}
