package teammatch;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("teammatchdao")
public interface TeamMatchDAO {
	
	public int insertTeamMatch(TeamMatchDTO dto);
}
