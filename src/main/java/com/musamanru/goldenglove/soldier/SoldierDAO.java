package com.musamanru.goldenglove.soldier;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("soldierDao")
public interface SoldierDAO {
    // 용병 검색 1 : 지역 전체, 포지션 전체, 날짜 X
    List<SoldierDTO> getDefaultSoldierList();

    // 용병 검색 2 : 지역 전체, 포지션 전체, 날짜 O
    List<SoldierDTO> getSoldierListByRegionAndPositionAndDate(String possibleDate);

    // 용병 검색 3 : 지역 전체, 날짜 X
    List<SoldierDTO> getSoldierListByRegion(String position);

    // 용병 검색 4 : 지역 전체, 날짜 O
    List<SoldierDTO> getSoldierListByRegionAndDate(String position, String possibleDate);

    // 용병 검색 5 : 포지션 전체, 날짜 X
    List<SoldierDTO> getSoldierListByPosition(String region);

    // 용병 검색 6 : 포지션 전체, 날짜 O
    List<SoldierDTO> getSoldierListByPositionAndDate(String region, String possibleDate);

    // 용병 검색 7 : 날짜 X
    List<SoldierDTO> getSoldierList(String region, String position);

    // 용병 검색 8 : 날짜 O
    List<SoldierDTO> getSoldierListByDate(String region, String position, String possibleDate);


    // 용병 등록
    int insertSoldier(SoldierDTO dto);

    int getMyLog(String soldierName, String possibleDate);

    // 용병 스카우트 제의 (팀 주장만)
    int updateMateTeam(int seq, String teams);

    String getExistingTeam(int seq);

    // 용병 로그
    List<SoldierDTO> selectMySoldierLog(String userName);

    List<SoldierDTO> selectOffer(String userName);

    List<SoldierDTO> selectOfferAcceptance(String userName, String userTeamName);

    List<SoldierDTO> selectOfferRequest(String userTeamName);

    // 용병 로그 (스카우트 제의 수락하기 버튼)
    int updateMateTeamAcceptance(int seq);

    int updateFinalMateTeam(int seq, String mateTeam);

    // 스카우트 제의 알림
    void requestScoutAlarm(String teamName, String soldierName);

    // 스카우트 수락 알림
    void acceptScoutAlarm(String teamName, String soldierName);
}
