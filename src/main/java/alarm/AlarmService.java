package alarm;

import java.util.List;

public interface AlarmService {
	public List<AlarmDTO> selectAlarm(String homeName, String name); 
	public int checkAlarm(int seq);
}
