package com.leo.sport.utils;

import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

public class LoginFilter extends OncePerRequestFilter {
	private static Set<String> excludeSet = new HashSet<String>();
	//不进行过滤的方法集合
	static {
		excludeSet.add("login.do");
		excludeSet.add("loginout.do");
		excludeSet.add("showLogin.do");
		excludeSet.add("relogin.do");
		excludeSet.add("view.do");
		excludeSet.add("mobilelogin.do");
	}
	
	@Override
	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		String method = uri.substring(uri.lastIndexOf("/") + 1);
		if(excludeSet.contains(method)){
			filterChain.doFilter(request, response);
		}else{
			String curUserId = SessionUtils.getCurUserId(request);
			if(StringUtils.isBlank(curUserId)){
				String requestType =  request.getHeader("X-Requested-With"); 
				if(StringUtils.equals("XMLHttpRequest", requestType)){
//					DwzResult dwzResult = new DwzResult();
//					dwzResult.setStatusCode(DwzResult.STATUS_CODE_TIMEOUT);
//					dwzResult.setMessage("会话超时，请重新登录");
					outputResult(response);
				}else{
					String contextPath = request.getContextPath();
					contextPath = contextPath.replace("\\", "/");
			        if (uri.matches("^" + contextPath + "/mobile/.*"))
			        {
			        	response.sendRedirect(contextPath+"/mobile/mobilelogin.do"); 
			        }
			        else
			        {
			        	response.sendRedirect(contextPath+"/showLogin.do"); 
			        }
				}				
			}else{
				filterChain.doFilter(request, response);
			}
		}
		
	}
	
	/**
	 * 输出结果
	 * @param response
	 * @param result
	 * @throws Exception
	 */
	private void outputResult(HttpServletResponse response){
		response.setHeader("Content-type", "text/html");  
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().println("");
		} catch (IOException e) {
			logger.error("outputResult error!", e);
		}
	}

}
