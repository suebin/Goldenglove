package teammatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("teammatchservice")
public class TeamMatchServiceImpl implements TeamMatchService {
	@Autowired
	TeamMatchDAO dao;
	
	@Override
	public int registerTeamMatch(TeamMatchDTO dto) {
		return dao.insertTeamMatch(dto);
	}
}
