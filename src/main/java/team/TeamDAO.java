package team;

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
}
