package soldier;

import java.time.LocalDateTime;
import java.util.ArrayList;
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

import teammatchinfo.TeamMatchInfoService;
import user.UserDTO;

@Controller
public class SoldierController {
	@Autowired
	@Qualifier("soldierservice")
	SoldierService service;
	
	@Autowired
	@Qualifier("teammatchinfoservice")
	TeamMatchInfoService service2;
	
	
	// 용병 구하기 메인
	
	@RequestMapping("/getSoldier")
	public ModelAndView getSoldier() {
		
		// 전체 용병 리스트를 default 로 보여준다.
		
		List<SoldierDTO> defaultList = service.getSoldierList1();
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("defaultList", defaultList);
		mv.setViewName("soldier/getSoldier");
		return mv;
	}
	
	// 용병 검색
	
	@ResponseBody
	@PostMapping("/getSoldier")
	public List<SoldierDTO> soldierList(String region, String position, String possibleDate) {
		
		// 포지션 영문명(DB이름)으로 변경 
		
		if (position.equals("1루수")) {position = "firstBase";}
		if (position.equals("2루수")) {position = "secondBase";}
		if (position.equals("3루수")) {position = "thirdBase";}
		if (position.equals("포수")) {position = "catcher";}
		if (position.equals("투수")) {position = "pitcher";}
		if (position.equals("좌익수")) {position = "leftFielder";}
		if (position.equals("우익수")) {position = "rightFielder";}
		if (position.equals("중견수")) {position = "centerFielder";}
		if (position.equals("유격수")) {position = "shortStop";}
		
		
		// 용병 정보를 담은 list
		
		List<SoldierDTO> list;
		
		// 지역 전체, 포지션 전체인 경우
		
		if(region.equals("지역 전체") && position.equals("포지션 전체")) {
			
			// 날짜를 선택하지 않은 경우
			
			if (possibleDate == "") {
				list = service.getSoldierList1();
			}
			
			// 날짜 선택한 경우
			
			else {
				list = service.getSoldierList2(possibleDate);
			}
		}
		
		// 지역만 전체인 경우
		
		else if (region.equals("지역 전체") && !position.equals("포지션 전체")) {
			
			if (possibleDate == "") {
				list = service.getSoldierList3(position);
			}
			else {
				list = service.getSoldierList4(position, possibleDate);
			}
		}
		
		// 포지션만 전체인 경우
		
		else if (!region.equals("지역 전체") && position.equals("포지션 전체")) {
			if (possibleDate == "") {
				list = service.getSoldierList5(region);
			}
			else {
				list = service.getSoldierList6(region, possibleDate);
			}
		}
		
		// 특정한 지역과 포지션 둘 다 선택한 경우
		
		else {
			if (possibleDate == "") {
				list = service.getSoldierList7(region, position);
			}
			else {
				list = service.getSoldierList8(region, position, possibleDate);
			}
		}
		
		
		return list;
	}
	
	
	// 용병 등록
	
	@RequestMapping("/registerSoldier")
	public String soldierform() {
		return "soldier/soldierRegistration";
	}
	
	@PostMapping("/registerSoldier")
	public ModelAndView registerSoldier(SoldierDTO dto) {	
		
		// 오늘 날짜
		
		LocalDateTime now = LocalDateTime.now();
		int year = now.getYear();
		int month = now.getMonthValue();
		int day = now.getDayOfMonth();	
		
		// 선택한 날짜
		
		String date = dto.possibleDate;
		int myYear =  Integer.parseInt(date.substring(0, 4));
		int myMonth = Integer.parseInt(date.substring(6, 8));
		int myDay = Integer.parseInt(date.substring(10, 12));
		
		
		ModelAndView mv = new ModelAndView();
		
		// Model
	
		String result = "";
		String img = "";
		
		// 지나가지 않은 날짜만 선택 가능하다.
		
		if (myYear >= year && myMonth >= month && myDay >= day || myYear >= year && myMonth > month || myYear > year) {
			
			// 선택한 날짜에 이미 용병 등록한 적이 있는지 확인한다.
			
			int count = service.selectMylog(dto.soldierName, dto.possibleDate);
			
			// 선택한 날짜에 용병 등록한 적이 없는 경우
			
			if (count == 0) {
				int insertcount = service.insertSoldier(dto);
				
				// 용병 등록 성공
				
				if (insertcount == 1) {
					result = "용병 등록을 완료하였습니다.";
					img = "/Images/successIcon.png";
				}
				else {
					result = "용병 등록에 실패하였습니다. 다시 시도해주시길 바랍니다.";
					img = "/Images/retryIcon.png";
				}
			}
			
			// 선택한 날짜에 이미 용병 등록을 한 경우
			
			else {
				result = "선택한 날짜에 이미 용병 등록을 하셨습니다.";
				img = "/Images/retryIcon.png";
			}
			
		}
		
		// 지난 날짜를 선택한 경우
		
		else {
			result = "선택하신 날짜는 이미 지났습니다.";
			img = "/Images/retryIcon.png";
		}
		
		mv.addObject("result", result);
		mv.addObject("img", img);
		mv.setViewName("soldier/registrationResult");

		return mv;
	}
	
