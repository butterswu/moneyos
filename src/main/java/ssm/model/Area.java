package ssm.model;

public class Area {
    private int id;
    private String areaID;
    private String area;
    private String father;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAreaID() {
        return areaID;
    }

    public void setAreaID(String areaID) {
        this.areaID = areaID;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getFather() {
        return father;
    }

    public void setFather(String father) {
        this.father = father;
    }

    @Override
    public String toString() {
        return "Area{" +
                "id=" + id +
                ", areaID='" + areaID + '\'' +
                ", area='" + area + '\'' +
                ", father='" + father + '\'' +
                '}';
    }
}
