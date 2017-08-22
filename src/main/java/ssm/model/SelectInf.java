package ssm.model;

public class SelectInf {
    private int i0;
    private int i1;
    private int i2;
    private int i3;
    private int i4;
    private int startPos;
    private int pageSize;
    private String companyName;
    private String managername;

    @Override
    public String toString() {
        return "SelectInf{" +
                "i0=" + i0 +
                ", i1=" + i1 +
                ", i2=" + i2 +
                ", i3=" + i3 +
                ", i4=" + i4 +
                ", startPos=" + startPos +
                ", pageSize=" + pageSize +
                ", companyName='" + companyName + '\'' +
                ", managername='" + managername + '\'' +
                '}';
    }

    public int getI4() {
        return i4;
    }

    public void setI4(int i4) {
        this.i4 = i4;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getManagername() {
        return managername;
    }

    public void setManagername(String managername) {
        this.managername = managername;
    }



    public int getStartPos() {
        return startPos;
    }

    public void setStartPos(int startPos) {
        this.startPos = startPos;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getI0() {
        return i0;
    }

    public void setI0(int i0) {
        this.i0 = i0;
    }

    public int getI1() {
        return i1;
    }

    public void setI1(int i1) {
        this.i1 = i1;
    }

    public int getI2() {
        return i2;
    }

    public void setI2(int i2) {
        this.i2 = i2;
    }

    public int getI3() {
        return i3;
    }

    public void setI3(int i3) {
        this.i3 = i3;
    }

}
