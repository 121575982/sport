/**
 * Description:用户操作Service
 * Company:山东三米信息技术有限公司
 * @author lld
 * @version 1.0
 * */
package com.leo.sport.service;

import com.leo.sport.domain.Aboutus;
import org.springframework.stereotype.Service;

@Service
public interface AboutusService 
{

	/**
	 * 关于我们
	 * */
	Aboutus view(String code);

	/**
	 * 添加或修改
	 */
    int save(Aboutus record);
	
}
