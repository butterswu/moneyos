package ssm.controller;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import ssm.dao.RecordDao;
import ssm.model.Park;
import ssm.model.Results;
import ssm.model.User;
import ssm.service.BusinessService;
import ssm.service.UtilService;

import javax.annotation.Resource;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping("/business")
public class BusinessController {
    @Resource
    private BusinessService businessService;
    @Resource
    private UtilService utilService;
    @Resource
    private RecordDao recordDao;
    @ResponseBody
    @RequestMapping("allocatePark")
    public String allocatePark(HttpServletRequest request,Model model){

        List<String> addList=this.utilService.getStringListByString(request.getParameter("addPark"));
        List<String> subList=this.utilService.getStringListByString(request.getParameter("cutPark"));
        return this.businessService.allocatePark(addList,subList,request.getParameter("userid"));
    }
    @ResponseBody
    @RequestMapping("getAllocateWindow")
    public String getAllocateWindow(HttpServletRequest request,Model model){
        model.addAttribute("id",request.getParameter("id"));
        this.businessService.getSuperiorParkList(request,model);
        String str=JSON.toJSONString(model);
        System.out.println(model);
        return str;
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

            List<User> userList=this.businessService.getSalesManSubList();
            String str =JSON.toJSONString(userList);
            return str;

    }
    @RequestMapping("/get")
    @ResponseBody
    public String get(HttpServletRequest request,Model model){
        String ur=request.getParameter("url");
        System.out.println(ur);
        StringBuilder json = new StringBuilder();
        try {
            URL urlObject = new URL(ur);
            URLConnection uc = urlObject.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream(),"utf-8"));
            String inputLine = null;
            while ( (inputLine = in.readLine()) != null) {
                json.append(inputLine);
            }
            in.close();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(json);
        return json.toString();
    }
    @RequestMapping("/save")
    @ResponseBody
    public String save(HttpServletRequest request, Model model, Results results){
        System.out.println(results.toString());
        this.recordDao.addFjs(results);
        System.out.println("a");
        return null;
    }
}
