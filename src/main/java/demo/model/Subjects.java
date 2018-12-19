package demo.model;

import java.io.Serializable;
import java.util.Date;

/**
 * subjects
 * @author 
 */
public class Subjects implements Serializable {
    private Integer sid;

    private String subject;

    private Date testtime;

    private Integer price;

    private String testplace;

    private static final long serialVersionUID = 1L;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
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

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public String getTestplace() {
        return testplace;
    }

    public void setTestplace(String testplace) {
        this.testplace = testplace;
    }
}