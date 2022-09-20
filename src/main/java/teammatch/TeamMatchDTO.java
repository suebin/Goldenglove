package teammatch;

public class TeamMatchDTO {
	String teamName;
	String region;
	String possibleDate;
	String possibleTime;
	String homePlace;
	int headCount;
	String comment;
	
	// getter, setter
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
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
	public int getHeadCount() {
		return headCount;
	}
	public void setHeadCount(int headCount) {
		this.headCount = headCount;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	
}
