package com.musamanru.goldenglove.alarm;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("AlarmDAO")
public interface AlarmDAO {
	List<AlarmDTO> selectAlarm(String teamName, String name); 
	int checkAlarm(int seq); 
}
