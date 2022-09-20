package team;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("teamDAO")
public interface TeamDAO {
	void insertTeam(TeamDTO dto);
}
