package soldier;

public class SoldierDTO {
	int seq;
	String region;
	String position;
	String possibleDate;
	String soldierName;
	String phone;
	String email;
	String teamName;
	String fileName;
	float winningRate;
	int winCount;
	int loseCount;
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getPossibleDate() {
		return possibleDate;
	}
	public void setPossibleDate(String possibleDate) {
		this.possibleDate = possibleDate;
	}
	public String getSoldierName() {
		return soldierName;
	}
	public void setSoldierName(String soldierName) {
		this.soldierName = soldierName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public float getWinningRate() {
		return winningRate;
	}
	public void setWinningRate(float winningRate) {
		this.winningRate = winningRate;
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
}
