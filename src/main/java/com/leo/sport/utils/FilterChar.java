/**
 * Description：过滤指定的字符
 * Company:山东三米信息技术有限公司
 * @author lld
 * @version 1.0
 * */
package com.leo.sport.utils;

import java.util.List;

public class FilterChar 
{
   
	private List<String> list;
	
	public void setList(List<String> list)
	{
		this.list = list;
	}
	/**
	 * 将字符串中指定的字符过滤掉
	 * */
	public String filter(String str)
	{
		if(list == null)
		{
			return str;
		}
		for(int i = 0; i < list.size();i++)
		{
			String temp = list.get(i);
			if(temp != null && !temp.trim().equals("")&&str.indexOf(temp.trim()) > 0)
			{
				String star = getStar(temp.trim().length());
				str = str.replaceAll(temp.trim(), star);
			}
		}
		return str;
	}
	/**
	 * 获取指定数量的*
	 * */
	private String getStar(int len)
	{
		StringBuffer str = new StringBuffer();
		for(int i = 0;i < len;i++)
		{
			str.append("*");
		}
		return str.toString();
	}
}
