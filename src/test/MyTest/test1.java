package MyTest;

import org.junit.Test;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import org.springframework.beans.factory.annotation.Autowired;
import ssm.dao.ParkDao;
import ssm.dao.UserDao;
import ssm.model.Park;
import ssm.model.User;
import ssm.service.UserService;

import javax.annotation.Resource;
import java.util.List;


public class test1 {
    @Resource
    private ParkDao parkDao;

    @Test
    public void getShiro(){

        try {
            List<Park> parkList=this.parkDao.getAllPark();
            System.out.println(parkList);
        }catch (Exception e){
            System.out.println("shit");
        };



    }
}
