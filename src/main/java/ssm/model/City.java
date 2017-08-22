package ssm.model;

import java.util.List;

public class City {
    private int id;
    private String cityID;
    private String city;
    private String father;
    private List<Area> areaList;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCityID() {
        return cityID;
    }

    public void setCityID(String cityID) {
        this.cityID = cityID;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getFather() {
        return father;
    }

    public void setFather(String father) {
        this.father = father;
    }

    public List<Area> getAreaList() {
        return areaList;
    }

    public void setAreaList(List<Area> areaList) {
        this.areaList = areaList;
    }

    @Override
    public String toString() {
        return "City{" +
                "id=" + id +
                ", cityID='" + cityID + '\'' +
                ", city='" + city + '\'' +
                ", father='" + father + '\'' +
                ", areaList=" + areaList +
                '}';
    }
}
