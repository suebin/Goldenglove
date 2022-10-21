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
		
	
	// 유저가 팀 주장인지 확인
	
	public String selectTeamId(String teamName) {
		return dao.selectTeamId(teamName);
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
	
	// 승패 반영
	
	public void updateWinner(int seq, String myTeam, String awayTeam) {
		dao.updateWinner(seq, myTeam, awayTeam);
	}
	
	public void updateLoser(int seq, String myTeam, String awayTeam) {
		dao.updateLoser(seq, myTeam, awayTeam);
	}
	
	// 승률 반영
	
	public void updateTeamWinningRate(String team) {
		dao.updateTeamWinningRate(team);
	}
	
	public void updateUserWinningRate(String team) {
		dao.updateUserWinningRate(team);
	}
	
	// 기본 팀 매칭 승률
	
	public void updateTeamWinCount(String team) {
		dao.updateTeamWinCount(team);
	}
	public void updateTeamLoseCount(String team) {
		dao.updateTeamLoseCount(team);
	}
	public void updateUserWinCount(String team) {
		dao.updateUserWinCount(team);
	}
	public void updateUserLoseCount(String team) {
		dao.updateUserLoseCount(team);
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

	// 오늘의 매칭
	public List<TeamMatchDTO> getTodayMatching(String today) {
		return dao.getTodayMatching(today);
	}
	
}
