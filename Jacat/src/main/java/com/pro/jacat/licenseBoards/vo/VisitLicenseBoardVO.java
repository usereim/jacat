package com.pro.jacat.licenseBoards.vo;

public class VisitLicenseBoardVO {
	private String usersId;
	private int licenseBoardNum;
	
	private int visitCount;
	
	public String getUsersId() {
		return usersId;
	}
	public void setUsersId(String usersId) {
		this.usersId = usersId;
	}
	public int getLicenseBoardNum() {
		return licenseBoardNum;
	}
	public void setLicenseBoardNum(int licenseBoardNum) {
		this.licenseBoardNum = licenseBoardNum;
	}
	public int getVisitCount() {
		return visitCount;
	}
	public void setVisitCount(int visitCount) {
		this.visitCount = visitCount;
	}
	
}
