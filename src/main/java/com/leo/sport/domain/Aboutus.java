package com.leo.sport.domain;

import java.util.Date;

public class Aboutus {
    /**
     * 
     */
    private String ucode;

    /**
     * 
     */
    private Date rcdtime;

    /**
     * 
     */
    private String content;

    public String getUcode() {
        return (ucode == null)?"":ucode;
    }

    public void setUcode(String ucode) {
        this.ucode = ucode == null ? null : ucode.trim();
    }

    public Date getRcdtime() {
        return rcdtime;
    }

    public void setRcdtime(Date rcdtime) {
        this.rcdtime = rcdtime;
    }

    public String getContent() {
        return (content == null)?"":content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }
}