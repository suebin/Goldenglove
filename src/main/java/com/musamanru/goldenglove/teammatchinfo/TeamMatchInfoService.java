package com.musamanru.goldenglove.teammatchinfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.musamanru.goldenglove.teammatch.TeamMatchDTO;

@Service("teamMatchInfoService")
public class TeamMatchInfoService {
    @Autowired
    @Qualifier("teamMatchInfoDao")
    private TeamMatchInfoDAO teamMatchInfoDAO;
    private static final String MATCH_SUCCESS_MESSAGE = "매치 수락이 완료되었습니다. 매치 시간을 준수해주시길 바랍니다.";
    private static final String MATCH_FAIL_MESSAGE = "매치 수락에 실패하였습니다. 다시 한 번 시도해주세요.";
    private static final String CANCEL_SUCCESS_MESSAGE = "매치 취소가 완료되었습니다.";
    private static final String CANCEL_FAIL_MESSAGE = "매치 취소에 실패하였습니다. 다시 한 번 시도해주세요.";
    private static final String UNAUTHORIZED_FAIL_MESSAGE = "본인이 속한 팀의 주장만 취소할 수 있습니다.";

    // 수락을 기다리는 경기
    public List<TeamMatchDTO> getUnmatchedTeamMatch(String myTeamName) {
        return teamMatchInfoDAO.getUnmatchedTeamMatch(myTeamName);
    }

    // 등록한 경기
    public List<TeamMatchDTO> getRegisteredTeamMatch(String myTeamName) {
        return teamMatchInfoDAO.getRegisteredTeamMatch(myTeamName);
    }

    // 신청한 경기
    public List<TeamMatchDTO> getAppliedTeamMatch(String myTeamName) {
        return teamMatchInfoDAO.getAppliedTeamMatch(myTeamName);
    }

    // 예정된 경기
    public List<TeamMatchDTO> getUpcomingTeamMatch(String myTeamName) {
        return teamMatchInfoDAO.getUpcomingTeamMatch(myTeamName);
    }

    // 지난 경기
    public List<TeamMatchDTO> getLastTeamMatch(String myTeamName) {
        return teamMatchInfoDAO.getLastTeamMatch(myTeamName);
    }

    // 1. 수락을 기다리는 경기 > 수락하기 버튼
    public String updateAcceptance(int seq, boolean isTeamLeader, String alarmDate) {
        String message;
        if (isTeamLeader) { // 유저가 팀의 주장인 경우 수락하기 버튼을 누를 수 있다.
            int result = teamMatchInfoDAO.updateAcceptance(seq);
            if (result == 1) {
                message = MATCH_SUCCESS_MESSAGE;
                updateMatchAlarm(seq, alarmDate);
            } else message = MATCH_FAIL_MESSAGE;
        } else {
            message = UNAUTHORIZED_FAIL_MESSAGE;
        }
        return message;
    }

    // 2. 등록한 경기 > 취소하기 버튼
    public String deleteTeamMatchRegistration(int seq, boolean isTeamLeader) {
        String message;
        if (isTeamLeader) { // 유저가 팀의 주장인 경우 취소하기 버튼을 누를 수 있다.
            int result = teamMatchInfoDAO.deleteTeamMatchRegistration(seq);
            if (result == 1) message = CANCEL_SUCCESS_MESSAGE;
            else message = CANCEL_FAIL_MESSAGE;
        } else {
            message = UNAUTHORIZED_FAIL_MESSAGE;
        }
        return message;
    }

    // 3. 신청한 경기 > 취소하기 버튼
    public String deleteAddTeamMatch(int seq, boolean isTeamLeader,
                                     String cancelTeam, String alarmDate) {
        String message;
        if (isTeamLeader) {
            int result = teamMatchInfoDAO.deleteAddTeamMatch(seq);
            if (result == 1) {
                message = CANCEL_SUCCESS_MESSAGE;
                updateCancelAlarm(seq, cancelTeam, alarmDate);
            } else message = CANCEL_FAIL_MESSAGE;
        } else {
            message = UNAUTHORIZED_FAIL_MESSAGE;
        }
        return message;
    }

