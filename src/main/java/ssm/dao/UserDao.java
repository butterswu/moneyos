package ssm.dao;

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
    List<String> hasRole(String role,String id);

}

