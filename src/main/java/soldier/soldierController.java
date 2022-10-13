package soldier;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class soldierController {
	
	@RequestMapping("/getSoldier")
	public String getSoldier() {
		return "soldier/getSoldier";
	}
}
