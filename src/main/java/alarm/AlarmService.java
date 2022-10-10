package alarm;

import java.util.List;

public interface AlarmService {
	public List<AlarmDTO> selectAlarm(String homeName); 
	public int checkAlarm(int seq);
}
