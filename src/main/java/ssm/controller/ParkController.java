package ssm.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import ssm.model.*;
import ssm.service.ParkService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/park")
public class ParkController {
    @Resource
    private ParkService parkService;
    @RequestMapping("/parklist")
    public String parkList(HttpServletRequest request, Model model){


        return "park";
    }
    @RequestMapping("/parkinf")
    public String parkInf(HttpServletRequest request,Model model){
        System.out.println(request.getParameter("id"));
        this.parkService.getParkById(request,model);

        return "park-parkinf";
    }
    @RequestMapping("/ajaxParkList")
    @ResponseBody
    public String ajaxParkList(HttpServletRequest request,Model model){
        Page page = this.parkService.getParkPage(request,model);
        String str = JSON.toJSONString(page);
        System.out.println(str);
        return str;
    }
    @RequestMapping("/ajaxGetBuildingList")
    @ResponseBody
    public  String ajaxGetBuildingList(HttpServletRequest request,Model model){
        List<Building> buildingList= this.parkService.getBuildingListByParkId(request,model);
        String str =JSON.toJSONString(buildingList);
        return str;
    }
    @RequestMapping("/ajaxNewbuilding")
    @ResponseBody
    public JSONObject newBuilding(HttpServletRequest request, Model model, Building building){

        JSONObject jsonObject = new JSONObject();

        this.parkService.newBuilding(building);
        return jsonObject;
    }
    @RequestMapping("/ajaxGetRooms")
    @ResponseBody
    public String getRooms(HttpServletRequest request,Model model){
        System.out.println(request.getParameter("id"));
        List<Room> roomList=this.parkService.getRoomsByBuildingId(request,model);
        String str=JSON.toJSONString(roomList);
        System.out.println(str);
        return str;
    }
    @RequestMapping("/ajaxNewRoom")
    @ResponseBody
    public String newRoom(HttpServletRequest request,Model model,Room room){

        this.parkService.newRoom(room);
        return "success";
    }
    @RequestMapping("/ajaxGetAllProvince")
    @ResponseBody
    public String getAllProvince(HttpServletRequest request,Model model){
        List<Province> provinceList=this.parkService.getAllProvince();
        return JSON.toJSONString(provinceList);
    }
    @RequestMapping("/ajaxGetCityListByProvinceID")
    @ResponseBody
    public String getCityListByProvinceID(HttpServletRequest request,Model model){
        List<City> cityList =this.parkService.getCityListByProvinceID(request,model);
        return  JSON.toJSONString(cityList);
    }
    @RequestMapping("/ajaxGetAreaListByCityID")
    @ResponseBody
    public  String getAreaListByCityID(HttpServletRequest request,Model model){

        List<Area> areaList =this.parkService.getAreaListByCityID(request,model);

        return JSON.toJSONString(areaList);
    }
    @RequestMapping("/ajaxNewPark")
    @ResponseBody
    public  String newPark(HttpServletRequest request,Model model,Park park){
        this.parkService.newPark(park);
        return "success";

    }
    @RequestMapping("/ajaxGetAllPark")
    @ResponseBody
    public String getAllPark(HttpServletRequest request,Model model){
        List<Park> parkList=this.parkService.getAllPark();
        return JSON.toJSONString(parkList);
    }
    @RequestMapping("/ajaxGetBuildingListByParkId")
    @ResponseBody
    public String getBuildingListByParkId(HttpServletRequest request,Model model){
        List<Building> buildingList=this.parkService.getBuildingListByParkId(request,model);
        return JSON.toJSONString(buildingList);
    }
    @RequestMapping("/ajaxGetRoomListByBuildingId")
    @ResponseBody
    public String getRoomListByBuildingList(HttpServletRequest request,Model model){

        List<Room> roomList=this.parkService.getRoomsByBuildingId(request,model);
        return JSON.toJSONString(roomList);
    }
    @RequestMapping("/ajaxNewCompanyRoom")
    @ResponseBody
    public String newCompanyRoom(HttpServletRequest request,Model model,ComRoom comRoom){
        this.parkService.newCompanyRoom(request,model,comRoom);
        return "success";
    }
    @RequestMapping("/getAllNameId")
    @ResponseBody
    public String getAllNameId(){
        return JSON.toJSONString(this.parkService.getAllNameId());
    }

}
