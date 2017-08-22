package ssm.service;

import ssm.model.User;

import java.util.List;

public interface UserService {

    List<User> getAllUser();
    User login(User user);

}