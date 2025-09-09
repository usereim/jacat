package com.pro.jacat.noticeBoard;

import java.util.List;

import com.pro.jacat.file.vo.UserFileVO;
import com.pro.jacat.noticeBoard.fileVO.noticeBoardFileVO;
import com.pro.jacat.user.vo.UserVO;

public class NoticeBoardVO {
	private	int board_num;
	private String users_id;
	private String title;
	private String Content;
	private String w_date;
	private String modify_date;
	private String delyn;
	private String board_type;
	private List<noticeBoardFileVO> fileList;
	private UserVO user;
	
	public NoticeBoardVO(int board_num,String users_id,String title,String Content,String w_date,
			String modify_date,String delyn,String board_type) {
		this.board_num = board_num;
		this.users_id = users_id;
		this.title = title;
		this.Content = Content;
		this.w_date = w_date;
		this.modify_date = modify_date;
		this.delyn = delyn;
		this.board_type = board_type;
	}
	public NoticeBoardVO() {}
	
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
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}
	public String getW_date() {
		return w_date;
	}
	public void setW_date(String w_date) {
		this.w_date = w_date;
	}
	public String getModify_date() {
		return modify_date;
	}
	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}
	public String getDelyn() {
		return delyn;
	}
	public void setDelyn(String delyn) {
		this.delyn = delyn;
	}
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	public List<noticeBoardFileVO> getFileList() {
		return fileList;
	}
	public void setFileList(List<noticeBoardFileVO> fileList) {
		this.fileList = fileList;
	}
	public UserVO getUser() {
		return user;
	}
	public void setUser(UserVO user) {
		this.user = user;
	}
	
	
}
