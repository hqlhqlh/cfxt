package demo.model;

import java.io.Serializable;
import java.util.Date;

/**
 * sign
 * @author 
 */
public class Sign implements Serializable {
    private Integer signid;

    private String idcard;

    private String subject;

    private Date testtime;

    private String testplace;

    private Date signtime;

    private Integer price;

    private String status;

    private static final long serialVersionUID = 1L;

    public Integer getSignid() {
        return signid;
    }

    public void setSignid(Integer signid) {
        this.signid = signid;
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

    public String getTestplace() {
        return testplace;
    }

    public void setTestplace(String testplace) {
        this.testplace = testplace;
    }

    public Date getSigntime() {
        return signtime;
    }

    public void setSigntime(Date signtime) {
        this.signtime = signtime;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}