package ssm.controller;

import com.alibaba.fastjson.JSON;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import ssm.model.Park;
import ssm.model.User;
import ssm.service.BusinessService;

import javax.annotation.Resource;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/business")
public class BusinessController {
    @Resource
    private BusinessService businessService;
    @ResponseBody
    @RequestMapping("getAllocateWindow")
    public String getAllocateWindow(HttpServletRequest request,Model model){
        model.addAttribute("id",request.getParameter("id"));
        this.businessService.getSuperiorParkList(request,model);

        return null;
    }
    @RequestMapping("/parkAllocation")
    public String parkAllocation (){
        //返回一个parklist

        return "business-parkAllocation";
    }
    @RequestMapping("/getControlledParkList")
    @ResponseBody
    public String getControlledParkList(HttpServletRequest request, Model model){
        List<Park> parkList=this.businessService.getControlledParkList();
        String str= JSON.toJSONString(parkList);
        return str;
    }
    @RequestMapping("/getSalesmanSubList")
    @ResponseBody
    public String getSalesmanSubList(HttpServletRequest request,Model model){
        Subject subject=SecurityUtils.getSubject();
        if (!subject.hasRole("salesman:manager")){
            return "none";
        }
        else {
            List<User> userList=this.businessService.getSalesManSubList();
            String str =JSON.toJSONString(userList);
            return str;
        }
    }
}
