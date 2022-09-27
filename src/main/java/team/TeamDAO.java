package team;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("teamDAO")
public interface TeamDAO {
//	팀원등록
	void insertTeam(TeamDTO dto);

//	팀원조회
	TeamDTO selectTeam(String teamName);

//	수정
	void updateTeam(TeamDTO dto);
}
