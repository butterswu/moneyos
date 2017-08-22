package ssm.dao;

import org.springframework.stereotype.Repository;
import ssm.model.Company;
import ssm.model.SelectInf;

import java.util.List;

@Repository
public interface CompanyDao {
    Company getCompanyById(long id);
    void updateCompany(Company company);
    List<Company> getAllCompany();
    List<Company> getCompanyByName(Company company);
    long getCompanyCount(SelectInf selectInf);
    List<Company> getCompanyList(SelectInf selectInf);
    void newCompany(Company company);
    List<Company> getCompanyListByParkId(int id);
}
