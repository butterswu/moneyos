package ssm.controller;

import com.alibaba.fastjson.JSON;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import ssm.model.Park;
import ssm.service.BusinessService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/business")
public class BusinessController {
    @Resource
    private BusinessService businessService;
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
}
