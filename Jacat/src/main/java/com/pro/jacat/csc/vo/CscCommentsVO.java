package com.pro.jacat.csc.vo;

public class CscCommentsVO {
	private int commentNum;
	private String usersId;
	private int boardsBoardNum;
	private int parentCommentNum;
	private String content;
	private String wDate;
	private String modifyDate;
	private String delyn;
	
	public int getCommentNum() {
		return commentNum;
	}
	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
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
	public int getParentCommentNum() {
		return parentCommentNum;
	}
	public void setParentCommentNum(int parentCommentNum) {
		this.parentCommentNum = parentCommentNum;
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
	public String getDelyn() {
		return delyn;
	}
	public void setDelyn(String delyn) {
		this.delyn = delyn;
	}
}
