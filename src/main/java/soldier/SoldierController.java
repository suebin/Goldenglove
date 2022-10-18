package soldier;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SoldierController {
	
	// 용병 구하기 메인
	
	@RequestMapping("/getSoldier")
	public String getSoldier() {
		return "soldier/getSoldier";
	}
	
	// 용병 구하기 등록
	
	@RequestMapping("/registerSoldier")
	public String soldierform() {
		return "soldier/soldierRegistration";
	}
}
