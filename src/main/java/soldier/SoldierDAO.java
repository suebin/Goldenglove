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

}
