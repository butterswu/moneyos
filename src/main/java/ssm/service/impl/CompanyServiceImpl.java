package ssm.service.impl;

import org.apache.commons.beanutils.converters.ShortArrayConverter;
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
import ssm.service.ParkService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.swing.text.html.HTMLDocument;
import java.util.*;

@Service
@Transactional(rollbackFor = Exception.class)
public class CompanyServiceImpl implements CompanyService{
    @Resource
    private CompanyDao companyDao;
    @Resource
    private ManagerDao managerDao;
    @Resource
    private ParkDao parkDao;
    @Resource
    private ParkService parkService;

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
    public Page ajaxgetCompanyByPage(HttpServletRequest request,Model model,SelectInf selectInf){
        Set<String> avaComIdSet=this.companyDao.getCompanyIdSetByParkIdSet(this.parkService.getAvaParkIdSet());
        String pageNow =request.getParameter("pageNow");
        selectInf.setAvaComIdSet(avaComIdSet);
        int totalCount = (int) this.companyDao.getCompanyCount(selectInf);
        if(selectInf.getCompanyName()!="") {
            Set<String> selComIdSet = this.companyDao.getSetByLikeName(selectInf.getCompanyName());
            Set<String> newComSet = new HashSet<String>();
            Iterator<String> sel = selComIdSet.iterator();
            while (sel.hasNext()) {
                String selString = sel.next();
                Iterator<String> ava = avaComIdSet.iterator();
                while (ava.hasNext()) {
                    String avaString = ava.next();
                    if (selString.equals(avaString)) {
                        newComSet.add(selString);
                    }
                }
            }
            selectInf.setAvaComIdSet(newComSet);
            if(selectInf.getAvaComIdSet().size()==0){
                return null;
            }
        }
        Page page = null;
        if(selectInf.getManagername()!="") {
            selectInf.setAvaManIdSet(this.managerDao.getManagerIdSetByLikeName(selectInf.getManagername()));

            if (selectInf.getAvaManIdSet().size()==0){

                return page;
            }
        }

/*        page = new Page(totalCount, Integer.parseInt(pageNow));
        selectInf.setStartPos(page.getStartPos());
        selectInf.setPageSize(page.getPageSize());
        System.out.println(this.companyDao.companyFilter(selectInf));*/
        totalCount=this.companyDao.companyFilterCount(selectInf);
        List<Company> companyList =new ArrayList<Company>();
        if (pageNow != null) {
            page = new Page(totalCount, Integer.parseInt(pageNow));
            selectInf.setStartPos(page.getStartPos());
            selectInf.setPageSize(page.getPageSize());
            companyList = this.companyDao.getComAllBySet(this.companyDao.companyFilter(selectInf));
        } else {
            page = new Page(totalCount, 1);
            selectInf.setStartPos(page.getStartPos());
            selectInf.setPageSize(page.getPageSize());
            companyList = this.companyDao.getComAllBySet(this.companyDao.companyFilter(selectInf));
        }

/*        for(Iterator iterator=companyList.iterator();iterator.hasNext();){
            Company company =(Company)iterator.next();
            company.setCompanyParkList(this.parkDao.getParkListByCompanyId(company.getId()));
        }*/
        page.setList(companyList);
        return page;
    }
    public void newCompany(Company company){
        System.out.println(company.toString());
        this.companyDao.newCompany(company);
        System.out.println(company.toString());
    }
}
