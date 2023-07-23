package com.musamanru.goldenglove.teammatchinfo;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.musamanru.goldenglove.teammatch.TeamMatchDTO;
import com.musamanru.goldenglove.user.UserDTO;

@Controller
public class TeamMatchInfoController {
    @Autowired
    @Qualifier("teamMatchInfoService")
    private TeamMatchInfoService teamMatchInfoService;

    // 경기 정보
    @RequestMapping("/teammatchpage")
    public ModelAndView matchInfo(String myTeamName) {
        List<TeamMatchDTO> unmatchedTeamMatch = teamMatchInfoService.getUnmatchedTeamMatch(myTeamName); // 수락을 기다리는 경기
        List<TeamMatchDTO> registeredTeamMatch = teamMatchInfoService.getRegisteredTeamMatch(myTeamName); // 등록한 경기
        List<TeamMatchDTO> appliedTeamMatch = teamMatchInfoService.getAppliedTeamMatch(myTeamName); // 신청한 경기
        List<TeamMatchDTO> upcomingTeamMatch = teamMatchInfoService.getUpcomingTeamMatch(myTeamName); // 예정된 경기
        List<TeamMatchDTO> lastTeamMatch = teamMatchInfoService.getLastTeamMatch(myTeamName); // 지난 경기

        ModelAndView mv = new ModelAndView();
        mv.addObject("unMatchedTeamMatch", unmatchedTeamMatch);
        mv.addObject("registeredTeamMatch", registeredTeamMatch);
        mv.addObject("appliedTeamMatch", appliedTeamMatch);
        mv.addObject("upcomingTeamMatch", upcomingTeamMatch);
        mv.addObject("lastTeamMatch", lastTeamMatch);
        mv.setViewName("teammatchinfo/teammatchInfo");
        return mv;
    }

    // 1. 수락을 기다리는 경기 > 수락하기 버튼 (팀 주장만 할 수 있다.)
    @ResponseBody
    @RequestMapping("/teammatchAcceptance")
    public String teamMatchAcceptance(int seq, String alarmDate,
                                      String teamName, HttpServletRequest request) {
        String result = teamMatchInfoService
                .updateAcceptance(seq, isTeamLeader(request, teamName), alarmDate);
        return "{\"result\" : \"" + result + "\"}";
    }

    // 2. 등록한 경기 > 취소하기 버튼
    @ResponseBody
    @RequestMapping("/deleteTeammatchRegistration")
    public String deleteTeamMatchRegistration(int seq, String teamName, HttpServletRequest request) {
        String result = teamMatchInfoService
                .deleteTeamMatchRegistration(seq, isTeamLeader(request, teamName));
        return "{\"result\" : \"" + result + "\"}";
    }

    // 3. 신청한 경기 > 취소하기 버튼
    @ResponseBody
    @RequestMapping("/deleteAddTeammatch")
    public String deleteAddTeamMatch(int seq, String alarmDate, String cancelTeam,
                                     String teamName, HttpServletRequest request) {
        String result = teamMatchInfoService
                .deleteAddTeamMatch(seq, isTeamLeader(request, teamName), cancelTeam, alarmDate);
        return "{\"result\" : \"" + result + "\"}";
    }

    // 4. 예정된 경기 > 취소하기 버튼
    @ResponseBody
    @RequestMapping("/cancelTeammatch")
    public String cancelTeamMatch(int seq, String alarmDate,
                                  String cancelTeam, String teamName,
                                  HttpServletRequest request, boolean isPenalty) {
        String result = teamMatchInfoService
                .cancelTeamMatch(seq, isTeamLeader(request, teamName),
                        cancelTeam, teamName, alarmDate, isPenalty);
        return "{\"result\" : \"" + result + "\"}";
    }

    // 승패 선택
    @RequestMapping("/selectWinner")
    public String selectWinner() {
        return "teammatchinfo/selectWinner";
    }

    @PostMapping("/selectWinner")
    public ModelAndView selectWinnerResult(int seq, String myTeam,
                                           String team1, String team1_user,
                                           String team2, String team2_user, int result) {
        teamMatchInfoService.updateWinnerAndLoser(seq, myTeam, team1, team1_user, team2, team2_user, result);
        teamMatchInfoService.updateTeamWinningRate(team1);
        teamMatchInfoService.updateTeamWinningRate(team2);

        ModelAndView mv = new ModelAndView();
        mv.addObject("message", "승패 선택이 완료되었습니다.");
        mv.setViewName("teammatchinfo/selectWinnerResult");
        return mv;
    }

    // 오늘의 매칭
    @ResponseBody
    @RequestMapping("/mainMatching")
    public List<TeamMatchDTO> getTodayMatching(String today) {
        return teamMatchInfoService.getTodayMatching(today);
    }

    private boolean isTeamLeader(HttpServletRequest request, String teamName) {
        UserDTO user = (UserDTO) request.getSession().getAttribute("loginInfo");
        String userId = user.getId(); // 유저 아이디
        String teamId = teamMatchInfoService.getTeamId(teamName); // 유저가 속한 팀의 주장 아이디
        return userId.equals(teamId);
    }
}
