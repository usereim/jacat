package com.pro.jacat.freeboard.vo;

import java.sql.Date;

import com.pro.jacat.user.vo.UserVO;

public class FreeBoardReportVO {
	private int reportNum;
	private String usersId;
	private int boardsBoardNum;
	private Date reportDate;
	private String reportCategory;
	private String reportContent;
	private UserVO users;
	
	public int getReportNum() {
		return reportNum;
	}
	public void setReportNum(int reportNum) {
		this.reportNum = reportNum;
	}
	public String getUsersId() {
		return usersId;
	}
	public void setUsersId(String usersId) {
		this.usersId = usersId;
	}
	public int getBoardsBoardNum() {
		return boardsBoardNum;
	}
	public void setBoardsBoardNum(int boardsBoardNum) {
		this.boardsBoardNum = boardsBoardNum;
	}
	public Date getReportDate() {
		return reportDate;
	}
	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}
	public String getReportCategory() {
		return reportCategory;
	}
	public void setReportCategory(String reportCategory) {
		this.reportCategory = reportCategory;
	}
	public String getReportContent() {
		return reportContent;
	}
	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}
	public UserVO getUsers() {
		return users;
	}
	public void setUsers(UserVO users) {
		this.users = users;
	}
	
	
	
	
}
