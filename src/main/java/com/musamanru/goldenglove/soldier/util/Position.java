package com.musamanru.goldenglove.soldier.util;

public enum Position {
    FIRST_BASE("1루수", "firstBase"),
    SECOND_BASE("2루수", "secondBase"),
    THIRD_BASE("3루수", "thirdBase"),
    CATCHER("포수", "catcher"),
    PITCHER("투수", "pitcher"),
    LEFT_FIELDER("좌익수", "leftFielder"),
    RIGHT_FIELDER("우익수", "rightFielder"),
    CENTER_FIELDER("중견수", "centerFielder"),
    SHORT_STOP("유격수", "shortStop");

    private final String positionKorean;
    private final String positionEnglish;

    Position(String positionKorean, String positionEnglish) {
        this.positionKorean = positionKorean;
        this.positionEnglish = positionEnglish;
    }

    public String getPositionKorean() {
        return positionKorean;
    }

    public String getPositionEnglish() {
        return positionEnglish;
    }

    public static String getEnglishPositionFromKorean(String koreanPosition) {
        for (Position position : Position.values()) {
            if (position.getPositionKorean().equals(koreanPosition)) {
                return position.getPositionEnglish();
            }
        }
        return null;
    }
}
