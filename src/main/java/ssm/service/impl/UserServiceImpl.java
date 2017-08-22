package ssm.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ssm.dao.UserDao;
import ssm.model.User;
import ssm.service.UserService;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional(rollbackFor = Exception.class)
public class UserServiceImpl implements UserService {

    @Resource
    private UserDao userDao;



    public List<User> getAllUser(){
        return userDao.selectAllUser();
    }
    public User login(User user){

        return userDao.login(user);
    }

}
