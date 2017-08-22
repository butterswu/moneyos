package ssm.dao;

import org.springframework.stereotype.Repository;
import ssm.model.Building;
import ssm.model.ComRoom;
import ssm.model.Room;

import java.util.List;

@Repository
public interface BuildingDao {
    List<Building> getBuildingListByParkId(int id);
    void newBuilding(Building building);
    List<Room> getRoomsByBuildingId(int id);
    void newRoom(Room room);
    void newCompanyRoom(ComRoom comRoom);
}
