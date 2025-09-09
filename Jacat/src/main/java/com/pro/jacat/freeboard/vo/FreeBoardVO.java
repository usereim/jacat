package com.pro.jacat.freeboard.vo;


import java.util.List;

import com.pro.jacat.user.vo.UserVO;

public class FreeBoardVO {
	private int board_num;
	private String users_id;
	private String title;
	private String content;
	private String w_date;
	private boolean delyn;
	private String board_type;
	private List<FreeBoardFileVO> filelist;
	private UserVO user;
	
	public FreeBoardVO(int board_num, String users_id, String title, String content, String w_date, 
			boolean delyn, String board_type) {
		this.board_num = board_num;
		this.users_id = users_id;
		this.title = title;
		this.content = content;
		this.w_date = w_date;
		this.delyn = delyn;
		this.board_type = board_type;
	}
	
	public FreeBoardVO() {}
	
	public int getBoard_num() {
		return board_num;
	}

	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}

	public String getUsers_id() {
		return users_id;
	}

	public void setUsers_id(String users_id) {
		this.users_id = users_id;
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

	public String getW_date() {
		return w_date;
	}

	public void setW_date(String w_date) {
		this.w_date = w_date;
	}

	public boolean isDelyn() {
		return delyn;
	}

	public void setDelyn(boolean delyn) {
		this.delyn = delyn;
	}

	public String getBoard_type() {
		return board_type;
	}

	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}

	public UserVO getUser() {
		return user;
	}

	public void setUser(UserVO user) {
		this.user = user;
	}

	
	
	
	
}
