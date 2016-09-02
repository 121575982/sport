/**
 * Description:用户操作Service
 * Company:山东三米信息技术有限公司
 * @author lld
 * @version 1.0
 * */
package com.leo.sport.service.impl;

import com.leo.sport.domain.Aboutus;
import com.leo.sport.mapper.AboutusMapper;
import com.leo.sport.service.AboutusService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AboutusServiceImpl implements AboutusService
{

	@Autowired
	private AboutusMapper aboutusMapper;


	@Override
	public int save(Aboutus record) {
		int flag = 0;
		String ucode = record.getUcode();
		if(!StringUtils.isEmpty(ucode)) 
		{
			flag = aboutusMapper.updateByPrimaryKeySelective(record);
		}
		return flag;
	}
	

	@Override
	public Aboutus view(String code) {
		// TODO Auto-generated method stub
		return aboutusMapper.selectByPrimaryKey(code);
	}


	
}
