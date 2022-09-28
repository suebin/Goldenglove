package teammatch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("teammatchservice")
public class TeamMatchService {
	@Autowired
	@Qualifier("teammatchdao")
	TeamMatchDAO dao;
	
	// 매치 등록
	public int insertTeamMatch(TeamMatchDTO dto) {
		return dao.insertTeamMatch(dto);
	}
	
	public List<TeamMatchDTO> getTeamMatchList(String region, String possibleDate) {
		return dao.getTeamMatchList(region, possibleDate);
	}
}
