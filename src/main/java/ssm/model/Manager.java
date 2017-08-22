package ssm.model;

import org.omg.CORBA.PRIVATE_MEMBER;

public class Manager {
    private int id;
    private String manName;
    private int manComId;
    private int manIntention;
    private String manTel;
    private String manEmail;
    private Company company;
    private String manComName;

    @Override
    public String toString() {
        return "Manager{" +
                "id=" + id +
                ", manName='" + manName + '\'' +
                ", manComId=" + manComId +
                ", manIntention=" + manIntention +
                ", manTel='" + manTel + '\'' +
                ", manEmail='" + manEmail + '\'' +
                ", company=" + company +
                ", manComName='" + manComName + '\'' +
                '}';
    }

    public String getComName() {
        return manComName;
    }

    public void setComName(String comName) {
        this.manComName = comName;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getManName() {
        return manName;
    }

    public void setManName(String manName) {
        this.manName = manName;
    }

    public int getManComId() {
        return manComId;
    }

    public void setManComId(int manComId) {
        this.manComId = manComId;
    }

    public int getManIntention() {
        return manIntention;
    }

    public void setManIntention(int manIntention) {
        this.manIntention = manIntention;
    }

    public String getManTel() {
        return manTel;
    }

    public void setManTel(String manTel) {
        this.manTel = manTel;
    }

    public String getManEmail() {
        return manEmail;
    }

    public void setManEmail(String manEmail) {
        this.manEmail = manEmail;
    }

}
