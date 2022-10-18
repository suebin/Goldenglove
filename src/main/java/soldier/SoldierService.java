package soldier;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("soldierservice")
public class SoldierService {
	@Autowired
	@Qualifier("soldierdao")
	SoldierDAO dao;
	
	/*
	 * public int insertSoldier(SoldierDTO dto) { return dao.insertSoldier(dto); }
	 */
}
