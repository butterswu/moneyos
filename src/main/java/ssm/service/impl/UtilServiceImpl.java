package ssm.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ssm.service.UtilService;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(rollbackFor = Exception.class)
public class UtilServiceImpl implements UtilService{
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
}
