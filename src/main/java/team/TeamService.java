package team;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import user.UserDAO;
import user.UserDTO;

@Service("teamService")
public class TeamService {
	@Autowired
	TeamDAO teamDao;
	@Autowired
	UserDAO userDao;

//	팀원등록
	public UserDTO insertTeam(TeamDTO dto) {
		teamDao.insertTeam(dto);
		teamDao.updateUserTeam(dto);
		return userDao.selectUser(dto.getTeamId());
	}

//	팀원조회
	public TeamDTO selectTeam(String teamName) {
		return teamDao.selectTeam(teamName);
	}

//	팀수정
	public UserDTO updateTeam(TeamDTO dto) {
		teamDao.updateTeam(dto);
		teamDao.selectTeam(dto.getTeamName());
		return userDao.selectUser(dto.getTeamId());
	}

//	팀이름 중복조회
	public int selectTeamName(String teamName) {
		return teamDao.selectTeamName(teamName);
	}

//	팀원추가 가입조회
	public UserDTO selectUser(String id) {
		return teamDao.selectUser(id);
	}
}
