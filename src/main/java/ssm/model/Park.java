package ssm.model;

import java.util.List;

public class Park {
    private long id;

    private String parkName;
    private String parkLocation;
    private String parkAreaID;
    private String area;
    private List<Company> parkCompanyList;

    public List<Company> getParkCompanyList() {
        return parkCompanyList;
    }

    public void setParkCompanyList(List<Company> parkCompanyList) {
        this.parkCompanyList = parkCompanyList;
    }

    public String getArea() {
        return area;
    }

    @Override
    public String toString() {
        return "Park{" +
                "id=" + id +
                ", parkName='" + parkName + '\'' +
                ", parkLocation='" + parkLocation + '\'' +
                ", parkAreaID='" + parkAreaID + '\'' +
                ", area='" + area + '\'' +
                ", parkCompanyList=" + parkCompanyList +
                ", city='" + city + '\'' +
                ", province='" + province + '\'' +
                ", parkBuildingList=" + parkBuildingList +
                ", buildingCount=" + buildingCount +
                '}';
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    private String city;
    private String province;

    public String getParkAreaID() {
        return parkAreaID;
    }

    public void setParkAreaID(String parkAreaID) {
        this.parkAreaID = parkAreaID;
    }

    private List<Building> parkBuildingList;
    private int buildingCount;

    public int getBuildingCount() {
        return buildingCount;
    }

    public void setBuildingCount(int buildingCount) {
        this.buildingCount = buildingCount;
    }

    public List<Building> getParkBuildingList() {
        return parkBuildingList;
    }

    public void setParkBuildingList(List<Building> parkBuildingList) {
        this.parkBuildingList = parkBuildingList;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }



    public String getParkName() {
        return parkName;
    }

    public void setParkName(String parkName) {
        this.parkName = parkName;
    }

    public String getParkLocation() {
        return parkLocation;
    }

    public void setParkLocation(String parkLocation) {
        this.parkLocation = parkLocation;
    }
}
