package teammatch;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import penalty.PenaltyDTO;
import penalty.PenaltyService;
import soldier.SoldierDTO;
import team.TeamService;
import teammatchinfo.TeamMatchInfoService;
import user.UserDTO;

@Controller
public class TeamMatchController {
	@Autowired
	@Qualifier("teammatchservice")
	TeamMatchService service;
	
	@Autowired
	@Qualifier("teammatchinfoservice")
	TeamMatchInfoService service2;
	
	@Autowired
	@Qualifier("teamService")
	TeamService service3;

	@Autowired
	@Qualifier("penaltyService")
	PenaltyService service4;


	// 팀 매치 메인

	@RequestMapping("/teammatch")
	public ModelAndView match(String teamName, HttpServletRequest request) {
		PenaltyDTO penaltyTeam = service4.selectPenaltyTeam(teamName);
		
		int check;
		// 로그인 상태인지 확인을 한다.
		
		if (request.getSession().getAttribute("loginInfo") == null) {
			check = 0;
		}
		else {
			// 팀 주장인지 확인을 한다.
			
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO) session.getAttribute("loginInfo");
			String userId = user.getId(); // 유저 아이디		
			String teamId = service2.selectTeamId(teamName); // 유저가 속한 팀의 주장 아이디

			
			if (userId.equals(teamId)) {
				check = 1;
			}
			else {
				check = 0;
			}
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("check", check);
		mv.addObject("penaltyTeam", penaltyTeam);
		mv.setViewName("teammatch/teamMatch");
		
		return mv;
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
	public String matchform(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO) session.getAttribute("loginInfo");
		
		String teamId = service3.selectTeamId(user.getTeamName());
		UserDTO[] allMember = service3.selectAllMember(teamId);
		
		// 용병 리스트
		
		String teamName = user.getTeamName();
		List<SoldierDTO> soldierList = service.getSoldierList(teamName);
		
		request.setAttribute("allMember", allMember);
		request.setAttribute("soldierList", soldierList);
		request.setAttribute("teamId", teamId);
			
		return "teammatch/teamMatchRegistration";
	}

	@PostMapping("/registerTeammatch")
	public ModelAndView registermatch(TeamMatchDTO dto) {

		int insertcount = service.insertTeamMatch(dto);
		ModelAndView mv = new ModelAndView();

		String result = "";

		if (insertcount == 1) {
			result = "매치가 성공적으로 등록되었습니다.";
		
		} 
		
		else {
			result = "매치 등록에 실패하였습니다. 다시 시도해주시길 바랍니다.";
		}

		mv.addObject("result", result);
		mv.setViewName("teammatch/registrationResult");

		return mv;
	}
	
	
	// 팀 매치 신청
	
	@RequestMapping("/addTeammatch")
	public String addTeammatchForm(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO) session.getAttribute("loginInfo");
		
		String teamId = service3.selectTeamId(user.getTeamName());
		UserDTO[] allMember = service3.selectAllMember(teamId);
		
		// 용병 리스트
		
		String teamName = user.getTeamName();
		List<SoldierDTO> soldierList = service.getSoldierList(teamName);
		
		request.setAttribute("allMember", allMember);
		request.setAttribute("soldierList", soldierList);
		request.setAttribute("teamId", teamId);
		
		
		return "teammatch/addTeamMatchForm";
	}
	
	
	@PostMapping("/addTeammatch") 
	public ModelAndView addTeamMatch(String awayName, int seq, String homeName, String region, String possibleDate, String possibleTime, String homePlace, String awayPerson, String alarmDate) {
	  
	  ModelAndView mv = new ModelAndView();
	  
	  String result = "";
	  
	  int updatecount1 = service.updateAway(awayPerson, awayName, seq); 
	  int updatecount2 = service.updateRegistration(seq);
	  
	  if (updatecount1 == 1 && updatecount2 == 1) { 
		  result = "매치가 성공적으로 신청되었습니다.";
	  } 
	  else { 
		  result ="매치 신청에 실패하였습니다. 다시 시도해주시길 바랍니다."; 
	  }
	  
	  // 알림 
	  service.insertAlarm(homeName, awayName, region, possibleDate,possibleTime, homePlace, alarmDate);
	  
	  mv.setViewName("teammatch/registrationResult");
	  mv.addObject("result", result);
	  
	  return mv; 
	  
	 }
	
	
	// 팀 프로필
	
	@RequestMapping("/teamProfile")
	public String teamProfile(int seq, String teamName, HttpServletRequest request) {
		
		// 해당 팀 매치에 참여하는 선수
		
		String homePerson = service.getHomePerson(seq);
		
		homePerson = homePerson.substring(0, homePerson.length()-1);
		String[] name = homePerson.split(",");
		
		UserDTO[] teamMember = new UserDTO[name.length];
		
		
		for (int i=0; i<name.length; i++) {	
			
			teamMember[i] = service.selectTeamMember(name[i]);
			
		}
		
		request.setAttribute("teamMember", teamMember);
		request.setAttribute("teamName", teamName);
		
		return "teammatch/teamProfile";
	}
	 
	
	
}
