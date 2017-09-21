package ssm.service;

import ssm.model.Park;
import ssm.model.User;

import java.util.List;

public interface BusinessService {
    List<Park> getControlledParkList();
    List<User> getSalesManSubList();
}
