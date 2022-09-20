package team;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("teamService")
public class TeamService {
	@Autowired
	TeamDAO teamDao;

	public void insertTeam(TeamDTO dto) {
		teamDao.insertTeam(dto);
	}
}
