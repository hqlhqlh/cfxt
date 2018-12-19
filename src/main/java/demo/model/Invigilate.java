package demo.model;

import java.io.Serializable;
import java.util.Date;

/**
 * invigilate
 * @author 
 */
public class Invigilate implements Serializable {
    private Integer invid;

    private Integer uid;

    private String subject;

    private String teacher1id;

    private String teacher2id;

    private Date testtime;

    private String testplace;

    private String roomnum;

    private static final long serialVersionUID = 1L;

    public Integer getInvid() {
        return invid;
    }

    public void setInvid(Integer invid) {
        this.invid = invid;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getTeacher1id() {
        return teacher1id;
    }

    public void setTeacher1id(String teacher1id) {
        this.teacher1id = teacher1id;
    }

    public String getTeacher2id() {
        return teacher2id;
    }

    public void setTeacher2id(String teacher2id) {
        this.teacher2id = teacher2id;
    }

    public Date getTesttime() {
        return testtime;
    }

    public void setTesttime(Date testtime) {
        this.testtime = testtime;
    }

    public String getTestplace() {
        return testplace;
    }

    public void setTestplace(String testplace) {
        this.testplace = testplace;
    }

    public String getRoomnum() {
        return roomnum;
    }

    public void setRoomnum(String roomnum) {
        this.roomnum = roomnum;
    }
}