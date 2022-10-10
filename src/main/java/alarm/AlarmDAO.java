package alarm;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("AlarmDAO")
public interface AlarmDAO {
	List<AlarmDTO> selectAlarm(String homeName); 
	int checkAlarm(int seq); 
}
