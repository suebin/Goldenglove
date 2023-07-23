package com.musamanru.goldenglove.teammatchinfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.musamanru.goldenglove.teammatch.TeamMatchDTO;

@Mapper
@Repository("teamMatchInfoDao")
public interface TeamMatchInfoDAO {
    // 수락을 기다리는 경기
    List<TeamMatchDTO> getUnmatchedTeamMatch(String myTeamName);

    // 등록한 경기
    List<TeamMatchDTO> getRegisteredTeamMatch(String myTeamName);

    // 신청한 경기
    List<TeamMatchDTO> getAppliedTeamMatch(String myTeamName);

    // 예정된 경기
    List<TeamMatchDTO> getUpcomingTeamMatch(String myTeamName);

    // 지난 경기
    List<TeamMatchDTO> getLastTeamMatch(String myTeamName);

    // 승패 반영
    void updateLoser(int seq, String myTeam, String awayTeam);

    void updateWinner(int seq, String myTeam, String awayTeam);

    // 기본 팀 매칭 승률
    void updateTeamWinCount(String team);

    void updateTeamLoseCount(String team);

    void updateUserWinCount(String name);

    void updateUserLoseCount(String name);

    void updateTeamWinningRate(String team);

    void updateUserWinningRate(String name);

    // 유저 팀의 주장 Id 확인
    String getTeamId(String teamName);

    // 수락을 기다리는 경기 > 수락하기 버튼
    int updateAcceptance(int seq);

    // 등록한 경기 > 취소하기 버튼
    int deleteTeamMatchRegistration(int seq);

    // 신청한 경기 > 취소하기 버튼
    int deleteAddTeamMatch(int seq);

    // 예정된 경기 > 취소하기 버튼
    int cancelTeamMatch(int seq);

    // 알림 등록
    void insertAlarm(int seq);

    // 취소 시 null 된 awayName, cancel 한 팀 입력
    void updateCancelAlarm(int seq, String cancelTeam);

    // 수락/취소 알림 날짜 업데이트
    void updateAlarmDate(String alarmDate);

    // 오늘의 매칭
    List<TeamMatchDTO> getTodayMatching(String today);

    // 패널티 받는 팀 추가
    void insertPenalty(String teamName);
}
