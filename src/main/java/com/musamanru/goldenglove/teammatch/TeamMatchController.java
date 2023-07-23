package com.musamanru.goldenglove.teammatch;

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

import com.musamanru.goldenglove.penalty.PenaltyDTO;
import com.musamanru.goldenglove.penalty.PenaltyService;
import com.musamanru.goldenglove.soldier.SoldierDTO;
import com.musamanru.goldenglove.team.TeamService;
import com.musamanru.goldenglove.teammatchinfo.TeamMatchInfoService;
import com.musamanru.goldenglove.user.UserDTO;

@Controller
public class TeamMatchController {
    @Autowired
    @Qualifier("teamMatchService")
    TeamMatchService teamMatchService;

    @Autowired
    @Qualifier("teamMatchInfoService")
    TeamMatchInfoService teamMatchInfoService;

    @Autowired
    @Qualifier("teamService")
    TeamService teamService;

    @Autowired
    @Qualifier("penaltyService")
    PenaltyService penaltyService;

    // 팀 매치 메인
    @RequestMapping("/teammatch")
    public ModelAndView match(String teamName, HttpServletRequest request) {
        PenaltyDTO penaltyTeam = penaltyService.selectPenaltyTeam(teamName);
        UserDTO user = (UserDTO) request.getSession().getAttribute("loginInfo");
        String userId = user.getId(); // 유저 아이디
        String teamId = teamMatchInfoService.getTeamId(teamName); // 유저가 속한 팀의 주장 아이디
        int check = teamMatchService.isTeamLeader(userId, teamId);

        ModelAndView mv = new ModelAndView();
        mv.addObject("check", check);
        mv.addObject("penaltyTeam", penaltyTeam);
        mv.setViewName("teammatch/teamMatch");
        return mv;
    }

    // 팀 매치 검색 > 지역별 조회
    @ResponseBody
    @PostMapping("/teammatch")
    public List<TeamMatchDTO> teammatchList(String region, String possibleDate) {
        return teamMatchService.getTeamMatchList(region, possibleDate);
    }

    // 팀 매치 등록
    @RequestMapping("/registerTeammatch")
    public String registerMatchForm(HttpServletRequest request) {
        insertMatchForm(request);
        return "teammatch/teamMatchRegistration";
    }

    @PostMapping("/registerTeammatch")
    public ModelAndView registerTeamMatch(TeamMatchDTO dto) {
        String result = teamMatchService.registerTeamMatch(dto);
        ModelAndView mv = new ModelAndView();
        mv.addObject("result", result);
        mv.setViewName("teammatch/registrationResult");
        return mv;
    }

    // 팀 매치 신청
    @RequestMapping("/addTeammatch")
    public String applyTeamMatchForm(HttpServletRequest request) {
        insertMatchForm(request);
        return "teammatch/addTeamMatchForm";
    }

    @PostMapping("/addTeammatch")
    public ModelAndView applyTeamMatch(String awayName, int seq, String homeName, String region, String possibleDate, String possibleTime, String homePlace, String awayPerson, String alarmDate) {
        String result = teamMatchService
                .applyTeamMatch(awayPerson, awayName, seq, homeName, region, possibleDate, possibleTime, homePlace, alarmDate);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("teammatch/registrationResult");
        mv.addObject("result", result);
        return mv;
    }

    // 팀 프로필
    @RequestMapping("/teamProfile")
    public String teamProfile(int seq, String teamName, HttpServletRequest request) {
        // 해당 팀 매치에 참여하는 선수
        UserDTO[] playerList = teamMatchService.getPlayerList(seq);
        request.setAttribute("teamMember", playerList);
        request.setAttribute("teamName", teamName);
        return "teammatch/teamProfile";
    }

    private void insertMatchForm(HttpServletRequest request) {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("loginInfo");
        String teamId = teamService.selectTeamId(user.getTeamName());
        UserDTO[] allMember = teamService.selectAllMember(teamId);

        // 용병 리스트
        String teamName = user.getTeamName();
        List<SoldierDTO> soldierList = teamMatchService.getSoldierList(teamName);

        request.setAttribute("allMember", allMember);
        request.setAttribute("soldierList", soldierList);
        request.setAttribute("teamId", teamId);
    }
}