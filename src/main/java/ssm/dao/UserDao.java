package ssm.dao;

import org.springframework.stereotype.Repository;
import ssm.model.User;

import java.util.List;


@Repository
public interface UserDao {



    List<User> selectAllUser();
    User login(User user);
}

