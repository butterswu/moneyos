package ssm.dao;

import org.springframework.stereotype.Repository;
import ssm.model.Area;
import ssm.model.City;
import ssm.model.Province;

import java.util.List;


@Repository
public interface LocationDao {
    List<Province> getAllProvince();
    List<City> getCityListByProvinceID(String father);
    List<Area> getAreaListByCityID(String facher);
}
