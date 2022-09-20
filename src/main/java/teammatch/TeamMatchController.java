package teammatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TeamMatchController {
	@Autowired
	@Qualifier("teammatchservice")
	TeamMatchService service;
	
	// 팀 매치 메인
	@RequestMapping("/teammatch")
	public String match() {
		return "teammatch/teammatch";
	}
	
	// 팀 매치 등록 
	@GetMapping("/registermatch")
	public String matchform() {
		return "teammatch/matchform";
	}
	
	@PostMapping("/registermatch")
	public ModelAndView matchresult(TeamMatchDTO dto) {
		
		int insertcount = service.registerTeamMatch(dto);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("insertcount", insertcount);
		mv.setViewName("teammatch/matchresult");
		
		return mv;
	}
	
	
}
