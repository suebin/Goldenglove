package com.musamanru.goldenglove.penalty;

public class PenaltyDTO {
	int seq;
	String teamName, penaltyEndDate;
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getPenaltyEndDate() {
		return penaltyEndDate;
	}
	public void setPenaltyEndDate(String penaltyEndDate) {
		this.penaltyEndDate = penaltyEndDate;
	}
}