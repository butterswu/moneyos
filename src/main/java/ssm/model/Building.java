package ssm.model;

import java.util.List;

public class Building {
    private long id;
    private String buildingName;
    private int buildingType;
    private long buildingParkId;
    private List<Room> buildingRoomList;

    public List<Room> getBuildingRoomList() {
        return buildingRoomList;
    }

    public void setBuildingRoomList(List<Room> buildingRoomList) {
        this.buildingRoomList = buildingRoomList;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getBuildingName() {
        return buildingName;
    }

    public void setBuildingName(String buildingName) {
        this.buildingName = buildingName;
    }

    public int getBuildingType() {
        return buildingType;
    }

    public void setBuildingType(int buildingType) {
        this.buildingType = buildingType;
    }

    public long getBuildingParkId() {
        return buildingParkId;
    }

    public void setBuildingParkId(long buildingParkId) {
        this.buildingParkId = buildingParkId;
    }

    @Override
    public String toString() {
        return "Building{" +
                "id=" + id +
                ", buildingName='" + buildingName + '\'' +
                ", buildingType=" + buildingType +
                ", buildingParkId=" + buildingParkId +
                ", buildingRoomList=" + buildingRoomList +
                '}';
    }
}
