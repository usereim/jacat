package com.pro.jacat.freeboard.vo;


import java.util.List;

import com.pro.jacat.user.vo.UserVO;

public class FreeBoardVO {
	private int boardNum;
	private String usersId;
	private String title;
	private String content;
	private String wDate;
	private boolean delyn;
	private String boardType;
	private List<FreeBoardFileVO> filelist;
	private UserVO user;
	private int visit;
	private List<FreeBoardCommentVO> commentList;
	
	
	public List<FreeBoardCommentVO> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<FreeBoardCommentVO> commentList) {
		this.commentList = commentList;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public String getUsersId() {
		return usersId;
	}
	public void setUsersId(String usersId) {
		this.usersId = usersId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public boolean isDelyn() {
		return delyn;
	}
	public void setDelyn(boolean delyn) {
		this.delyn = delyn;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public List<FreeBoardFileVO> getFilelist() {
		return filelist;
	}
	public void setFilelist(List<FreeBoardFileVO> filelist) {
		this.filelist = filelist;
	}
	public UserVO getUser() {
		return user;
	}
	public void setUser(UserVO user) {
		this.user = user;
	}
	public int getVisit() {
		return visit;
	}
	public void setVisit(int visit) {
		this.visit = visit;
	}

	
	
	
}
