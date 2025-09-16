package com.pro.jacat.csc.vo;

import com.pro.jacat.file.vo.BoardsFileVO;

public class CscVO {
	private int boardNum;
	private String usersId;
	private String title;
	private String content;
	private String wDate;
	private String modifyDate;
	private String delyn;
	private String boardType;
	
	private BoardsFileVO boardsFile;
	
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
	public BoardsFileVO getBoardsFile() {
		return boardsFile;
	}
	public void setBoardsFile(BoardsFileVO boardsFile) {
		this.boardsFile = boardsFile;
	}
}
