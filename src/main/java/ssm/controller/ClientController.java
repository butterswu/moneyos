package ssm.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import netscape.javascript.JSObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import ssm.model.Company;
import ssm.model.Manager;
import ssm.model.Page;
import ssm.model.Record;

import ssm.service.CompanyService;
import ssm.service.ManagerService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.List;

@Controller
@RequestMapping("/client")
public class ClientController {
    @Resource
    private ManagerService managerService ;
    @Resource
    private CompanyService companyService;

    @RequestMapping("/manager")
    public ModelAndView manager(){

        ModelAndView mav = new ModelAndView("/client");
        return mav;
    }
    @RequestMapping("/managerlist")
    public String showManagerByPage(HttpServletRequest request, Model model) {








        return "client";
    }
    @RequestMapping("/managerinf")
    public String showManagerInf(HttpServletRequest request, Model model){

        this.managerService.getManagerById(request,model);

        return "client-manager";

    }
    @RequestMapping("/updateManager")
    public String updateManager(HttpServletRequest request, Model model,Manager manager){


        this.managerService.updateManagerById(request,model,manager);
        return ("forward:/client/managerinf");

    }

    @RequestMapping("/newRecord")
    public String newRecord(HttpServletRequest request, Model model, Record record){

        this.managerService.newRecord(request,model,record);
        return ("forward:/client/managerinf");
    }
    @RequestMapping("/companyinf")
    public String getCompanyById(HttpServletRequest request, Model model)
    {   System.out.println("公司信息");
        this.companyService.getCompanyById(request,model);
        return ("client-company");
    }
    @RequestMapping("/updatecompany")
    public String updateCompany(HttpServletRequest request, Model model,Company company){

        System.out.println(company.getComTargetDate());


        this.companyService.updateCompany(request,model,company);
        return ("forward:/client/companyinf");
    }
    @RequestMapping("/newmanager")
    public  String newManager(HttpServletRequest request, Model model,Manager manager){
        System.out.println(manager.toString());
        this.managerService.newManager(request,model,manager);
        return ("forward:/client/managerlist");
    }
    @RequestMapping("/ajaxupdatemanager")
    @ResponseBody
    public JSONObject ajaxupdateManager (HttpServletRequest request,Model model,Manager manager){
        JSONObject jsonObject = new JSONObject();
        this.managerService.updateManagerById(request,model,manager);

        return jsonObject;
    }
    @RequestMapping("/ajaxnewrecord")
    @ResponseBody
    public  JSONObject ajaxnewRecord (HttpServletRequest request,Model model,Record record){
        JSONObject jsonObject = new JSONObject();
        this.managerService.newRecord(request,model,record);
        return jsonObject;
    }
    @RequestMapping("/ajaxupdatecompany")
    @ResponseBody
    public JSONArray ajaxupdateCompany(HttpServletRequest request, Model model, Company company){
        JSONArray jsonArray = new JSONArray();
        this.companyService.updateCompany(request,model,company);
        return  jsonArray;
    }
    @RequestMapping("/ajaxnewmanager")
    @ResponseBody
    public JSONObject ajaxnewManager(HttpServletRequest request,Model model ,Manager manager){
        JSONObject jsonObject = new JSONObject();

        this.managerService.newManager(request,model,manager);
        return  jsonObject;
    }
    @RequestMapping("/ajaxgetcompanybyname")
    @ResponseBody
    public  String  ajaxgetCompanyByName(HttpServletRequest request,Model model,Company company){

        List<Company> companyList= this.companyService.getCompanyByName(company);

        String str =JSON.toJSONString(companyList);
        System.out.println(str);


        return str;
    }
    @RequestMapping("/ajaxgetmanager")
    @ResponseBody
    public  String  ajaxgetManager(HttpServletRequest request,Model model){

        Page page=this.managerService.ajaxgetManagerByPage(request,model);
        String str =JSON.toJSONString(page);
        return str;
    }
    @RequestMapping("/companyList")
    public String companyList(HttpServletRequest request,Model model){
        return "client2";
    }
    @RequestMapping("/ajaxgetCompanyByPage")
    @ResponseBody
    public  String ajaxgetCompanyByPage(HttpServletRequest request,Model model){

        Page page=this.companyService.ajaxgetCompanyByPage(request,model);
        System.out.println(page);
        String str =JSON.toJSONString(page);
        return str;
    }
    @RequestMapping("/newcompany")
    @ResponseBody
    public String newCompany(HttpServletRequest request,Model model,Company company){


        this.companyService.newCompany(company);

        return "success";
    }
}
