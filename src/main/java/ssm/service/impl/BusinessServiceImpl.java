package ssm.service.impl;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import ssm.dao.ParkDao;
import ssm.dao.UserDao;
import ssm.model.Park;
import ssm.model.User;
import ssm.service.BusinessService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

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

    public List<Park> getSuperiorParkList(HttpServletRequest request, Model model) {
        String id=this.userDao.getSuperiorId(request.getParameter("id"));
        model.addAttribute("superiorId",id);
        Set<String> supListId=getAvaParkIdSetById(id);
        Set<String> thisListId=getAvaParkIdSetById(request.getParameter("id"));
        Iterator sup=supListId.iterator();
        Iterator this1=thisListId.iterator();
        while (sup.hasNext()){
            String supString=(String)sup.next();
            while (this1.hasNext()){
                String thisSting=(String)this1.next();
                if (supString==thisSting){
                    sup.remove();
                }

            }
            this1=thisListId.iterator();
        }
        try {
            Set<Park> supPark=this.parkDao.getParkSetByIdSet(supListId);
            model.addAttribute("supPark",supPark);
        }catch (Exception e){}
        try {
            Set<Park> thisPark=this.parkDao.getParkSetByIdSet(thisListId);
            model.addAttribute("thisPark",thisPark);
        }catch (Exception e){}
        return null;
    }
    private Set<String> getAvaParkIdSetById(String id){
        Set<String> supListId=new HashSet<String>();
        if(!(this.userDao.hasRole(id,"salesman:single_sign")==null)){
            Set<String> idSet=this.parkDao.getParkIdSet();

            if (this.userDao.hasRole(id,"salesman:single:*")==null){

                for (String id1:idSet){
                    if(!(this.userDao.hasRole(id,"salesman:single:"+id1)==null)){
                        supListId.add(id1);
                    }
                }
            }else{
                supListId.addAll(idSet);
            }
        }
        return supListId;
    }

    public String  allocatePark(List<String> addList, List<String> cutList,String userid) {
        if(this.userDao.hasRole(userid,"salesman:single_sign")==null){
            this.userDao.addRole(userid,"salesman:single_sign");
        }
        for (String add:addList){
            String str="salesman:single:"+add;
            if(this.userDao.hasRoleData(str)==null){
                this.userDao.addRoleData(str);
                this.userDao.addRole(userid,str);
            }else {
                this.userDao.addRole(userid,str);
            }
        }
        for(String cut:cutList){
            String str="salesman:single:"+cut;
            this.userDao.cutRole(userid,str);
        }


        return "SUCCESS";
    }
}
