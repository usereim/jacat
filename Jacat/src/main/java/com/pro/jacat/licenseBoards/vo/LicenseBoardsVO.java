package com.pro.jacat.licenseBoards.vo;

import java.util.List;

import com.pro.jacat.user.vo.UserVO;

public class LicenseBoardsVO {
	private int boardNum;
	private String usersId;
	private String licenseListJmcd;
	private String title;
	private String content;
	private String wDate;
	private String modifyDate;
	private String delYN;
	private String boardType;
	
	private int visitCount;
	
	private String nick;
	
	private List<LicenseBoardsCommentVO> lComment;
	
	private List<FileLicenseBoardVO> lFile;

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

	public String getLicenseListJmcd() {
		return licenseListJmcd;
	}
	public void setLicenseListJmcd(String licenseListJmcd) {
		this.licenseListJmcd = licenseListJmcd;
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

	public String getDelYN() {
		return delYN;
	}
	public void setDelYN(String delYN) {
		this.delYN = delYN;
	}

	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}

	
	public int getVisitCount() {
		return visitCount;
	}
	public void setVisitCount(int visitCount) {
		this.visitCount = visitCount;
	}

	
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}

	
	public List<LicenseBoardsCommentVO> getlComment() {
		return lComment;
	}
	public void setlComment(List<LicenseBoardsCommentVO> lComment) {
		this.lComment = lComment;
	}

	
	public List<FileLicenseBoardVO> getlFile() {
		return lFile;
	}
	public void setlFile(List<FileLicenseBoardVO> lFile) {
		this.lFile = lFile;
	}
	
}
