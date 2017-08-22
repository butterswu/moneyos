package ssm.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import ssm.dao.CompanyDao;
import ssm.dao.ManagerDao;
import ssm.dao.RecordDao;
import ssm.model.*;
import ssm.service.ManagerService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Service
@Transactional(rollbackFor = Exception.class)
public class ManagerServiceImpl implements ManagerService{
    @Resource
    private ManagerDao managerDao;
    @Resource
    private RecordDao recordDao;
    @Resource
    private CompanyDao companyDao;


    public void showManagerByPage(HttpServletRequest request, Model model) {
        String pageNow = request.getParameter("pageNow");
        SelectInf selectInf = new SelectInf();

        Page page = null;

        List<Manager> managerList = new ArrayList<Manager>();

        int totalCount = (int) managerDao.getManagerCount(selectInf);

        if (pageNow != null) {
            page = new Page(totalCount, Integer.parseInt(pageNow));
            selectInf.setStartPos(page.getStartPos());
            selectInf.setPageSize(page.getPageSize());
            managerList = this.managerDao.selectManagerByPage(selectInf);
        } else {
            page = new Page(totalCount, 1);
            selectInf.setStartPos(page.getStartPos());
            selectInf.setPageSize(page.getPageSize());
            managerList = this.managerDao.selectManagerByPage(selectInf);
        }

        for(Manager manager : managerList){
            Company company=companyDao.getCompanyById(manager.getManComId());

            manager.setCompany(company);


        }


        model.addAttribute("managerList", managerList);
        model.addAttribute("page", page);
    }

    public void getManagerById(HttpServletRequest request, Model model) {

        String id =(request.getParameter("id")==null)?(String) request.getAttribute("id"):request.getParameter("id");

        System.out.println("aaaa"+id);
        Manager manager=this.managerDao.getManagerById(Integer.parseInt(id));
        System.out.println("收到");
        List<Record> recordList = this.recordDao.getRecordByManId(Integer.parseInt(id));
        Company company=companyDao.getCompanyById(manager.getManComId());

        manager.setCompany(company);
        System.out.println(manager.getCompany().getComName());

        model.addAttribute("manager",manager);
        model.addAttribute("recordList",recordList);



    }
    public void updateManagerById(HttpServletRequest request, Model model,Manager manager){
        this.managerDao.updateManagerById(manager);

    }

    public void newRecord(HttpServletRequest request, Model model, Record record) {
        System.out.println(record.toString());
        this.recordDao.newRecord(record);
        this.managerDao.updateIntentionByRecord(record);

    }
    public void newManager(HttpServletRequest request, Model model,Manager manager){
        this.managerDao.newManager(manager);
    }
    public Page ajaxgetManagerByPage(HttpServletRequest request ,Model model){
        String pageNow =request.getParameter("pageNow");
        SelectInf selectInf =new SelectInf();
        if (request.getParameter("manager")!=""){
            selectInf.setManagername(request.getParameter("manager"));
        }

        if (request.getParameter("company")!="") {
            selectInf.setCompanyName(request.getParameter("company"));
        }

        if(request.getParameter("i0").equals("true")){

            selectInf.setI0(1);
        }else {selectInf.setI0(0);}

        if(request.getParameter("i1").equals("true")){
            selectInf.setI1(1);
        }else {selectInf.setI1(0);}
        if(request.getParameter("i2").equals("true")){
            selectInf.setI2(1);
        }else {selectInf.setI2(0);}
        if(request.getParameter("i3").equals("true")){
            selectInf.setI3(1);
        }else {selectInf.setI3(0);}
        if(request.getParameter("i4").equals("true")){
            selectInf.setI4(1);
        }else {selectInf.setI4(0);}

        Page page = null;

        List<Manager> managerList = new ArrayList<Manager>();

        int totalCount = (int) managerDao.getManagerCount(selectInf);

        if (pageNow != null) {
            page = new Page(totalCount, Integer.parseInt(pageNow));
            selectInf.setStartPos(page.getStartPos());
            selectInf.setPageSize(page.getPageSize());
            managerList = this.managerDao.selectManagerByPage(selectInf);
        } else {
            page = new Page(totalCount, 1);
            selectInf.setStartPos(page.getStartPos());
            selectInf.setPageSize(page.getPageSize());
            managerList = this.managerDao.selectManagerByPage(selectInf);
        }
        page.setList(managerList);
        return page;
    }



}
