package com.pro.jacat.freeboard.vo;

import java.sql.Date;

import com.pro.jacat.user.vo.UserVO;

public class FreeBoardCommentVO {

	private int commentNum;
	private int boardNum;
	private String usersID;
	private String content;
	private Date wDate;
	private Date modifyDate;
	private boolean delyn;
	private UserVO users;
	private int parentCommentNum;
	
	
	public int getParentCommentNum() {
		return parentCommentNum;
	}
	public void setParentCommentNum(int parentCommentNum) {
		this.parentCommentNum = parentCommentNum;
	}
	public int getCommentNum() {
		return commentNum;
	}
	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public String getUsersID() {
		return usersID;
	}
	public void setUsersID(String usersID) {
		this.usersID = usersID;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getwDate() {
		return wDate;
	}
	public void setwDate(Date wDate) {
		this.wDate = wDate;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public boolean isDelyn() {
		return delyn;
	}
	public void setDelyn(boolean delyn) {
		this.delyn = delyn;
	}
	public UserVO getUsers() {
		return users;
	}
	public void setUsers(UserVO users) {
		this.users = users;
	}
	
}
