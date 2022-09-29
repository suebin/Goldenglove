package team;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import user.UserDTO;

@Controller
public class TeamController {
	@Autowired
	TeamService teamService;

//	팀원등록 후 메인으로 이동
	@PostMapping("/teamResult")
	public String teamResult(TeamDTO dto) {
		teamService.insertTeam(dto);
		return "main/main";
	}

//	팀원수정 폼
	@RequestMapping("teamUpdate")
	public ModelAndView teamUpdate(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO) session.getAttribute("loginInfo");
		if (request.getSession().getAttribute("loginInfo") != null) {
			mv.addObject("teamDTO", teamService.selectTeam(user.getName()));
			mv.setViewName("team/teamUpdate");
			return mv;
		} else {
			mv.setViewName("main/main");
			return mv;
		}
	}

	@PostMapping("teamUpdateResult")
	public String teamUpdateResult(TeamDTO dto, HttpServletRequest request) {
		if (request.getSession().getAttribute("loginInfo") != null) {
			teamService.updateTeam(dto);
			return "mypage/myPage";
		} else {
			return "main/main";
		}
	}
}
