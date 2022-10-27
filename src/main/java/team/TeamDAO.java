package team;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import user.UserDTO;

@Mapper
@Repository("teamDAO")
public interface TeamDAO {
//	팀생성
	void updateUserTeam(TeamDTO dto);

	void insertTeam(TeamDTO dto);

	void updateSelf(UserDTO position);

//	팀원조회
	TeamDTO selectTeam(String teamName);

//	수정
	void updateTeam(TeamDTO dto);

//	팀이름 중복조회
	int selectTeamName(String teamName);

//	팀원추가 가입조회
	UserDTO selectUser(String id);

	UserDTO selectUserPhone(String phone);

//	팀아이디 조회
	String selectTeamId(String teamName);

//	팀탈퇴
	void exitTeamUser(String id);

	void exitTeam(HashMap teamInfo);

//	포지션별 팀원조회
	String selectPosition(UserDTO user);

//	팀 가입 신청
	void makeRegi(HashMap idSeq);

	void registerTeam(HashMap registerInfo);

//	팀 가입 신청 조회
	String selectRegisterInfo(String id);

	String[] selectRegisterInfoUser(String id);

//	팀 가입 신청 승인
	void updateRegisterResult(HashMap registerInfo);

	void updatePosition(HashMap registerInfo);

//	팀원 명 전체 조회
	String selectAllMember(String teamId);

//	팀원 등록 요청
	void makeRegister(HashMap teamInfo);

	void registerUser(HashMap userInfo);

//	요청 조회
	String[] selectRegisterUser(String teamId);

	String[] selectRegisterTeam(String id);

//	seq조회
	String selectSeq(HashMap idTeamName);

	// 가입 신청 알림
	void applyJoinAlarm(String id, String teamName, String alarmDate);

	// 가입 수락 알림
	void acceptJoinAlarm(String id, String teamName, String alarmDate);

	// 가입 거절 알림
	void cancleJoinAlarm(String id, String teamName, String alarmDate);

	// 팀 탈퇴 알림
	void exitTeamAlarm(String id, String teamName, String alarmDate);

//	팀 순위 리스트
	String[] selectRank();

//	팀장변경
	void updateTeamLeader(HashMap teamLeader);

	int updateTeamLeaderSelect(HashMap teamLeader);

//	팀 삭제
	void deleteTeamUser(String id);

	void deleteTeam(String id);
}
