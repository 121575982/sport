package com.leo.sport.mapper;


import com.leo.sport.domain.Aboutus;
import org.springframework.stereotype.Repository;

@Repository
public interface AboutusMapper {
    int deleteByPrimaryKey(String ucode);

    int insert(Aboutus record);

    int insertSelective(Aboutus record);

    Aboutus selectByPrimaryKey(String ucode);

    int updateByPrimaryKeySelective(Aboutus record);

    int updateByPrimaryKeyWithBLOBs(Aboutus record);

    int updateByPrimaryKey(Aboutus record);
}