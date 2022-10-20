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

//	팀원 등록 요청
	public void registerUser(TeamDTO dto) {
		String member = dto.getFirstBase() + " " + dto.getSecondBase() + " " + dto.getThirdBase() + " "
				+ dto.getCatcher() + " " + dto.getPitcher() + " " + dto.getLeftFielder() + " " + dto.getRightFielder()
				+ " " + dto.getCenterFielder() + " " + dto.getShortStop();
		String[] arr = member.replaceAll("\\s+", " ").trim().split(" ");
		HashMap<String, String> map = new HashMap<>();
		map.put("teamId", dto.getTeamId());
		map.put("teamName", dto.getTeamName());
		map.put("requester", "team");

		for (int i = 0; i < arr.length; i++) {
			if (!dto.getTeamId().equals(arr[i])) {
				String seq = String.valueOf(System.nanoTime());
				map.put("seq", seq);
				map.put("id", arr[i]);
				teamDao.makeRegister(map);
				teamDao.registerUser(map);
			}
		}
	}

//	팀원 등록 요청 조회
	public UserDTO[] selectRegisterUser(String teamId) {
		String[] arr = teamDao.selectRegisterUser(teamId);
		UserDTO[] userArr = new UserDTO[arr.length];
		for (int i = 0; i < arr.length; i++) {
			userArr[i] = teamDao.selectUser(arr[i]);
		}
		return userArr;
	}

	public String[] selectRegisterTeam(String id) {
		return teamDao.selectRegisterTeam(id);
	}

//	팀생성
	public UserDTO insertTeam(TeamDTO dto, UserDTO position) {
		teamDao.insertTeam(dto);
		teamDao.updateSelf(position);
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

	public UserDTO selectUserPhone(String phone) {
		return teamDao.selectUserPhone(phone);
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
		String seq = String.valueOf(System.nanoTime());
		registerInfo.put("seq", seq);
		teamDao.makeRegi(registerInfo);
		teamDao.registerTeam(registerInfo);
	}

//	팀 가입 신청 조회
	public String selectRegisterInfo(String id) {
		return teamDao.selectRegisterInfo(id);
	}

	public UserDTO[] selectRegisterInfoUser(String id) {
		String[] arr = teamDao.selectRegisterInfoUser(id);
		UserDTO[] userArr = new UserDTO[arr.length];
		for (int i = 0; i < arr.length; i++) {
			userArr[i] = teamDao.selectUser(arr[i]);
		}
		return userArr;
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

//	팀 순위 리스트
	public int selectRank(String teamName) {
		String[] list = teamDao.selectRank();
		int rank = 0;
		for (int i = 0; i < list.length; i++) {
			if (list[i].equals(teamName)) {
				rank = i + 1;
			}
		}
		return rank;
	}
}
