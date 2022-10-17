package team;

import java.util.HashMap;

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

//	팀아이디 조회
	public String selectTeamId(String teamName) {
		return teamDao.selectTeamId(teamName);
	}

//	포지션별 팀원조회
	public String selectPosition(UserDTO user) {
		return teamDao.selectPosition(user);
	}

//	팀탈퇴
	public UserDTO exitTeam(HashMap<String, String> teamInfo) {
		teamDao.exitTeamUser(teamInfo.get("id"));
		teamDao.exitTeam(teamInfo);
		return userDao.selectUser(teamInfo.get("id"));
	}

//	팀 가입 신청
	public void registerTeam(HashMap<String, String> registerInfo) {
		teamDao.makeRegi(registerInfo.get("id"));
		teamDao.registerTeam(registerInfo);
	}

//	팀 가입 신청 조회
	public String selectRegisterInfo(String id) {
		return teamDao.selectRegisterInfo(id);
	}

	public String[] selectRegisterInfoUser(String id) {
		return teamDao.selectRegisterInfoUser(id);
	}

//	팀 가입 신청 승인
	public void updateRegister(HashMap<String, String> registerInfo) {
		teamDao.updateRegisterResult(registerInfo);
		teamDao.updatePosition(registerInfo);
	}

//	팀 가입 신청 거절
	public void updateRegisterFalse(HashMap<String, String> registerInfo) {
		teamDao.updateRegisterResult(registerInfo);
	}

//	팀원 명 전체 조회
	public UserDTO[] selectAllMember(String teamId) {
		String allMember = teamDao.selectAllMember(teamId);
		String[] allMemberArr = allMember.replaceAll("\\s+", " ").trim().split(" ");

		UserDTO[] allUser = new UserDTO[allMemberArr.length];
		for (int i = 0; i < allMemberArr.length; i++) {
			allUser[i] = teamDao.selectUser(allMemberArr[i]);
		}
		return allUser;
	}
	
	
	// 가입 신청 알림
	public void applyJoinAlarm(String id, String teamName, String alarmDate) {
		teamDao.applyJoinAlarm(id, teamName, alarmDate);
	}

	// 가입 수락 알림
	public void acceptJoinAlarm(String id, String teamName, String alarmDate) {
		teamDao.acceptJoinAlarm(id, teamName, alarmDate);
	}
	
	// 가입 거절 알림
	public void cancleJoinAlarm(String id, String teamName, String alarmDate) {
		teamDao.cancleJoinAlarm(id, teamName, alarmDate);
	}

	// 팀 탈퇴 알림
	public void exitTeamAlarm(String id, String teamName, String alarmDate) {
		teamDao.exitTeamAlarm(id, teamName, alarmDate);
	}
}
