package teammatch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("teammatchservice")
public class TeamMatchService {
	@Autowired
	@Qualifier("teammatchdao")
	TeamMatchDAO dao;

	// 매치 등록

	public int insertTeamMatch(TeamMatchDTO dto) {
		return dao.insertTeamMatch(dto);
	}

	// 매치 검색 > 지역별 조회

	public List<TeamMatchDTO> getTeamMatchList(String region, String possibleDate) {
		return dao.getTeamMatchList(region, possibleDate);
	}

	// 매치 검색 > 전체 지역 조회

	public List<TeamMatchDTO> getAllTeamMatchList(String possibleDate) {
		return dao.getAllTeamMatchList(possibleDate);
	}
	
	// 매치 신청
	
	public int updateAwayName(String awayName, int seq) {
		return dao.updateAwayName(awayName, seq);
	}
	public int updateRegistration(int seq) {
		return dao.updateRegistration(seq);
	}
	
}
