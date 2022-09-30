package teammatch;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("teammatchdao")
public interface TeamMatchDAO {
	
	// 매치 등록
	
	int insertTeamMatch(TeamMatchDTO dto);
	
	// 매치 검색 > 지역별 조회
	
	List<TeamMatchDTO> getTeamMatchList(String region, String possibleDate);
	
	// 매치 검색 > 전체 지역 조회
	
	List<TeamMatchDTO >getAllTeamMatchList(String possibleDate);
}
