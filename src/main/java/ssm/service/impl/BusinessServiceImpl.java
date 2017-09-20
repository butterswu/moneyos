package ssm.service.impl;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ssm.dao.ParkDao;
import ssm.model.Park;
import ssm.service.BusinessService;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(rollbackFor = Exception.class)
public class BusinessServiceImpl implements BusinessService{
    @Resource
    private ParkDao parkDao;
    public List<Park> getControlledParkList(){
        List<Integer> idList=this.parkDao.getParkIdList();
        List<Integer> controlledIdList=new ArrayList<Integer>();
        Subject subject= SecurityUtils.getSubject();
        if (subject.hasRole("salesman:single_sign")){
            System.out.println("you");

            for (int id:idList){
                if(subject.hasRole("salesman:single:"+id)){
                    controlledIdList.add(id);
                }
            }
        }

        List<Park> parkList =this.parkDao.getParkListByIdList(controlledIdList);
        return parkList;
    }
}
