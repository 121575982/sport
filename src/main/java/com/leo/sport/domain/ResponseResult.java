package com.leo.sport.domain;

import java.io.Serializable;

/**
 * Created by Administrator on 2016/8/4 0004.
 */
public class ResponseResult implements Serializable {
    private int status;
    private String msg;
    private Object data;


    public static final int SUCCESS = 0;
    public static final int FAILURE =1;

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public void setError(String msg){
        setStatus(FAILURE);
        setMsg(msg);
    }

    public void setSuccess(String msg){
        setStatus(SUCCESS);
        setMsg(msg);
    }
}
