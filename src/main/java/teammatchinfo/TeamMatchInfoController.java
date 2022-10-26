package teammatchinfo;

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

import teammatch.TeamMatchDTO;
import user.UserDTO;

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
				
		 // 승패 선택
		List<TeamMatchDTO> teammatchlist6 = service.getTeamMatchList5(myTeamName);
		
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("teammatchlist1", teammatchlist1);
		mv.addObject("teammatchlist2", teammatchlist2);
		mv.addObject("teammatchlist3", teammatchlist3);
		mv.addObject("teammatchlist4", teammatchlist4);
		mv.addObject("teammatchlist5", teammatchlist5);
		
		mv.setViewName("teammatchinfo/teammatchInfo");
		
		return mv;
	}
	
	
	// 1. 수락을 기다리는 경기 > 수락하기 버튼 (팀 주장만 할 수 있다.)
	
	@ResponseBody
	@RequestMapping("/teammatchAcceptance")
	public String teammatchAcceptance(int seq, String alarmDate, String teamName, HttpServletRequest request) {
		
		// 팀 주장인지 확인을 한다.
		
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO) session.getAttribute("loginInfo");
		String userId = user.getId(); // 유저 아이디		
		String teamId = service.selectTeamId(teamName); // 유저가 속한 팀의 주장 아이디

		String result = "";

		// 유저가 팀의 주장인 경우 수락하기 버튼을 누를 수 있다.
		
		if (userId.equals(teamId)) {
			int updatecount = service.updateAcceptance(seq);
			
			if(updatecount == 1) {
				result = "매치 수락이 완료되었습니다. 매치 시간을 준수해주시길 바랍니다.";
			}
			else {
				result = "매치 수락에 실패하였습니다. 다시 한 번 시도해주세요.";
			}
		}
		else {
			result = "본인이 속한 팀의 주장만 수락할 수 있습니다.";
		}
		
		// 알림
		
		service.insertAlarm(seq);
		service.updateAlarmDate(alarmDate);
	
		
		return "{\"result\" : \"" + result + "\"}";
	}
	
	// 2. 등록한 경기 > 취소하기 버튼
	
	@ResponseBody
	@RequestMapping("/deleteTeammatchRegistration")
	public String deleteTeammatchRegistration(int seq, String teamName, HttpServletRequest request) {
		
		// 팀 주장인지 확인을 한다.
		
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO) session.getAttribute("loginInfo");
		String userId = user.getId(); // 유저 아이디		
		String teamId = service.selectTeamId(teamName); // 유저가 속한 팀의 주장 아이디

		String result = "";

		// 유저가 팀의 주장인 경우 취소하기 버튼을 누를 수 있다.
				
		if (userId.equals(teamId)) {
			int updatecount = service.deleteTeammatchRegistration(seq);
					
			if(updatecount == 1) {
				result = "매치 취소가 완료되었습니다.";
			}
			else {
				result = "매치 취소에 실패하였습니다. 다시 한 번 시도해주세요.";
			}
		}
		else {
			result = "본인이 속한 팀의 주장만 취소할 수 있습니다.";
		}
		
		return "{\"result\" : \"" + result + "\"}";
	}
	
	// 3. 신청한 경기 > 취소하기 버튼
	
		@ResponseBody
		@RequestMapping("/deleteAddTeammatch")
		public String deleteAddTeammatch(int seq, String alarmDate, String cancleTeam, String teamName, HttpServletRequest request) {
			
			// 팀 주장인지 확인을 한다.
			
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO) session.getAttribute("loginInfo");
			String userId = user.getId(); // 유저 아이디		
			String teamId = service.selectTeamId(teamName); // 유저가 속한 팀의 주장 아이디

			String result = "";

			// 유저가 팀의 주장인 경우 취소하기 버튼을 누를 수 있다.
					
			if (userId.equals(teamId)) {
				int updatecount = service.deleteAddTeammatch(seq);
				
				if(updatecount == 1) {
					result = "매치 취소가 완료되었습니다.";
				}
				else {
					result = "매치 취소에 실패하였습니다. 다시 한 번 시도해주세요.";
				}
				
			}
			else {
				result = "본인이 속한 팀의 주장만 취소할 수 있습니다.";
			}
			
			
			// 알림
			service.insertAlarm(seq);
			service.updateCancleAlarm(seq, cancleTeam);
			service.updateAlarmDate(alarmDate);
			
			return "{\"result\" : \"" + result + "\"}";
		}
		
		// 4. 예정된 경기 > 취소하기 버튼
		
		@ResponseBody
		@RequestMapping("/cancelTeammatch")
		public String cancelTeammatch(int seq, String alarmDate, String cancleTeam, String teamName, HttpServletRequest request, boolean penalty) {
			
			// 팀 주장인지 확인을 한다.
			
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO) session.getAttribute("loginInfo");
			String userId = user.getId(); // 유저 아이디		
			String teamId = service.selectTeamId(teamName); // 유저가 속한 팀의 주장 아이디

			String result = "";

			// 유저가 팀의 주장인 경우 취소하기 버튼을 누를 수 있다.
								
			if (userId.equals(teamId)) {
				int updatecount = service.cancelTeammatch(seq);
				
				if(updatecount == 1) {
					result = "매치 취소가 완료되었습니다.";
					
					// 경기일 7일 이내 경기 취소 시 패널티 추가
					if (penalty == true) {
						service.insertPenalty(teamName);
					}
				}
				else {
					result = "매치 취소에 실패하였습니다. 다시 한 번 시도해주세요.";
				}
							
			}
			else {
				result = "본인이 속한 팀의 주장만 취소할 수 있습니다.";
			}
			
			// 알림
			service.insertAlarm(seq);
			service.updateCancleAlarm(seq, cancleTeam);
			service.updateAlarmDate(alarmDate);
			
			
			return "{\"result\" : \"" + result + "\"}";
		}
		
		// 승패 선택
		
		@RequestMapping("/selectWinner")
		public String selectWinner() {
			return "teammatchinfo/selectWinner";
		}
		
		@PostMapping("/selectWinner")
		public ModelAndView selectWinnerResult(int seq, String myTeam, String team1, String team2, int result) {
			
			String message = "";
			
			// homeName 이 우리 팀일 경우

			if (myTeam.equals(team1)) {

				// 이긴 경우
				
				if (result == 1) {
					service.updateWinner(seq, team1, team2);
					
					service.updateTeamWinCount(team1);
					service.updateTeamLoseCount(team2);
					
					service.updateUserWinCount(team1);
					service.updateUserLoseCount(team2);
					
				}
				
				// 진 경우
				
				else if (result == 0) {
					service.updateLoser(seq, team1, team2);
					
					service.updateTeamLoseCount(team1);
					service.updateTeamWinCount(team2);
					
					service.updateUserLoseCount(team1);
					service.updateUserWinCount(team2);
					
				}
				
			}
			
			// awayName 이 우리 팀일 경우
			
			if (myTeam.equals(team2)) {
				
				// 이긴 경우
				
				if (result == 1) {
					service.updateWinner(seq, team2, team1);
					
					service.updateTeamWinCount(team2);
					service.updateTeamLoseCount(team1);
					
					service.updateUserWinCount(team2);
					service.updateUserLoseCount(team1);

				}
				
				// 진 경우
				
				else if (result == 0) {
					service.updateLoser(seq, team2, team1);
					
					service.updateTeamLoseCount(team2);
					service.updateTeamWinCount(team1);
					
					service.updateUserLoseCount(team2);
					service.updateUserWinCount(team1);

				}
			}
			
			service.updateTeamWinningRate(team1);
			service.updateUserWinningRate(team1);
			
			service.updateTeamWinningRate(team2);
			service.updateUserWinningRate(team2);
			
			ModelAndView mv = new ModelAndView();
			message = "승패 선택이 완료되었습니다.";
			mv.addObject("message", message);
			mv.setViewName("teammatchinfo/selectWinnerResult");
			
			return mv;
		}
		
		// 오늘의 매칭
		@ResponseBody
		@RequestMapping("/mainMatching")
		public List<TeamMatchDTO> getTodayMatching(String today) {
			List<TeamMatchDTO> list = service.getTodayMatching(today);
			return list;
		}

}
