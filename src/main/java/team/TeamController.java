package team;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import user.UserDTO;

@Controller
public class TeamController {
	@Autowired
	TeamService teamService;

//	팀원등록
	@ResponseBody
	@RequestMapping("/teamResult")
	public String teamResult(String teamDTO, HttpServletRequest request) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		TeamDTO dto = mapper.readValue(teamDTO, TeamDTO.class);

		HttpSession session = request.getSession();
		UserDTO user = teamService.insertTeam(dto);

		session.setAttribute("loginInfo", user);
		return "{\"result\":\"success\"}";
	}

//	팀 점보
	@RequestMapping("/teampage")
	public String teamPage(HttpServletRequest request) {
		if (request.getSession().getAttribute("loginInfo") == null) {
			return "main/main";
		} else {
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO) session.getAttribute("loginInfo");
			if (user.getTeamName() == null) {
				return "team/teamJoin";
			} else {
				return "team/teamPage";
			}
		}
	}

//	팀수정 폼
	@RequestMapping("/teamUpdate")
	public ModelAndView teamUpdate(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO) session.getAttribute("loginInfo");
		if (session.getAttribute("loginInfo") != null) {
			mv.addObject("teamDTO", teamService.selectTeam(user.getTeamName()));
			mv.setViewName("team/teamUpdate");
			return mv;
		} else {
			mv.setViewName("main/main");
			return mv;
		}
	}

	@ResponseBody
	@RequestMapping("/teamUpdateResult")
	public String teamUpdateResult(String teamDTO, HttpServletRequest request) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		TeamDTO dto = mapper.readValue(teamDTO, TeamDTO.class);

		HttpSession session = request.getSession();
		UserDTO user = teamService.updateTeam(dto);
		session.setAttribute("loginInfo", user);
		return "{\"result\":\"success\"}";
	}

//	중복검사
	@ResponseBody
	@RequestMapping("/teamNameCheck")
	public String teamNameCheck(String teamName) {
		int checkResult = teamService.selectTeamName(teamName);
		String result = "";
		if (checkResult > 0) {
			result = "이미 사용중입니다.";
		} else if (checkResult == 0) {
			result = "사용 가능합니다.";
		}
		return "{\"result\":\"" + result + "\"}";
	}

//	팀원추가 가입조회
	@ResponseBody
	@RequestMapping("/userCheck")
	public String userCheck(String id, String position) {
		UserDTO user = teamService.selectUser(id);
		String result = "";
		if (user == null) {
			result = "아이디를 확인해주세요.";
		} else if (user.getTeamName() != null) {
			result = "이미 가입된 팀이 존재합니다.";
		} else if (!user.getPosition().equals(position)) {
			result = "등록된 포지션이 다릅니다.";
		} else {
			result = user.getId();
		}
		return "{\"result\":\"" + result + "\"}";
	}
}
