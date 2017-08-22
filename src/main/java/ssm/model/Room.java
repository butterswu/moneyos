package ssm.model;

public class Room {
    private long id;
    private String roomName;
    private long roomBuildingId;


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public long getRoomBuildingId() {
        return roomBuildingId;
    }

    public void setRoomBuildingId(long roomBuildingId) {
        this.roomBuildingId = roomBuildingId;
    }

    @Override
    public String toString() {
        return "Room{" +
                "id=" + id +
                ", roomName='" + roomName + '\'' +
                ", roomBuildingId=" + roomBuildingId +
                '}';
    }
}
