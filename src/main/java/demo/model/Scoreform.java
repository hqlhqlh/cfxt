package demo.model;

import java.io.Serializable;
import java.util.Date;

/**
 * scoreform
 * @author 
 */
public class Scoreform implements Serializable {
    private Integer scoreid;

    private String username;

    private String idcard;

    private String subject;

    private Date testtime;

    private Double score;

    /**
     * 是否合格
     */
    private String status;

    private static final long serialVersionUID = 1L;

    public Integer getScoreid() {
        return scoreid;
    }

    public void setScoreid(Integer scoreid) {
        this.scoreid = scoreid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public Date getTesttime() {
        return testtime;
    }

    public void setTesttime(Date testtime) {
        this.testtime = testtime;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}