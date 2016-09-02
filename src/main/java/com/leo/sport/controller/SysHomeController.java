package com.leo.sport.controller;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class SysHomeController {

	/**
	 * 跳转到登录界面
	 * @param req
	 * @param response
	 * @return
	 */
	@RequestMapping("/showLogin")
	public String show(HttpServletRequest req,
			HttpServletResponse response) {
		String userId ="";
		req.setAttribute("message","Hello,World!!!!!!!!!!");
		if(StringUtils.isNotBlank(userId)){
			return "redirect:/index.do"; 
		}else{
			return "portal/hello";
		}
	}	
	
	/**
	 * 跳转到首页
	 * @param req
	 * @param response
	 * @return
	 */
	@RequestMapping("/index")
	public String index(HttpServletRequest req,
			HttpServletResponse respose) {

		req.setAttribute("message","Hello,World");

		return "portal/hello";
	}		
}
