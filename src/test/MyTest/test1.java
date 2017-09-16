package MyTest;

import org.junit.Test;
import ssm.dao.UserDao;
import ssm.model.User;

import java.util.List;


public class test1 implements UserDao{
    @Test
    public void print(){
        System.out.println("test");
    }
    @Test
    public User findByUserName(String userName) {
        System.out.println("");
        return null;
    }

    public List<User> selectAllUser() {
        return null;
    }

    public User login(User user) {
        return null;
    }

    public int getUserLevelIdByUserName(String userName) {
        return 0;
    }
}
