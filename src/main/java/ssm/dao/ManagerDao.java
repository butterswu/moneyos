package ssm.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import ssm.model.Manager;
import ssm.model.Record;
import ssm.model.SelectInf;

import java.util.List;

@Repository
public interface ManagerDao {
    /**
     * 使用注解方式传入多个参数，用户产品分页，通过登录用户ID查询
     * @param

     * @return #{startPos},#{pageSize}
     */
    public List<Manager> selectManagerByPage(SelectInf selectInf);

    /**
     * 取得产品数量信息，通过登录用户ID查询

     * @return
     */
    public long getManagerCount(SelectInf selectInf);
    public Manager getManagerById(@Param(value = "id") Integer id);
    public int updateManagerById(@Param(value="manager") Manager manager);
    void updateIntentionByRecord(@Param(value = "record")Record record);
    void newManager(Manager manager);
    List<Manager> getManagerListByComId(Long id);
}
