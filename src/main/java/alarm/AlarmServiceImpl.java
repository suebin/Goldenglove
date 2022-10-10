package alarm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("AlarmService")
public class AlarmServiceImpl implements AlarmService {
	@Autowired
	AlarmDAO dao;
	
	public List<AlarmDTO> selectAlarm(String homeName) {
		return dao.selectAlarm(homeName);
	}

	public int checkAlarm(int seq) {
		return dao.checkAlarm(seq);
	}
}
