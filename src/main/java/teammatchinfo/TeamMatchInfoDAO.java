package teammatchinfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import teammatch.TeamMatchDTO;

@Mapper
@Repository("teammatchinfodao")
public interface TeamMatchInfoDAO {
	
	// 수락을 기다리는 경기
	
	List<TeamMatchDTO> getTeamMatchList1(String myTeamName);
	
	// 등록한 경기
	
	List<TeamMatchDTO> getTeamMatchList2(String myTeamName);
	
	// 신청한 경기
	
	List<TeamMatchDTO> getTeamMatchList3(String myTeamName);
	
	// 예정된 경기
	
	List<TeamMatchDTO> getTeamMatchList4(String myTeamName);
	
	// 지난 경기
	
	List<TeamMatchDTO> getTeamMatchList5(String myTeamName);
	
	// 1. 수락을 기다리는 경기 > 수락하기 버튼
	
	int updateAcceptance(int seq);
	
	// 2. 등록한 경기 > 취소하기 버튼
	
	int deleteTeammatchRegistration(int seq);
	
	// 3. 신청한 경기 > 취소하기 버튼
	
	int deleteAddTeammatch(int seq);
	
	// 4. 예정된 경기 > 취소하기 버튼
	int cancelTeammatch(int seq);
}
