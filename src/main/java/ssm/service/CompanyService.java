package ssm.service;

import org.springframework.ui.Model;
import ssm.model.Company;
import ssm.model.Page;
import ssm.model.SelectInf;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface CompanyService {
    void getCompanyById(HttpServletRequest request, Model model);
    void updateCompany(HttpServletRequest request, Model model,Company company);
    List<Company> getAllCompany();
    List<Company> getCompanyByName(Company company);
    Page ajaxgetCompanyByPage(HttpServletRequest request, Model model, SelectInf selectInf);
    void newCompany(Company company);


}
