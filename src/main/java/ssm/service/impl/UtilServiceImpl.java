package ssm.service.impl;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ssm.dao.ParkDao;
import ssm.model.Park;
import ssm.service.UtilService;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@Transactional(rollbackFor = Exception.class)
public class UtilServiceImpl implements UtilService{
    @Resource
    private ParkDao parkDao;
    public List<String> getStringListByArray(String[] strings) {
        List<String> stringList=new ArrayList<String>();
        for (int i=0;i<strings.length;i++){
            stringList.add(strings[i]);
        }
        return stringList;
    }

    public List<String> getStringListByString(String str) {
        str=str.replace("[","");
        str=str.replace("]","");
        String[] strings=str.split(",");

        return getStringListByArray(strings);
    }
    public Set<String> getAvaParkIdSet(){
        Set<String> idSet=this.parkDao.getParkIdSet();
        Set<String> avaIdSet=new HashSet<String>();
        Subject subject= SecurityUtils.getSubject();

        if (subject.hasRole("salesman:single_sign")){
            if (subject.hasRole("salesman:single:*")){
                avaIdSet.addAll(idSet);
            }else{
                for (String id1:idSet){
                    if(subject.hasRole("salesman:single:"+id1)){
                        avaIdSet.add(id1);
                    }
                }
            }
        }
        return avaIdSet;
    }
}
