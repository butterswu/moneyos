package ssm.service.impl;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ssm.dao.ParkDao;
import ssm.dao.UserDao;
import ssm.model.Park;
import ssm.model.User;
import ssm.service.BusinessService;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(rollbackFor = Exception.class)
public class BusinessServiceImpl implements BusinessService{
    @Resource
    private ParkDao parkDao;
    @Resource
    private UserDao userDao;
    public List<Park> getControlledParkList(){
        List<Integer> idList=this.parkDao.getParkIdList();
        List<Integer> controlledIdList=new ArrayList<Integer>();
        Subject subject= SecurityUtils.getSubject();

        if (subject.hasRole("salesman:single_sign")){
            if (subject.hasRole("salesman:single:*")){
                controlledIdList.addAll(idList);
            }else{
                for (int id:idList){
                    if(subject.hasRole("salesman:single:"+id)){
                        controlledIdList.add(id);
                    }
                }
            }


        }

        List<Park> parkList =this.parkDao.getParkListByIdList(controlledIdList);
        return parkList;
    }

    public List<User> getSalesManSubList() {
        Subject subject=SecurityUtils.getSubject();
        Session session=subject.getSession();
        List<User> userList=this.userDao.getSalesmanSubList(session.getAttribute("user_id").toString());
        for (User user:userList){
            user=getAllSalesSubList(user);
        }
        return userList;
    }
    private User getAllSalesSubList(User user){
        List<User> userList=this.userDao.getSalesmanSubList(Integer.toString(user.getId()));
        if (userList!=null){
            user.setSubordinate(userList);
            for (User user1:userList){
                user1=getAllSalesSubList(user1);
            }
        }
        return user;
    }
}
