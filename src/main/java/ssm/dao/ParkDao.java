package ssm.dao;

import org.springframework.stereotype.Repository;
import ssm.model.Building;
import ssm.model.Park;
import ssm.model.SelectInf;

import java.util.List;

@Repository
public interface ParkDao {
    List<Park> getParkByComId(Long id);
    List<Park> getAllByComId(Long id);
    List<Park> getParkByPage(SelectInf selectInf);
    long getParkCount(SelectInf selectInf);
    Park getParkById(int id);
    int getBuildingCountByParkId(int id);
    void newPark(Park park);
    List<Park> getAllPark();
    List<Park> getParkListByCompanyId(long id);
    List<Park> test();
    List<Integer> getParkIdList();
    List<Park> getParkListByIdList(List<Integer> idList);

}
