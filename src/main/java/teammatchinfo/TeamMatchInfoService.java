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
	
	// 1. 수락을 기다리는 경기 > 수락하기 버튼
	
	public int updateAcceptance(int seq) {
		return dao.updateAcceptance(seq);
	}
	
	// 2. 등록한 경기 > 취소하기 버튼
	
	public int deleteTeammatchRegistration(int seq) {
		return dao.deleteTeammatchRegistration(seq);
	}
	
	// 3. 신청한 경기 > 취소하기 버튼
	
	public int deleteAddTeammatch(int seq) {
		return dao.deleteAddTeammatch(seq);
	}
	
	// 4. 예정된 경기 > 취소하기 버튼
	
	public int cancelTeammatch(int seq) {
		return dao.cancelTeammatch(seq);
	}
	
	
	
	// 알림 등록
	public void insertAlarm(int seq) {
		dao.insertAlarm(seq);
	}
	
	// 취소 시 null 된 awayName, cancle한 팀 입력
	public void updateCancleAlarm(int seq, String cancleTeam) {
		dao.updateCancleAlarm(seq, cancleTeam);
	}

	// 수락/취소 알림 날짜 업데이트
	public void updateAlarmDate(String alarmDate) {
		dao.updateAlarmDate(alarmDate);
	}
	
}
