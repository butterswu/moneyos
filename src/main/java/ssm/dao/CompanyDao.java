package ssm.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import ssm.model.Company;
import ssm.model.SelectInf;

import java.util.List;
import java.util.Set;

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
    Set<String> getCompanyIdSetByParkIdSet(@Param("set") Set<String> set);
    Set<String> getSetByLikeName(@Param("comName") String comName);
    Set<String> companyFilter(@Param("s") SelectInf selectInf);
    int companyFilterCount(@Param("s") SelectInf selectInf);
    List<Company> getComAllBySet(@Param("s") Set<String> s);
}
