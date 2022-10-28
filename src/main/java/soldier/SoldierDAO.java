package soldier;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("soldierdao")
public interface SoldierDAO {
	
	// 용병 검색 1 : 지역 전체, 포지션 전체, 날짜 X 
	
	List<SoldierDTO> getSoldierList1();
	
	// 용병 검색 2 : 지역 전체, 포지션 전체, 날짜 O
	
	List<SoldierDTO> getSoldierList2(String possibleDate);
	
	// 용병 검색 3 : 지역 전체, 날짜 X
	
	List<SoldierDTO> getSoldierList3(String position);
	
	// 용병 검색 4 : 지역 전체, 날짜 O
	
	List<SoldierDTO> getSoldierList4(String position, String possibleDate);
	
	// 용병 검색 5 : 포지션 전체, 날짜 X
	
	List<SoldierDTO> getSoldierList5(String region);
	
	// 용병 검색 6 : 포지션 전체, 날짜 O
	
	List<SoldierDTO> getSoldierList6(String region, String possibleDate);
	
	// 용병 검색 7 : 날짜 X
	
	List<SoldierDTO> getSoldierList7(String region, String position);
	
	// 용병 검색 8 : 날짜 O
	
	List<SoldierDTO> getSoldierList8(String region, String position, String possibleDate);

	
	// 용병 등록
	
	int insertSoldier(SoldierDTO dto);
	int selectMylog(String soldierName, String possibleDate);
	
	// 용병 스카우트 제의 (팀 주장만)
	
	int updateMateTeam(int seq, String userTeamName);
	
	// 용병 로그 
	
	List<SoldierDTO> selectMySoldierLog(String userName);
	List<SoldierDTO> selectOffer(String userName);
	List<SoldierDTO> selectOfferAcceptance(String userName, String userTeamName);
	List<SoldierDTO> selectOfferRequest(String userTeamName);
	
	// 용병 로그 (스카우트 제의 수락하기 버튼)
	
	int updateMateTeamAceptance(int seq);
	int updateFinalMateTeam(int seq, String mateTeam);

	
	// 스카우트 제의 알림
	void requestScoutAlarm(String teamName, String soldierName);
	
	// 스카우트 수락 알림
	void acceptScoutAlarm(String teamName, String soldierName);
}
