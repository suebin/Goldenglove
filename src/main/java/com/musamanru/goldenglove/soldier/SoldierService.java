package com.musamanru.goldenglove.soldier;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("soldierService")
public class SoldierService {
    @Autowired
    @Qualifier("soldierDao")
    SoldierDAO soldierDao;

    public List<SoldierDTO> getDefaultSoldierList() {
        return soldierDao.getDefaultSoldierList();
    }

    public List<SoldierDTO> getSoldierList(String region, String position, String positionEnglish, String possibleDate) {
        List<SoldierDTO> soldierList;

        if (region.equals("지역 전체") && position.equals("포지션 전체")) { // 지역 전체, 포지션 전체인 경우
            if (possibleDate == "") soldierList = soldierDao.getDefaultSoldierList();
            else soldierList = soldierDao.getSoldierListByRegionAndPositionAndDate(possibleDate);
        } else if (region.equals("지역 전체") && !position.equals("포지션 전체")) { // 지역만 전체인 경우
            if (possibleDate == "") soldierList = soldierDao.getSoldierListByRegion(positionEnglish);
            else soldierList = soldierDao.getSoldierListByRegionAndDate(positionEnglish, possibleDate);
        } else if (!region.equals("지역 전체") && position.equals("포지션 전체")) { // 포지션만 전체인 경우
            if (possibleDate == "") soldierList = soldierDao.getSoldierListByPosition(region);
            else soldierList = soldierDao.getSoldierListByPositionAndDate(region, possibleDate);
        } else { // 특정한 지역과 포지션 둘 다 선택한 경우
            if (possibleDate == "") soldierList = soldierDao.getSoldierList(region, positionEnglish);
            else soldierList = soldierDao.getSoldierListByDate(region, positionEnglish, possibleDate);
        }
        return soldierList;
    }

    // 용병 등록
    public int insertSoldier(SoldierDTO dto) {
        return soldierDao.insertSoldier(dto);
    }

    public int getMyLog(String soldierName, String possibleDate) {
        return soldierDao.getMyLog(soldierName, possibleDate);
    }

    // 용병 스카우트 제의 (팀 주장만)
    public int updateMateTeam(int seq, String teams) {
        return soldierDao.updateMateTeam(seq, teams);
    }

    public String getExistingTeam(int seq) {
        return soldierDao.getExistingTeam(seq);
    }

    // 용병 로그
    public List<SoldierDTO> selectMySoldierLog(String userName) {
        return soldierDao.selectMySoldierLog(userName);
    }

    public List<SoldierDTO> selectOffer(String userName) {
        return soldierDao.selectOffer(userName);
    }

    public List<SoldierDTO> selectOfferAcceptance(String userName, String userTeamName) {
        return soldierDao.selectOfferAcceptance(userName, userTeamName);
    }

    public List<SoldierDTO> selectOfferRequest(String userTeamName) {
        return soldierDao.selectOfferRequest(userTeamName);
    }

    // 용병 로그 (스카우트 제의 수락하기 버튼)
    public int updateMateTeamAcceptance(int seq) {
        return soldierDao.updateMateTeamAcceptance(seq);
    }

    public int updateFinalMateTeam(int seq, String mateTeam) {
        return soldierDao.updateFinalMateTeam(seq, mateTeam);
    }

    // 스카우트 제의 알림
    public void requestScoutAlarm(String teamName, String soldierName) {
        soldierDao.requestScoutAlarm(teamName, soldierName);
    }

    // 스카우트 수락 알림
    public void acceptScoutAlarm(String teamName, String soldierName) {
        soldierDao.acceptScoutAlarm(teamName, soldierName);
    }
}
