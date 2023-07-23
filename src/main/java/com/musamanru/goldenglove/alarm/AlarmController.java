package com.musamanru.goldenglove.alarm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AlarmController {
	@Autowired
	@Qualifier("AlarmService")
	AlarmServiceImpl service;

	@ResponseBody
	@RequestMapping("/alarm")
	public List<AlarmDTO> selectAlarm(String teamName, String name) {
		List<AlarmDTO> list = service.selectAlarm(teamName, name);
		return list;
	}

	@ResponseBody
	@RequestMapping("/checkAlarm")
	public void checkAlarm(String alarmSeq) {
		int seq = Integer.parseInt(alarmSeq);
		service.checkAlarm(seq);
	}
}
