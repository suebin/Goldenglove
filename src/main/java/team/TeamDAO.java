package team;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import user.UserDTO;

@Mapper
@Repository("teamDAO")
public interface TeamDAO {
//	팀원등록
	void insertTeam(TeamDTO dto);

//	팀가입
	void updateUserTeam(TeamDTO dto);

//	팀원조회
	TeamDTO selectTeam(String teamName);

//	수정
	void updateTeam(TeamDTO dto);

//	팀이름 중복조회
	int selectTeamName(String teamName);

//	팀원추가 가입조회
	UserDTO selectUser(String id);

//	팀아이디 조회
	String selectTeamId(String teamName);

//	팀탈퇴
	void exitTeamUser(String id);

	void exitTeam(HashMap teamInfo);

//	포지션별 팀원조회
	String selectPosition(UserDTO user);
}
