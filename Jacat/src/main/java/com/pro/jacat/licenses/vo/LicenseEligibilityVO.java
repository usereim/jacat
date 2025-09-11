package com.pro.jacat.licenses.vo;

//자격증 응시자격 테이블 VO
public class LicenseEligibilityVO {
	private String emqualCd;		//응시자격 코드
	private String emqualDispNm;	//응시자격 명
	private String grdCd;			//등급 코드
	private String grdNm;			//등급 명
	private String qualgbCd;		//자격구분 코드
	private String qualgbNm;		//자격구분 명
	
	public String getEmqualCd() {
		return emqualCd;
	}
	public void setEmqualCd(String emqualCd) {
		this.emqualCd = emqualCd;
	}
	public String getEmqualDispNm() {
		return emqualDispNm;
	}
	public void setEmqualDispNm(String emqualDispNm) {
		this.emqualDispNm = emqualDispNm;
	}
	public String getGrdCd() {
		return grdCd;
	}
	public void setGrdCd(String grdCd) {
		this.grdCd = grdCd;
	}
	public String getGrdNm() {
		return grdNm;
	}
	public void setGrdNm(String grdNm) {
		this.grdNm = grdNm;
	}
	public String getQualgbCd() {
		return qualgbCd;
	}
	public void setQualgbCd(String qualgbCd) {
		this.qualgbCd = qualgbCd;
	}
	public String getQualgbNm() {
		return qualgbNm;
	}
	public void setQualgbNm(String qualgbNm) {
		this.qualgbNm = qualgbNm;
	}
	
}
