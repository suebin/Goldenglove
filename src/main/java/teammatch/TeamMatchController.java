package teammatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TeamMatchController {
	@Autowired
	@Qualifier("teammatchservice")
	TeamMatchService service;
	
	// 팀 매치 메인
	@GetMapping("/teammatch")
	public String match() {
		return "teammatch/teammatch";
	}
	
	// 팀 매치 검색
	@ResponseBody
	@PostMapping("/teammatch")
	public String searchmatch(String region, String possibleDate) {
		
		String model1 = region;
		String model2 = possibleDate;
		
		return "{\"model1\":\"" + model1 + "\", \"model2\":\"" + model2 + "\"}";
	}
	
	// 팀 매치 등록 
	@GetMapping("/registerteammatch")
	public String matchform(String region, String possibleDate) {

		return "teammatch/matchform";
	}
	
	@PostMapping("/registerteammatch")
	public ModelAndView registermatch(TeamMatchDTO dto) {
		
		int insertcount = service.registerTeamMatch(dto);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("insertcount", insertcount);
		mv.setViewName("teammatch/registermatch");
		
		return mv;
	}
	
	
}
