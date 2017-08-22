package ssm.model;

import java.sql.Date;
import java.util.List;

public class Company {
    private long id;
    private String comName;
    private int comCount;
    private String comNum;
    private String comTargetDate;
    private String comInf;
    private List<Manager> companyManagerList;
    private List<Room> companyRoomList;
    private List<Park> companyParkList;

    @Override
    public String toString() {
        return "Company{" +
                "id=" + id +
                ", comName='" + comName + '\'' +
                ", comCount=" + comCount +
                ", comNum='" + comNum + '\'' +
                ", comTargetDate='" + comTargetDate + '\'' +
                ", comInf='" + comInf + '\'' +
                ", companyManagerList=" + companyManagerList +
                ", companyRoomList=" + companyRoomList +
                ", companyParkList=" + companyParkList +
                '}';
    }

    public List<Park> getCompanyParkList() {
        return companyParkList;
    }

    public void setCompanyParkList(List<Park> companyParkList) {
        this.companyParkList = companyParkList;
    }

    public List<Manager> getCompanyManagerList() {
        return companyManagerList;
    }

    public void setCompanyManagerList(List<Manager> companyManagerList) {
        this.companyManagerList = companyManagerList;
    }

    public List<Room> getCompanyRoomList() {
        return companyRoomList;
    }

    public void setCompanyRoomList(List<Room> companyRoomList) {
        this.companyRoomList = companyRoomList;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getComName() {
        return comName;
    }

    public void setComName(String comName) {
        this.comName = comName;
    }

    public int getComCount() {
        return comCount;
    }

    public void setComCount(int comCount) {
        this.comCount = comCount;
    }

    public String getComNum() {
        return comNum;
    }

    public void setComNum(String comNum) {
        this.comNum = comNum;
    }

    public String getComTargetDate() {
        return comTargetDate;
    }

    public void setComTargetDate(String comTargetDate) {
        this.comTargetDate = comTargetDate;
    }

    public String getComInf() {
        return comInf;
    }

    public void setComInf(String comInf) {
        this.comInf = comInf;
    }

}
