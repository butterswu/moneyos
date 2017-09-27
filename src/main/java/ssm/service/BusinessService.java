package ssm.service;

import org.springframework.ui.Model;
import ssm.model.Manager;
import ssm.model.Park;
import ssm.model.User;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface BusinessService {
    List<Park> getControlledParkList();
    List<User> getSalesManSubList();
    List<Park> getSuperiorParkList(HttpServletRequest request, Model model);
    String  allocatePark(List<String> addList,List<String> subList,String userid);
}
