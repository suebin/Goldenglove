package teammatch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		return "teammatch/teamMatch";
	}

	// 팀 매치 검색 > 조회

	@ResponseBody
	@PostMapping("/teammatch")
	public List<TeamMatchDTO> teammatchList(String region, String possibleDate) {

		List<TeamMatchDTO> teammatchlist;

		if (region.equals("전체")) {
			teammatchlist = service.getAllTeamMatchList(possibleDate);
		} else {
			teammatchlist = service.getTeamMatchList(region, possibleDate);
		}

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

		String result = "";

		if (insertcount == 1) {
			result = "매치가 성공적으로 등록되었습니다.";
			// 나중에 경기정보로 이동하도록 하기
		} else {
			result = "매치 등록에 실패하였습니다. 다시 시도해주시길 바랍니다.";
		}

		mv.addObject("result", result);
		mv.setViewName("teammatch/registrationResult");

		return mv;
	}
}
