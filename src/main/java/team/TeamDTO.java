package team;

import org.springframework.stereotype.Component;

@Component
public class TeamDTO {
	private String teamName, registerDate, firstBase, secondBase, thirdBase, catcher, pitcher, leftFielder,
			rightFielder, centerFielder, shortStop;
	private int teamId, winCount, loseCount;

	public String getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(String registerDate) {
		this.registerDate = registerDate;
	}

	public int getTeamId() {
		return teamId;
	}

	public void setTeamId(int teamId) {
		this.teamId = teamId;
	}

	public int getWinCount() {
		return winCount;
	}

	public void setWinCount(int winCount) {
		this.winCount = winCount;
	}

	public int getLoseCount() {
		return loseCount;
	}

	public void setLoseCount(int loseCount) {
		this.loseCount = loseCount;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public String getFirstBase() {
		return firstBase;
	}

	public void setFirstBase(String firstBase) {
		this.firstBase = firstBase;
	}

	public String getSecondBase() {
		return secondBase;
	}

	public void setSecondBase(String secondBase) {
		this.secondBase = secondBase;
	}

	public String getThirdBase() {
		return thirdBase;
	}

	public void setThirdBase(String thirdBase) {
		this.thirdBase = thirdBase;
	}

	public String getCatcher() {
		return catcher;
	}

	public void setCatcher(String catcher) {
		this.catcher = catcher;
	}

	public String getPitcher() {
		return pitcher;
	}

	public void setPitcher(String pitcher) {
		this.pitcher = pitcher;
	}

	public String getLeftFielder() {
		return leftFielder;
	}

	public void setLeftFielder(String leftFielder) {
		this.leftFielder = leftFielder;
	}

	public String getRightFielder() {
		return rightFielder;
	}

	public void setRightFielder(String rightFielder) {
		this.rightFielder = rightFielder;
	}

	public String getCenterFielder() {
		return centerFielder;
	}

	public void setCenterFielder(String centerFielder) {
		this.centerFielder = centerFielder;
	}

	public String getShortStop() {
		return shortStop;
	}

	public void setShortStop(String shortStop) {
		this.shortStop = shortStop;
	}

}
