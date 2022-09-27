package teammatch;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("teammatchdao")
public interface TeamMatchDAO {
	
	// 매치 등록
	int insertTeamMatch(TeamMatchDTO dto);
	
	List<TeamMatchDTO> getTeamMatchList(String region, String possibleDate);
}
