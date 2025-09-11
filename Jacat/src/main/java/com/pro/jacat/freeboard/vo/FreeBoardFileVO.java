package com.pro.jacat.freeboard.vo;

import java.sql.Date;

public class FreeBoardFileVO {
	private int fileNum;
	private int boardNum;
	private String realFileName;
	private String fileName;
	private String path;
	private Date wDate;
	private String type;
	
	public int getFileNum() {
		return fileNum;
	}
	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public String getRealFileName() {
		return realFileName;
	}
	public void setRealFileName(String realFileName) {
		this.realFileName = realFileName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public Date getwDate() {
		return wDate;
	}
	public void setwDate(Date wDate) {
		this.wDate = wDate;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}
