package ssm.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import ssm.model.Park;
import ssm.model.User;

import java.util.List;
import java.util.Set;


@Repository
public interface UserDao {


    User findByUserName(String userName);
    List<User> selectAllUser();
    User login(User user);
    int getUserLevelIdByUserName(String userName);
    User getShiroByUserName(String userName);
    List<User> getSalesmanSubList(String id);
    String getSuperiorId(String id);
    String hasRole(@Param("id") String id,@Param("roleName") String roleName);
    void addRole(@Param("id") String id,@Param("roleName") String roleName);
    String hasRoleData(String roleName);
    void addRoleData(String roleName);
    void cutRole(@Param("id") String id,@Param("roleName")String roleName);
}

