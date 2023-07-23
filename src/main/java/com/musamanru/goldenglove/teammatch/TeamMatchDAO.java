package com.musamanru.goldenglove.teammatch;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.musamanru.goldenglove.soldier.SoldierDTO;
import com.musamanru.goldenglove.user.UserDTO;

@Mapper
@Repository("teamMatchDao")
public interface TeamMatchDAO {
    // 매치 등록
    int insertTeamMatch(TeamMatchDTO dto);

    List<SoldierDTO> getSoldierList(String teamName);

    // 매치 검색 > 지역별 조회
    List<TeamMatchDTO> getTeamMatchList(String region, String possibleDate);

    // 매치 검색 > 전체 지역 조회
    List<TeamMatchDTO> getAllTeamMatchList(String possibleDate);

    // 매치 신청
    int updateAway(String awayPerson, String awayName, int seq);

    int updateRegistration(int seq);

    // 팀 프로필
    String getHomePerson(int seq);

    UserDTO selectTeamMember(String name);

    // 알림
    int insertAlarm(String homeName, String awayName, String region, String possibleDate, String possibleTime, String homePlace, String alarmDate);
}