	// 용병 로그 
	
	@RequestMapping("/soldierLog")
	public ModelAndView soldierLog(HttpServletRequest request) {
		
		// 팀 주장인지 확인을 한다.
		
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO) session.getAttribute("loginInfo");
		String userId = user.getId(); // 유저 아이디	
		String userTeamName = user.getTeamName(); // 유저 팀 이름
		String teamId = service2.selectTeamId(userTeamName); // 유저가 속한 팀의 주장 아이디
		
		String userName = user.getName(); // 유저 이름
		
		List<SoldierDTO> list1 = service.selectMySoldierLog(userName); 
		List<SoldierDTO> list2 = service.selectOffer(userName);
		List<SoldierDTO> list3 = service.selectOfferAcceptance(userName, userTeamName);
		List<SoldierDTO> list4 = new ArrayList();
		
		if(userTeamName != null) {
			list4 = service.selectOfferRequest(userTeamName);
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list1", list1);
		mv.addObject("list2", list2);
		mv.addObject("list3", list3);
		mv.addObject("list4", list4);
		mv.addObject("teamId", teamId);
		mv.setViewName("soldier/soldierLog");
		
		return mv;
	}
	
	
	// 용병 스카우트 제의 (팀 주장만)
	
	@ResponseBody
	@RequestMapping("/addSoldier")
	public String addSoldier(int seq, String soldierTeamName, HttpServletRequest request, String soldierName) {
		
		// 팀 주장인지 확인을 한다.
		
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO) session.getAttribute("loginInfo");
		String userId = user.getId(); // 유저 아이디	
		String userTeamName = user.getTeamName(); // 유저 팀 이름
		String teamId = service2.selectTeamId(userTeamName); // 유저가 속한 팀의 주장 아이디
		
		String result = "";
		
		// 신청하려는 용병이 이미 자신의 팀원인 경우
		
		if (soldierTeamName.equals(userTeamName)) {
			result = "이미 같은 팀입니다.";
		}
		else {
			// 팀 주장인 경우
		
			if (userId.equals(teamId)) {
				
				String existingTeam = service.getExistingTeam(seq);
				String teams = "";
				
				if(existingTeam != null) {
					teams = " " + existingTeam + " " + userTeamName + ",";
				}
				else {
					teams = " " + userTeamName + ",";
				}
				
				int updateMateTeam = service.updateMateTeam(seq, teams);
			
			
				if(updateMateTeam == 1) {
					// 스카우트 제의 알림
					service.requestScoutAlarm(user.getTeamName(), soldierName);
					
					result = "스카우트 제의를 해당 용병에게 보냈습니다. 스카우트 제의 수락 여부는 용병 로그에서 확인해주세요.";
				}
				else {
					result = "스카우트 제의에 실패하였습니다. 다시 한 번 시도해주세요.";
				}
			}
		
			else {
				result = "본인이 속한 팀의 주장만 스카우트 제의를 할 수 있습니다.";
			}
		}
		
		
		return "{\"result\" : \"" + result + "\"}";
	}
	
	
	// 용병 로그 : 스카우트 제의 수락하기 버튼
	
		@ResponseBody
		@RequestMapping("/mateTeamAceptance")
		public String mateTeamAceptance(int seq, String mateTeam, String soldierName) {
			
			int updatecount1 = service.updateMateTeamAceptance(seq);
			int updatecount2 = service.updateFinalMateTeam(seq, mateTeam);
			
			// 스카우트 수락 알림
			service.acceptScoutAlarm(mateTeam, soldierName);

			String result="";
			
			if(updatecount1 == 1 && updatecount2 == 1) {
				result = "스카우트 제의 수락이 완료되었습니다. 팀 매칭 일정은 알림으로 알려드립니다.";
			}
			else {
				result = "스카우트 제의 수락에 실패하였습니다. 다시 한 번 시도해주세요.";
			}
			
			
			return "{\"result\" : \"" + result + "\"}";
		}
}
