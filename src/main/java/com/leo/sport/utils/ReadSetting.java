/**
 * Description:读取程序配置文件，加载预加载信息
 * Company:山东三米信息技术有限公司
 * @Author lld
 * @version 1.0
 * */
package com.leo.sport.utils;

import java.util.Map;

public class ReadSetting 
{
   private Map<String,String> setting;
   
   public void setSetting(Map<String,String> setting)
   {
	   this.setting = setting;
   }
   
   public String get(String key)
   {
	   if(setting.containsKey(key))
	   {
		   return setting.get(key);
	   }
	   else
	   {
		   return null;
	   }
   }
}