    // 4. 예정된 경기 > 취소하기 버튼
    public String cancelTeamMatch(int seq, boolean isTeamLeader,
                                  String cancelTeam, String teamName,
                                  String alarmDate,
                                  boolean isPenalty) {
        String message;
        if (isTeamLeader) {
            int result = teamMatchInfoDAO.cancelTeamMatch(seq);
            if (result == 1) {
                message = CANCEL_SUCCESS_MESSAGE;
                updateCancelAlarm(seq, cancelTeam, alarmDate);
                if (isPenalty) teamMatchInfoDAO.insertPenalty(teamName);
            } else message = CANCEL_FAIL_MESSAGE;
        } else {
            message = UNAUTHORIZED_FAIL_MESSAGE;
        }
        return message;
    }

    // 승패 반영
    public void updateWinnerAndLoser(int seq, String myTeam,
                                     String team1, String team1User,
                                     String team2, String team2User,
                                     int result) {
        team1User = team1User.substring(0, team1User.length() - 1);
        team2User = team2User.substring(0, team2User.length() - 1);
        String[] team1Users = team1User.split(",");
        String[] team2Users = team2User.split(",");

        String[] myTeamUsers;
        String[] awayTeamUsers;
        String awayTeam;

        if (myTeam.equals(team1)) {
            myTeamUsers = team1Users;
            awayTeamUsers = team2Users;
            awayTeam = team2;
        } else {
            myTeamUsers = team2Users;
            awayTeamUsers = team2Users;
            awayTeam = team1;
        }

        if (result == 1) updateWinner(seq, myTeam, myTeamUsers, awayTeam, awayTeamUsers);
        else updateLoser(seq, myTeam, myTeamUsers, awayTeam, awayTeamUsers);
    }

    private void updateWinner(int seq,
                              String team1, String[] team1Users,
                              String team2, String[] team2Users) {
        teamMatchInfoDAO.updateWinner(seq, team1, team2);
        teamMatchInfoDAO.updateTeamWinCount(team1);
        teamMatchInfoDAO.updateTeamLoseCount(team2);

        for (String name : team1Users) {
            teamMatchInfoDAO.updateUserWinCount(name);
            teamMatchInfoDAO.updateUserWinningRate(name);
        }

        for (String name : team2Users) {
            teamMatchInfoDAO.updateUserLoseCount(name);
            teamMatchInfoDAO.updateUserWinningRate(name);
        }
    }

    private void updateLoser(int seq,
                             String team1, String[] team1Users,
                             String team2, String[] team2Users) {
        teamMatchInfoDAO.updateLoser(seq, team1, team2);
        teamMatchInfoDAO.updateTeamLoseCount(team1);
        teamMatchInfoDAO.updateTeamWinCount(team2);

        for (String name : team1Users) {
            teamMatchInfoDAO.updateUserLoseCount(name);
            teamMatchInfoDAO.updateUserWinningRate(name);
        }
        for (String name : team2Users) {
            teamMatchInfoDAO.updateUserWinCount(name);
            teamMatchInfoDAO.updateUserWinningRate(name);
        }
    }

    // 승률 반영
    public void updateTeamWinningRate(String team) {
        teamMatchInfoDAO.updateTeamWinningRate(team);
    }

    // 오늘의 매칭
    public List<TeamMatchDTO> getTodayMatching(String today) {
        return teamMatchInfoDAO.getTodayMatching(today);
    }

    public void updateCancelAlarm(int seq, String cancelTeam, String alarmDate) {
        teamMatchInfoDAO.insertAlarm(seq);
        teamMatchInfoDAO.updateCancelAlarm(seq, cancelTeam);
        teamMatchInfoDAO.updateAlarmDate(alarmDate);
    }

    public void updateMatchAlarm(int seq, String alarmDate) {
        teamMatchInfoDAO.insertAlarm(seq);
        teamMatchInfoDAO.updateAlarmDate(alarmDate);
    }

    public String getTeamId(String teamName) {
        return teamMatchInfoDAO.getTeamId(teamName);
    }
}
