package ssm.model;

import java.sql.Timestamp;

public class Record {
    private long id;
    private long reManId;
    private int reIntention;
    private String reInf;
    private Timestamp reTime;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getReManId() {
        return reManId;
    }

    public void setReManId(long reManId) {
        this.reManId = reManId;
    }

    public int getReIntention() {
        return reIntention;
    }

    public void setReIntention(int reIntention) {
        this.reIntention = reIntention;
    }

    public String getReInf() {
        return reInf;
    }

    public void setReInf(String reInf) {
        this.reInf = reInf;
    }

    public Timestamp getReTime() {
        return reTime;
    }

    public void setReTime(Timestamp reTime) {
        this.reTime = reTime;
    }

    @Override
    public String toString() {
        return "Record{" +
                "id=" + id +
                ", reManId=" + reManId +
                ", reIntention=" + reIntention +
                ", reInf='" + reInf + '\'' +
                ", reTime=" + reTime +
                '}';
    }
}
