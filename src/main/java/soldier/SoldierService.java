package soldier;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("soldierservice")
public class SoldierService {
	@Autowired
	@Qualifier("soldierdao")
	SoldierDAO dao;
	
	// 용병 검색 1 : 지역 전체, 포지션 전체, 날짜 X 
	
	public List<SoldierDTO> getSoldierList1() {
		return dao.getSoldierList1();
	}
	
	// 용병 검색 2 : 지역 전체, 포지션 전체, 날짜 O
	
	public List<SoldierDTO> getSoldierList2(String possibleDate) {
		return dao.getSoldierList2(possibleDate);
	}
	
	// 용병 검색 3 : 지역 전체, 날짜 X
	
	public List<SoldierDTO> getSoldierList3(String position) {
		return dao.getSoldierList3(position);
	}
	
	// 용병 검색 4 : 지역 전체, 날짜 O
	
	public List<SoldierDTO> getSoldierList4(String position, String possibleDate) {
		return dao.getSoldierList4(position, possibleDate);
	}
	
	// 용병 검색 5 : 포지션 전체, 날짜 X
	
	public List<SoldierDTO> getSoldierList5(String region) {
		return dao.getSoldierList5(region);
	}
	
	// 용병 검색 6 : 포지션 전체, 날짜 O
	
	public List<SoldierDTO> getSoldierList6(String region, String possibleDate) {
		return dao.getSoldierList6(region, possibleDate);
	}
	
	// 용병 검색 7 : 날짜 X
	
	public List<SoldierDTO> getSoldierList7(String region, String position) {
		return dao.getSoldierList7(region, position);
	}
	
	// 용병 검색 8 : 날짜 O
	
	public List<SoldierDTO> getSoldierList8(String region, String position, String possibleDate) {
		return dao.getSoldierList8(region, position, possibleDate);
	}
	
	
	// 용병 등록
	
	public int insertSoldier(SoldierDTO dto) { 
		return dao.insertSoldier(dto); 
	}
	
	public int selectMylog(String soldierName, String possibleDate) {
		return dao.selectMylog(soldierName, possibleDate);
	}
	
	// 용병 스카우트 제의 (팀 주장만)
	
	public int updateMateTeam(int seq, String userTeamName) {
		return dao.updateMateTeam(seq, userTeamName);
	}
	
	// 용병 로그
	
	public List<SoldierDTO> selectMySoldierLog(String userName) {
		return dao.selectMySoldierLog(userName);
	}
	public List<SoldierDTO> selectOffer(String userName) {
		return dao.selectOffer(userName);
	}
	
	// 용병 로그 (스카우트 제의 수락하기 버튼)
	
	public int updateMateTeamAceptance(int seq) {
		return dao.updateMateTeamAceptance(seq);
	}
	public int updateFinalMateTeam(int seq, String mateTeam) {
		return dao.updateFinalMateTeam(seq, mateTeam);
	}
	
	
	 
}
