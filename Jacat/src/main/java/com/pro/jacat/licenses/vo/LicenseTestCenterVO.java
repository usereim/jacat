package com.pro.jacat.licenses.vo;

//자격증 별 시험장 테이블 VO
public class LicenseTestCenterVO {
	private int addno;				//관리 번호
	private String address;			//시험 장소
	private String brchCd;			//지사 코드
	private String brchNm;			//지사 명
	private String examAreaGbNm;	//시행장소 구분
	private String examAreaNm;		//시행장소 명
	private String plceLoctGid;		//장소위치 안내
	private String telNo;			//전화번호
	
	public int getAddno() {
		return addno;
	}
	public void setAddno(int addno) {
		this.addno = addno;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getBrchCd() {
		return brchCd;
	}
	public void setBrchCd(String brchCd) {
		this.brchCd = brchCd;
	}
	public String getBrchNm() {
		return brchNm;
	}
	public void setBrchNm(String brchNm) {
		this.brchNm = brchNm;
	}
	public String getExamAreaGbNm() {
		return examAreaGbNm;
	}
	public void setExamAreaGbNm(String examAreaGbNm) {
		this.examAreaGbNm = examAreaGbNm;
	}
	public String getExamAreaNm() {
		return examAreaNm;
	}
	public void setExamAreaNm(String examAreaNm) {
		this.examAreaNm = examAreaNm;
	}
	public String getPlceLoctGid() {
		return plceLoctGid;
	}
	public void setPlceLoctGid(String plceLoctGid) {
		this.plceLoctGid = plceLoctGid;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	
	
}
