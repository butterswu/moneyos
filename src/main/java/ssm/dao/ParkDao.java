package ssm.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import ssm.model.Building;
import ssm.model.Park;
import ssm.model.SelectInf;

import java.util.List;
import java.util.Set;

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
    Set<String> getParkIdSet();
    Set<Park> getParkSetByIdSet(@Param("set") Set<String> set);
    List<Park> getAllNameId();
}
