package ssm.service;

import org.springframework.ui.Model;
import ssm.model.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Set;

public interface ParkService {
    Page getParkPage(HttpServletRequest request, Model model);
    void getParkById(HttpServletRequest request,Model model);
    List<Building> getBuildingListByParkId(HttpServletRequest request,Model model);
    void newBuilding(Building building);
    List<Room> getRoomsByBuildingId(HttpServletRequest request,Model model);
    void newRoom(Room room);
    List<Province> getAllProvince();
    List<City> getCityListByProvinceID(HttpServletRequest request,Model model);
    List<Area> getAreaListByCityID(HttpServletRequest request,Model model);
    void newPark(Park park);
    List<Park> getAllPark();
    void newCompanyRoom(HttpServletRequest request,Model model,ComRoom comRoom);
    Set<String> getAvaParkIdSet();
    List<Park> getAllNameId();

}
