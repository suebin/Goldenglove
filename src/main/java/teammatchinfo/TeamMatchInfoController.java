package teammatchinfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import teammatch.TeamMatchDTO;

@Controller
public class TeamMatchInfoController {
	@Autowired
	@Qualifier("teammatchinfoservice")
	TeamMatchInfoService service;
	
	// 경기 정보
	
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
	
	
	// 1. 수락을 기다리는 경기 > 수락하기 버튼
	
	@ResponseBody
	@RequestMapping("/teammatchAcceptance")
	public String teammatchAcceptance(int seq) {
		int updatecount = service.updateAcceptance(seq);
		
		String result = "";
		
		if(updatecount == 1) {
			result = "매치 수락이 완료되었습니다. 매치 시간을 준수해주시길 바랍니다.";
		}
		else {
			result = "매치 수락에 실패하였습니다. 다시 한 번 시도해주세요.";
		}
		
		return "{\"result\" : \"" + result + "\"}";
	}
	
	// 2. 등록한 경기 > 취소하기 버튼
	
	@ResponseBody
	@RequestMapping("/deleteTeammatchRegistration")
	public String deleteTeammatchRegistration(int seq) {
		int updatecount = service.deleteTeammatchRegistration(seq);
		
		String result = "";
		
		if(updatecount == 1) {
			result = "매치 취소가 완료되었습니다.";
		}
		else {
			result = "매치 취소에 실패하였습니다. 다시 한 번 시도해주세요.";
		}
		
		return "{\"result\" : \"" + result + "\"}";
	}
	
	// 3. 신청한 경기 > 취소하기 버튼
	
		@ResponseBody
		@RequestMapping("/deleteAddTeammatch")
		public String deleteAddTeammatch(int seq) {
			int updatecount = service.deleteAddTeammatch(seq);
			
			String result = "";
			
			if(updatecount == 1) {
				result = "매치 취소가 완료되었습니다.";
			}
			else {
				result = "매치 취소에 실패하였습니다. 다시 한 번 시도해주세요.";
			}
			
			return "{\"result\" : \"" + result + "\"}";
		}
		
		// 4. 예정된 경기 > 취소하기 버튼
		
		@ResponseBody
		@RequestMapping("/cancelTeammatch")
		public String cancelTeammatch(int seq) {
			int updatecount = service.cancelTeammatch(seq);
			
			String result = "";
			
			if(updatecount == 1) {
				result = "매치 취소가 완료되었습니다.";
			}
			else {
				result = "매치 취소에 실패하였습니다. 다시 한 번 시도해주세요.";
			}
			
			return "{\"result\" : \"" + result + "\"}";
		}
	
	


}
