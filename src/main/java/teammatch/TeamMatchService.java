package teammatch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import soldier.SoldierDTO;
import user.UserDTO;

@Service("teammatchservice")
public class TeamMatchService {
	@Autowired
	@Qualifier("teammatchdao")
	TeamMatchDAO dao;

	// 매치 등록

	public int insertTeamMatch(TeamMatchDTO dto) {
		return dao.insertTeamMatch(dto);
	}
	
	// 스카우트 한 용병 리스트 
	public List<SoldierDTO> getSoldierList(String teamName) {
		return dao.getSoldierList(teamName);
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
	
	public int updateAway(String awayPerson, String awayName, int seq) {
		return dao.updateAway(awayPerson, awayName, seq);
	}
	public int updateRegistration(int seq) {
		return dao.updateRegistration(seq);
	}
	
	// 팀 프로필
	
	public String getHomePerson(int seq) {
		return dao.getHomePerson(seq);
	}

	public UserDTO selectTeamMember(String name) {
		return dao.selectTeamMember(name);
	}
	
	// 알림
	public int insertAlarm(String homeName, String awayName, String region, String possibleDate, String possibleTime, String homePlace, String alarmDate) {
		return dao.insertAlarm(homeName, awayName, region, possibleDate, possibleTime, homePlace, alarmDate);
	}
}
