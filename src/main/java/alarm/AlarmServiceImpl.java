package alarm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("AlarmService")
public class AlarmServiceImpl implements AlarmService {
	@Autowired
	AlarmDAO dao;
	
	public List<AlarmDTO> selectAlarm(String teamName, String name) {
		return dao.selectAlarm(teamName, name);
	}

	public int checkAlarm(int seq) {
		return dao.checkAlarm(seq);
	}
}
