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
	 
}
