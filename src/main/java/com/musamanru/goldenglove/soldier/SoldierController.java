package com.musamanru.goldenglove.soldier;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.musamanru.goldenglove.soldier.util.Position;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.musamanru.goldenglove.teammatchinfo.TeamMatchInfoService;
import com.musamanru.goldenglove.user.UserDTO;

@Controller
public class SoldierController {
    @Autowired
    @Qualifier("soldierService")
    SoldierService soldierService;

    @Autowired
    @Qualifier("teamMatchInfoService")
    TeamMatchInfoService teamMatchInfoService;


    // 용병 구하기 메인
    @RequestMapping("/getSoldier")
    public ModelAndView getSoldier() {
        List<SoldierDTO> defaultList = soldierService.getDefaultSoldierList(); // 일자가 지나지 않은 전체 용병 리스트 = default
        ModelAndView mv = new ModelAndView();
        mv.addObject("defaultList", defaultList);
        mv.setViewName("soldier/getSoldier");
        return mv;
    }

    // 용병 검색
    @ResponseBody
    @PostMapping("/getSoldier")
    public List<SoldierDTO> getSoldierList(String region, String position, String possibleDate) {
        String positionEnglish = Position.getEnglishPositionFromKorean(position); // db 저장 시 영문명
        return soldierService.getSoldierList(region, position, positionEnglish, possibleDate);
    }


    // 용병 등록
    @RequestMapping("/registerSoldier")
    public String soldierForm() {
        return "soldier/soldierRegistration";
    }

    @PostMapping("/registerSoldier")
    public ModelAndView registerSoldier(SoldierDTO dto) {
        LocalDateTime now = LocalDateTime.now();  // 오늘 날짜
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();

        String date = dto.possibleDate; // 선택한 날짜
        int myYear = Integer.parseInt(date.substring(0, 4));
        int myMonth = Integer.parseInt(date.substring(6, 8));
        int myDay = Integer.parseInt(date.substring(10, 12));

        String result;
        String img;

        // 지나가지 않은 날짜만 선택 가능하다.
        if (myYear >= year && myMonth >= month && myDay >= day || myYear >= year && myMonth > month || myYear > year) {
            int count = soldierService.getMyLog(dto.soldierName, dto.possibleDate); // 선택한 날짜에 이미 용병 등록한 적이 있는지 확인한다.
            if (count == 0) { // 선택한 날짜에 용병 등록한 적이 없는 경우
                int insertCount = soldierService.insertSoldier(dto);
                if (insertCount == 1) {
                    result = "용병 등록을 완료하였습니다.";
                    img = "/Images/successIcon.png";
                } else {
                    result = "용병 등록에 실패하였습니다. 다시 시도해주시길 바랍니다.";
                    img = "/Images/retryIcon.png";
                }
            } else {
                result = "선택한 날짜에 이미 용병 등록을 하셨습니다.";
                img = "/Images/retryIcon.png";
            }
        } else { // 지난 날짜를 선택한 경우
            result = "선택하신 날짜는 이미 지났습니다.";
            img = "/Images/retryIcon.png";
        }

        ModelAndView mv = new ModelAndView();
        mv.addObject("result", result);
        mv.addObject("img", img);
        mv.setViewName("soldier/registrationResult");
        return mv;
    }

    // 용병 로그
    @RequestMapping("/soldierLog")
    public ModelAndView getSoldierLog(HttpServletRequest request) {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("loginInfo");
        String userName = user.getName(); // 유저 이름
        String userTeamName = user.getTeamName(); // 유저 팀 이름
        String teamId = teamMatchInfoService.getTeamId(userTeamName); // 유저가 속한 팀 아이디

        List<SoldierDTO> list1 = soldierService.selectMySoldierLog(userName);
        List<SoldierDTO> list2 = soldierService.selectOffer(userName);
        List<SoldierDTO> list3 = soldierService.selectOfferAcceptance(userName, userTeamName);
        List<SoldierDTO> list4 = new ArrayList();

        if (userTeamName != null) list4 = soldierService.selectOfferRequest(userTeamName);

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
        String teamId = teamMatchInfoService.getTeamId(userTeamName); // 유저가 속한 팀의 주장 아이디

        String result;
        if (soldierTeamName.equals(userTeamName)) { // 신청하려는 용병이 이미 자신의 팀원인 경우
            result = "이미 같은 팀입니다.";
        } else {
            // 팀 주장인 경우
            if (userId.equals(teamId)) {
                String existingTeam = soldierService.getExistingTeam(seq);
                String teams = "";
                if (existingTeam != null) teams = " " + existingTeam + " " + userTeamName + ",";
                else teams = " " + userTeamName + ",";
                int updateMateTeam = soldierService.updateMateTeam(seq, teams);

                if (updateMateTeam == 1) {
                    soldierService.requestScoutAlarm(user.getTeamName(), soldierName);
                    result = "스카우트 제의를 해당 용병에게 보냈습니다. 스카우트 제의 수락 여부는 용병 로그에서 확인해주세요.";
                } else {
                    result = "스카우트 제의에 실패하였습니다. 다시 한 번 시도해주세요.";
                }
            } else {
                result = "본인이 속한 팀의 주장만 스카우트 제의를 할 수 있습니다.";
            }
        }

        return "{\"result\" : \"" + result + "\"}";
    }


    // 용병 로그 : 스카우트 제의 수락하기 버튼
    @ResponseBody
    @RequestMapping("/mateTeamAceptance")
    public String mateTeamAcceptance(int seq, String mateTeam, String soldierName) {
        int updateCount1 = soldierService.updateMateTeamAcceptance(seq);
        int updateCount2 = soldierService.updateFinalMateTeam(seq, mateTeam);
        soldierService.acceptScoutAlarm(mateTeam, soldierName);

        String result;
        if (updateCount1 == 1 && updateCount2 == 1)
            result = "스카우트 제의 수락이 완료되었습니다. 팀 매칭 일정은 알림으로 알려드립니다.";
        else
            result = "스카우트 제의 수락에 실패하였습니다. 다시 한 번 시도해주세요.";

        return "{\"result\" : \"" + result + "\"}";
    }
}
