package teammatchinfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import teammatch.TeamMatchDTO;

@Service("teammatchinfoservice")
public class TeamMatchInfoService {
	@Autowired
	@Qualifier("teammatchinfodao")
	TeamMatchInfoDAO dao;
	
	// 수락을 기다리는 경기
	
	public List<TeamMatchDTO> getTeamMatchList1(String myTeamName) {
		return dao.getTeamMatchList1(myTeamName);
	}
	
	// 등록한 경기
	
	public List<TeamMatchDTO> getTeamMatchList2(String myTeamName) {
		return dao.getTeamMatchList2(myTeamName);
	}
	
	// 신청한 경기
	
	public List<TeamMatchDTO> getTeamMatchList3(String myTeamName) {
		return dao.getTeamMatchList3(myTeamName);
	}
	
	// 예정된 경기
	
	public List<TeamMatchDTO> getTeamMatchList4(String myTeamName) {
		return dao.getTeamMatchList4(myTeamName);
	}
	
	
	// 지난 경기
	
	public List<TeamMatchDTO> getTeamMatchList5(String myTeamName) {
		return dao.getTeamMatchList5(myTeamName);
	}
}
