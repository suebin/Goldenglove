package teammatchinfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import teammatch.TeamMatchDTO;

@Controller
public class TeamMatchInfoController {
	@Autowired
	@Qualifier("teammatchinfoservice")
	TeamMatchInfoService service;
	
	@RequestMapping("/teammatchpage")
	public ModelAndView matchInfo(String myTeamName) {
		
		// 수락을 기다리는 경기
		List<TeamMatchDTO> teammatchlist1 = service.getTeamMatchList1(myTeamName);
		
		// 등록한 경기
		List<TeamMatchDTO> teammatchlist2 = service.getTeamMatchList2(myTeamName);
		
		// 신청한 경기
		List<TeamMatchDTO> teammatchlist3 = service.getTeamMatchList3(myTeamName);
		
		// 예정된 경기
		List<TeamMatchDTO> teammatchlist4 = service.getTeamMatchList4(myTeamName);
		
		// 지난 경기
		List<TeamMatchDTO> teammatchlist5 = service.getTeamMatchList5(myTeamName);
				
		 
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("teammatchlist1", teammatchlist1);
		mv.addObject("teammatchlist2", teammatchlist2);
		mv.addObject("teammatchlist3", teammatchlist3);
		mv.addObject("teammatchlist4", teammatchlist4);
		mv.addObject("teammatchlist5", teammatchlist5);
		
		mv.setViewName("teammatchinfo/teammatchInfo");
		
		return mv;
	}
	
}
