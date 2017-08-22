package ssm.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import ssm.dao.BuildingDao;
import ssm.dao.CompanyDao;
import ssm.dao.LocationDao;
import ssm.dao.ParkDao;
import ssm.model.*;
import ssm.service.ParkService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(rollbackFor = Exception.class)
public class ParkServiceImpl implements ParkService{
    @Resource
    private ParkDao parkDao;
    @Resource
    private BuildingDao buildingDao;
    @Resource
    private LocationDao locationDao;
    @Resource
    private CompanyDao companyDao;
    public Page getParkPage(HttpServletRequest request, Model model){

        String pageNow = request.getParameter("pageNow");
        SelectInf selectInf = new SelectInf();
        int totalCount =(int) this.parkDao.getParkCount(selectInf);

        Page page = null;
        List<Park> parkList =new ArrayList<Park>();
        if (pageNow != null) {

            page = new Page(totalCount, Integer.parseInt(pageNow));

            selectInf.setStartPos(page.getStartPos());
            selectInf.setPageSize(page.getPageSize());

            parkList = this.parkDao.getParkByPage(selectInf);

        } else {

            page = new Page(totalCount, 1);

            selectInf.setStartPos(page.getStartPos());
            selectInf.setPageSize(page.getPageSize());

            parkList = this.parkDao.getParkByPage(selectInf);

        }

        page.setList(parkList);
        return page;
    }
    public void getParkById(HttpServletRequest request,Model model){
       Park park= this.parkDao.getParkById(Integer.parseInt(request.getParameter("id")));
       park.setBuildingCount(this.parkDao.getBuildingCountByParkId(Integer.parseInt(request.getParameter("id"))));
       park.setParkCompanyList(this.companyDao.getCompanyListByParkId(Integer.parseInt(request.getParameter("id"))));
       model.addAttribute("park",park);

    }
    public List<Building> getBuildingListByParkId(HttpServletRequest request,Model model){
        List<Building> buildingList =this.buildingDao.getBuildingListByParkId(Integer.parseInt(request.getParameter("parkid")));
        return buildingList;
    }
    public void  newBuilding(Building building)
    {
        this.buildingDao.newBuilding(building);
    }

    public List<Room> getRoomsByBuildingId(HttpServletRequest request,Model model) {
       List<Room> roomList= this.buildingDao.getRoomsByBuildingId(Integer.parseInt(request.getParameter("id")));

        return roomList;
    }
    public void newRoom(Room room){
        System.out.println("ff");
        this.buildingDao.newRoom(room);

    }
    public List<Province> getAllProvince(){
        return this.locationDao.getAllProvince();

    }
    public List<City> getCityListByProvinceID(HttpServletRequest request,Model model){
        return this.locationDao.getCityListByProvinceID(request.getParameter("father"));
    }
    public List<Area> getAreaListByCityID(HttpServletRequest request,Model model){
        return this.locationDao.getAreaListByCityID(request.getParameter("father"));
    }
    public void newPark(Park park){
        this.parkDao.newPark(park);
    }

    public List<Park> getAllPark(){
        return this.parkDao.getAllPark();
    }
    public void newCompanyRoom(HttpServletRequest request,Model model,ComRoom comRoom){


        this.buildingDao.newCompanyRoom(comRoom);

            }
}