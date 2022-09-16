package team;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

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
}
