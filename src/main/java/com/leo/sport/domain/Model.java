/**
 * Description:返回给客户端信息封装类
 * Company:山东三米信息技术有限公司
 * @author lld
 * @version 1.0
 * */
package com.leo.sport.domain;

import java.io.Serializable;

public class Model implements Serializable
{   
	//返回文字信息
   protected String message;
   //返回信息状态:0失败，1成功……
   protected String status;
   //用户标识字符串
   protected String token;
   
	public String getToken() {
	return token;
	}
	
	public void setToken(String token) {
		this.token = token;
	}
	
	public String getMessage() {
		return message;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	   
}
