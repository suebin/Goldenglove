package com.musamanru.goldenglove.teammatch;

public class TeamMatchDTO {
    int seq;
    String homeName;
    String awayName;
    String region;
    String possibleDate;
    String possibleTime;
    String homePlace;
    String winner;
    String loser;
    String homePerson;
    String awayPerson;

    // getter, setter
    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

    public String getHomeName() {
        return homeName;
    }

    public void setHomeName(String homeName) {
        this.homeName = homeName;
    }

    public String getAwayName() {
        return awayName;
    }

    public void setAwayName(String awayName) {
        this.awayName = awayName;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getPossibleDate() {
        return possibleDate;
    }

    public void setPossibleDate(String possibleDate) {
        this.possibleDate = possibleDate;
    }

    public String getPossibleTime() {
        return possibleTime;
    }

    public void setPossibleTime(String possibleTime) {
        this.possibleTime = possibleTime;
    }

    public String getHomePlace() {
        return homePlace;
    }

    public void setHomePlace(String homePlace) {
        this.homePlace = homePlace;
    }

    public String getWinner() {
        return winner;
    }

    public String getLoser() {
        return loser;
    }

    public String getHomePerson() {
        return homePerson;
    }

    public String getAwayPerson() {
        return awayPerson;
    }
}