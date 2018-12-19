package demo.model;

import java.io.Serializable;
import java.util.Date;

/**
 * information
 * @author 
 */
public class Information implements Serializable {
    private Integer xid;

    private String title;

    private String content;

    private Date publishedtime;

    private String publisher;

    private static final long serialVersionUID = 1L;

    public Integer getXid() {
        return xid;
    }

    public void setXid(Integer xid) {
        this.xid = xid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getPublishedtime() {
        return publishedtime;
    }

    public void setPublishedtime(Date publishedtime) {
        this.publishedtime = publishedtime;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }
}