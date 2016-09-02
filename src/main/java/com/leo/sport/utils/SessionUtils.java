package com.leo.sport.utils;

import com.leo.sport.domain.User;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * 会话管理
 * @author chendy
 *
 */
public class SessionUtils {
	public static final String KEY_USR_ID = "userId";
	public static final String KEY_USR_NAME = "userName";
	public static final String KEY_USR_ROLE = "userRole";
	public static final String KEY_USR_CATEGORY = "userCategory";
	public static final String KEY_USR_AUTHDATA = "userAuthData";
	public static final String KEY_AUTHORITY_TYPE = "authorityType";
	/**
	 * 用户登录名，login
	 */
	public static final String KEY_USR_LOGIN = "userLogin";
	/*public static final int ROLE_ADMIN_ID = 1;//系统管理员
	public static final int ROLE_SCHOOL_ADMIN_ID = 2;//学校管理员
	public static final int ROLE_SHOP_ID = 4;//店铺用户	
	public static final String ROLE_ADMIN = "ROLE_ADMIN";//系统管理员
	public static final String ROLE_SCHOOL_ADMIN = "ROLE_SCHOOL_ADMIN";//学校管理员
	public static final String ROLE_SHOP = "ROLE_SHOP";//店铺用户	
*/	
	/**
	 * 初始化用户session
	 * @param req
	 * @param user
	 * @param roleList
	 */
	public static void initUserSession(HttpServletRequest req,User user){
		HttpSession session = req.getSession();
		session.setAttribute(KEY_USR_ID, user.getUcode());
		session.setAttribute(KEY_USR_NAME, user.getLogin());
		session.setAttribute(KEY_USR_ROLE, user.getRole());
		session.setAttribute(KEY_USR_CATEGORY, user.getCategory());
		session.setAttribute(KEY_USR_AUTHDATA, user.getAuthData());
		session.setAttribute(KEY_USR_LOGIN, user.getLogin());
		session.setAttribute(KEY_AUTHORITY_TYPE, user.getAuthorityType());
	}
	
	/**
	 * 获取session中的属性
	 * @param req
	 * @param keyName
	 * @return
	 */
	private static String getSessionAttr(HttpServletRequest req,String keyName){
		String value = null;
		HttpSession session = req.getSession(false);
		if(session != null){
			Object attrVal = session.getAttribute(keyName);
			if(attrVal != null){
				value = String.valueOf(attrVal);
			}
		}
		return value;
	}
	
	/**
	 * 获取session中的属性：对象类型
	 * @param req
	 * @param keyName
	 * @return
	 */
	private static Object getSessionAttrObj(HttpServletRequest req,String keyName){
		HttpSession session = req.getSession(false);
		if(session != null){
			return session.getAttribute(keyName);
		}else{
			return null;
		}
	}
	
	/**
	 * 获取当前用户id
	 * @param req
	 * @return
	 */
	public static String getCurUserId(HttpServletRequest req){
		HttpSession session = req.getSession(false);
		String userId = null;
		if(session != null){
			userId = (String)session.getAttribute(KEY_USR_ID);
		}
		return userId;
	}
	/**
	 * 获取当前用户登录名login
	 * @param req
	 * @return
	 */
	public static String getCurUserLogin(HttpServletRequest req){
		HttpSession session = req.getSession(false);
		String userlogin = null;
		if(session != null){
			userlogin = (String)session.getAttribute(KEY_USR_LOGIN);
		}
		return userlogin;
	}
	
	/**
	 * 获取当前用户名
	 * @param req
	 * @return
	 */
	public static String getCurUserName(HttpServletRequest req){
		HttpSession session = req.getSession(false);
		String userName = null;
		if(session != null){
			userName = (String)session.getAttribute(KEY_USR_NAME);
		}
		return userName;
	}
	
	/**
	 * 获取用户的权限类型
	 * @param req
	 * @return
	 */
	public static String getUserCategory(HttpServletRequest req){
		HttpSession session = req.getSession(false);
		String category = null;
		if(session != null){
			category = (String)session.getAttribute(KEY_USR_CATEGORY);
		}
		return category;
	}
	
	/**
	 * 获取用户的权限数据
	 * @param req
	 * @return
	 */
	public static String getUserAuthData(HttpServletRequest req){
		HttpSession session = req.getSession(false);
		String authData = null;
		if(session != null){
			authData = (String)session.getAttribute(KEY_USR_AUTHDATA);
		}
		return authData;
	}
	
	/**
	 * 获取用户的角色
	 * @param req
	 * @return
	 */
	public static String getUserRole(HttpServletRequest req){
		HttpSession session = req.getSession(false);
		String roleId = null;
		if(session != null){
			roleId = (String)session.getAttribute(KEY_USR_ROLE);
		}
		return roleId;
	}
	


	/**
	 * 获取当前用户的权限控制类型
	 * @param req
	 * @return
	 */
	public static String getAuthorityType(HttpServletRequest req){
		String authorityType = null;
		Object val = getSessionAttrObj(req, KEY_AUTHORITY_TYPE);
		if(val != null && val instanceof Integer){
			authorityType = (String)val;
		}
		
		if(authorityType == null){
			authorityType = "-1";
		}
		
		return authorityType;
	}
	
}
