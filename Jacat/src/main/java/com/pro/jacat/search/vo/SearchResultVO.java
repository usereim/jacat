package com.pro.jacat.search.vo;

import java.sql.Date;

public class SearchResultVO {
	private int boardNum ;
	private String jmcd;
	private String title;
	private String content;
	private String boardType;
	private String jmfldnm;
	
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public String getJmcd() {
		return jmcd;
	}
	public void setJmcd(String jmcd) {
		this.jmcd = jmcd;
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
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public String getJmfldnm() {
		return jmfldnm;
	}
	public void setJmfldnm(String jmfldnm) {
		this.jmfldnm = jmfldnm;
	}
	

}