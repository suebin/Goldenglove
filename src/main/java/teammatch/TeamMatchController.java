package teammatch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
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

	@RequestMapping("/teammatch")
	public String match() {
		return "teammatch/teammatch";
	}

	// 팀 매치 검색 > 조회
	@ResponseBody
	@PostMapping("/teammatch")
	public List<TeamMatchDTO> teammatchList(String region, String possibleDate) {

		List<TeamMatchDTO> teammatchlist = service.getTeamMatchList(region, possibleDate);

		return teammatchlist;
	}

	// 팀 매치 등록

	@RequestMapping("/registerTeammatch")
	public String matchform() {
		return "teammatch/teamMatchRegistration";
	}

	@PostMapping("/registerTeammatch")
	public ModelAndView registermatch(TeamMatchDTO dto) {

		int insertcount = service.insertTeamMatch(dto);
		ModelAndView mv = new ModelAndView();

		mv.addObject("insertcount", insertcount);
		mv.setViewName("teammatch/registrationResult");

		return mv;
	}
}
