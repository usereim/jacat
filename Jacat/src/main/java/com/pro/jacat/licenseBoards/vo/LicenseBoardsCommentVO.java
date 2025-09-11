package com.pro.jacat.licenseBoards.vo;

public class LicenseBoardsCommentVO {
	private int commentNum;
	private int licenseBoardsBoardNum;
	private String usersId;
	private int parentComment;
	private String content;
	private String wDate;
	private String modifyDate;
	
	public int getCommentNum() {
		return commentNum;
	}
	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}
	public int getLicenseBoardsBoardNum() {
		return licenseBoardsBoardNum;
	}
	public void setLicenseBoardsBoardNum(int licenseBoardsBoardNum) {
		this.licenseBoardsBoardNum = licenseBoardsBoardNum;
	}
	public String getUsersId() {
		return usersId;
	}
	public void setUsersId(String usersId) {
		this.usersId = usersId;
	}
	public int getParentComment() {
		return parentComment;
	}
	public void setParentComment(int parentComment) {
		this.parentComment = parentComment;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getwDate() {
		return wDate;
	}
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	
	
}
