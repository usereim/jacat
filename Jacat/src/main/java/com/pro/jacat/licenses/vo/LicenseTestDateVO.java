package com.pro.jacat.licenses.vo;

//자격증 별 시험일정 테이블 VO
public class LicenseTestDateVO {
	private int ltdNum;				//관리번호
	private int implSeq;			//회차
	private String licenseListJmcd;	//종목 코드
	private String implYy;			//시행 년도
	private String description;		//설명
	private String docRegStartDt;	//필기 원서접수 시작일
	private String docRegEndDt;		//필기 원서접수 종료일
	private String docExamStartDt;	//필기 시험 시작일
	private String docExamEndDt;	//필기 시험 종료일
	private String docPassDt;		//필기 합격예정자 발표일
	private String pracRegStartDt;	//실기(작업) 원서접수 시작일
	private String pracRegEndDt;	//실기(작업) 원서접수 종료일
	private String pracExamStartDt;	//실기(작업) 시험 시작일
	private String pracExamEndDt;	//실기(작업) 시험 종료일
	private String pracPassDt;		//실기(작업) 합격자 발표일
	
	private String docRegStartVacancyDt;
	private String docRegEndVacancyDt;
	private String docExamStartVacancyDt;
	private String docExamEndVacancyDt;
	private String pracRegStartVacancyDt;
	private String pracRegEndVacancyDt;
	private String pracExamStartVacancyDt;
	private String pracExamEndVacancyDt;
	
	public int getLtdNum() {
		return ltdNum;
	}
	public void setLtdNum(int ltdNum) {
		this.ltdNum = ltdNum;
	}
	public int getImplSeq() {
		return implSeq;
	}
	public void setImplSeq(int implSeq) {
		this.implSeq = implSeq;
	}
	public String getLicenseListJmcd() {
		return licenseListJmcd;
	}
	public void setLicenseListJmcd(String licenseListJmcd) {
		this.licenseListJmcd = licenseListJmcd;
	}
	public String getImplYy() {
		return implYy;
	}
	public void setImplYy(String implYy) {
		this.implYy = implYy;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDocRegStartDt() {
		return docRegStartDt;
	}
	public void setDocRegStartDt(String docRegStartDt) {
		this.docRegStartDt = docRegStartDt;
	}
	public String getDocRegEndDt() {
		return docRegEndDt;
	}
	public void setDocRegEndDt(String docRegEndDt) {
		this.docRegEndDt = docRegEndDt;
	}
	public String getDocExamStartDt() {
		return docExamStartDt;
	}
	public void setDocExamStartDt(String docExamStartDt) {
		this.docExamStartDt = docExamStartDt;
	}
	public String getDocExamEndDt() {
		return docExamEndDt;
	}
	public void setDocExamEndDt(String docExamEndDt) {
		this.docExamEndDt = docExamEndDt;
	}
	public String getDocPassDt() {
		return docPassDt;
	}
	public void setDocPassDt(String docPassDt) {
		this.docPassDt = docPassDt;
	}
	public String getPracRegStartDt() {
		return pracRegStartDt;
	}
	public void setPracRegStartDt(String pracRegStartDt) {
		this.pracRegStartDt = pracRegStartDt;
	}
	public String getPracRegEndDt() {
		return pracRegEndDt;
	}
	public void setPracRegEndDt(String pracRegEndDt) {
		this.pracRegEndDt = pracRegEndDt;
	}
	public String getPracExamStartDt() {
		return pracExamStartDt;
	}
	public void setPracExamStartDt(String pracExamStartDt) {
		this.pracExamStartDt = pracExamStartDt;
	}
	public String getPracExamEndDt() {
		return pracExamEndDt;
	}
	public void setPracExamEndDt(String pracExamEndDt) {
		this.pracExamEndDt = pracExamEndDt;
	}
	public String getPracPassDt() {
		return pracPassDt;
	}
	public void setPracPassDt(String pracPassDt) {
		this.pracPassDt = pracPassDt;
	}
	public String getDocRegStartVacancyDt() {
		return docRegStartVacancyDt;
	}
	public void setDocRegStartVacancyDt(String docRegStartVacancyDt) {
		this.docRegStartVacancyDt = docRegStartVacancyDt;
	}
	public String getDocRegEndVacancyDt() {
		return docRegEndVacancyDt;
	}
	public void setDocRegEndVacancyDt(String docRegEndVacancyDt) {
		this.docRegEndVacancyDt = docRegEndVacancyDt;
	}
	
	
	public String getDocExamStartVacancyDt() {
		return docExamStartVacancyDt;
	}
	public void setDocExamStartVacancyDt(String docExamStartVacancyDt) {
		this.docExamStartVacancyDt = docExamStartVacancyDt;
	}
	public String getDocExamEndVacancyDt() {
		return docExamEndVacancyDt;
	}
	public void setDocExamEndVacancyDt(String docExamEndVacancyDt) {
		this.docExamEndVacancyDt = docExamEndVacancyDt;
	}
	public String getPracRegStartVacancyDt() {
		return pracRegStartVacancyDt;
	}
	public void setPracRegStartVacancyDt(String pracRegStartVacancyDt) {
		this.pracRegStartVacancyDt = pracRegStartVacancyDt;
	}
	public String getPracRegEndVacancyDt() {
		return pracRegEndVacancyDt;
	}
	public void setPracRegEndVacancyDt(String pracRegEndVacancyDt) {
		this.pracRegEndVacancyDt = pracRegEndVacancyDt;
	}
	public String getPracExamStartVacancyDt() {
		return pracExamStartVacancyDt;
	}
	public void setPracExamStartVacancyDt(String pracExamStartVacancyDt) {
		this.pracExamStartVacancyDt = pracExamStartVacancyDt;
	}
	public String getPracExamEndVacancyDt() {
		return pracExamEndVacancyDt;
	}
	public void setPracExamEndVacancyDt(String pracExamEndVacancyDt) {
		this.pracExamEndVacancyDt = pracExamEndVacancyDt;
	}
	
	
	
}
