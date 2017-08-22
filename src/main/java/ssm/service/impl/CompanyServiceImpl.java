package ssm.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import ssm.dao.CompanyDao;
import ssm.dao.ManagerDao;
import ssm.dao.ParkDao;
import ssm.model.Company;
import ssm.model.Manager;
import ssm.model.Page;
import ssm.model.SelectInf;
import ssm.service.CompanyService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.swing.text.html.HTMLDocument;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Service
@Transactional(rollbackFor = Exception.class)
public class CompanyServiceImpl implements CompanyService{
    @Resource
    private CompanyDao companyDao;
    @Resource
    private ManagerDao managerDao;
    @Resource
    private ParkDao parkDao;

    public void getCompanyById(HttpServletRequest request, Model model){
        long id = Long.parseLong(request.getParameter("id"));
        Company company=this.companyDao.getCompanyById(id);

        company.setCompanyManagerList(managerDao.getManagerListByComId(id));
        company.setCompanyParkList(parkDao.getAllByComId(id));

        model.addAttribute(company);
    }
    public void updateCompany(HttpServletRequest request, Model model,Company company){
        System.out.println(company.getComName());
        this.companyDao.updateCompany(company);
    }
    public List<Company> getAllCompany(){

        List<Company>  companyList= new ArrayList<Company>();
        System.out.println("ser");
                companyList=this.companyDao.getAllCompany();
        System.out.println("ser");


        return this.companyDao.getAllCompany();
    }
    public List<Company> getCompanyByName(Company company){
        return this.companyDao.getCompanyByName(company);
    }
    public Page ajaxgetCompanyByPage(HttpServletRequest request,Model model){

        String pageNow =request.getParameter("pageNow");
        SelectInf selectInf = new SelectInf();

        int totalCount = (int) this.companyDao.getCompanyCount(selectInf);

        Page page = null;
        List<Company> companyList =new ArrayList<Company>();
        if (pageNow != null) {
            page = new Page(totalCount, Integer.parseInt(pageNow));
            selectInf.setStartPos(page.getStartPos());
            selectInf.setPageSize(page.getPageSize());
            companyList = this.companyDao.getCompanyList(selectInf);
        } else {

            page = new Page(totalCount, 1);
            selectInf.setStartPos(page.getStartPos());
            selectInf.setPageSize(page.getPageSize());
            companyList = this.companyDao.getCompanyList(selectInf);
        }

        for(Iterator iterator=companyList.iterator();iterator.hasNext();){
            Company company =(Company)iterator.next();
            company.setCompanyParkList(this.parkDao.getParkListByCompanyId(company.getId()));
        }
        System.out.println(companyList.toString());
        page.setList(companyList);



        return page;
    }
    public void newCompany(Company company){
        System.out.println(company.toString());
        this.companyDao.newCompany(company);
        System.out.println(company.toString());
    }
}
