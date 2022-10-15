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
	void makeRegi(String id);

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
}
