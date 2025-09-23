package com.pro.jacat.mypage.response;

import java.util.List;

public class BoardResponse<T> {
	private int code;
	private List<T> boardList;
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public List<T> getBoardList() {
		return boardList;
	}
	public void setBoardList(List<T> boardList) {
		this.boardList = boardList;
	}
}
