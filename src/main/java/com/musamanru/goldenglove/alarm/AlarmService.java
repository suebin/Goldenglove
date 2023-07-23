package com.musamanru.goldenglove.alarm;

import java.util.List;

public interface AlarmService {
	public List<AlarmDTO> selectAlarm(String teamName, String name); 
	public int checkAlarm(int seq);
}
