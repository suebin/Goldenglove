package com.musamanru.goldenglove.teammatch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.musamanru.goldenglove.soldier.SoldierDTO;
import com.musamanru.goldenglove.user.UserDTO;

@Service("teamMatchService")
public class TeamMatchService {
    @Autowired
    @Qualifier("teamMatchDao")
    private TeamMatchDAO teamMatchDao;
    private static final String MATCH_REGISTER_SUCCESS_MESSAGE = "매치가 성공적으로 등록되었습니다.";
    private static final String MATCH_REGISTER_FAIL_MESSAGE = "매치 등록에 실패하였습니다. 다시 시도해주시길 바랍니다.";
    private static final String MATCH_APPLY_SUCCESS_MESSAGE = "매치가 성공적으로 신청되었습니다.";
    private static final String MATCH_APPLY_FAIL_MESSAGE = "매치 신청에 실패하였습니다. 다시 시도해주시길 바랍니다.";

    // 매치 등록
    public String registerTeamMatch(TeamMatchDTO dto) {
        String message;
        int result = teamMatchDao.insertTeamMatch(dto);
        if (result == 1) message = MATCH_REGISTER_SUCCESS_MESSAGE;
        else message = MATCH_REGISTER_FAIL_MESSAGE;
        return message;
    }

    // 스카우트 한 용병 리스트
    public List<SoldierDTO> getSoldierList(String teamName) {
        return teamMatchDao.getSoldierList(teamName);
    }

    // 매치 검색 > 지역별 조회
    public List<TeamMatchDTO> getTeamMatchList(String region, String possibleDate) {
        if (region.equals("전체")) return teamMatchDao.getAllTeamMatchList(possibleDate);
        return teamMatchDao.getTeamMatchList(region, possibleDate);
    }

    // 매치 신청
    public String applyTeamMatch(String awayPerson, String awayName, int seq,
                            String homeName, String region, String possibleDate,
                            String possibleTime, String homePlace, String alarmDate) {
        String message;
        int updateAwayResult = teamMatchDao.updateAway(awayPerson, awayName, seq);
        int updateRegistrationCount = teamMatchDao.updateRegistration(seq);

        if (updateAwayResult == 1 && updateRegistrationCount == 1) {
            message = MATCH_APPLY_SUCCESS_MESSAGE;
            teamMatchDao.insertAlarm(homeName, awayName, region, possibleDate,
                    possibleTime, homePlace, alarmDate);
        } else
            message = MATCH_APPLY_FAIL_MESSAGE;
        return message;
    }

    // 팀 프로필
    public UserDTO[] getPlayerList(int seq) {
        String homePlayer = teamMatchDao.getHomePerson(seq);
        homePlayer = homePlayer.substring(0, homePlayer.length() - 1);
        String[] name = homePlayer.split(",");
        UserDTO[] playerList = new UserDTO[name.length];

        for (int i = 0; i < name.length; i++) {
            playerList[i] = teamMatchDao.selectTeamMember(name[i]);
        }

        return playerList;
    }

    public int isTeamLeader(String userId, String teamId) {
        if (userId.equals(teamId)) return 1;
        return 0;
    }
}
