package com.pro.jacat.noticeBoard.vo;

import java.util.List;

import com.pro.jacat.user.vo.UserVO;

public class NoticeBoardVO {
	private	int boardNum;
	private String usersId;
	private String title;
	private String content;
	private String wDate;
	private String modifyDate;
	private String delyn;
	private String boardType;
	private List<NoticeBoardFileVO> fileList;
	private UserVO user;
	
	public NoticeBoardVO(int boardNum,String usersId,String title,String content,String wDate,
			String modifyDate,String delyn,String boardType) {
		this.boardNum = boardNum;
		this.usersId = usersId;
		this.title = title;
		this.content = content;
		this.wDate = wDate;
		this.modifyDate = modifyDate;
		this.delyn = delyn;
		this.boardType = boardType;
	}
	public NoticeBoardVO() {}
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
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public List<NoticeBoardFileVO> getFileList() {
		return fileList;
	}
	public void setFileList(List<NoticeBoardFileVO> fileList) {
		this.fileList = fileList;
	}
	public UserVO getUser() {
		return user;
	}
	public void setUser(UserVO user) {
		this.user = user;
	}
	
	
}
