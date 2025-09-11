package com.pro.jacat.licenses.vo;

//자격증 출제과목 테이블 VO
public class LicenseTestVO {
	private int licenseNum;		//자격증 과목 코드
	private String jmcd;		//자격증 종목 코드
	private String subjectName;	//과목 명
	private String testType;	//문제 형식
	private String testCount;	//문항 수
	private String testVersion;	//필기/실기 여부
	private String testTime;	//시험 시간
	
	public int getLicenseNum() {
		return licenseNum;
	}
	public void setLicenseNum(int licenseNum) {
		this.licenseNum = licenseNum;
	}
	public String getJmcd() {
		return jmcd;
	}
	public void setJmcd(String jmcd) {
		this.jmcd = jmcd;
	}
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public String getTestType() {
		return testType;
	}
	public void setTestType(String testType) {
		this.testType = testType;
	}
	public String getTestCount() {
		return testCount;
	}
	public void setTestCount(String testCount) {
		this.testCount = testCount;
	}
	public String getTestVersion() {
		return testVersion;
	}
	public void setTestVersion(String testVersion) {
		this.testVersion = testVersion;
	}
	public String getTestTime() {
		return testTime;
	}
	public void setTestTime(String testTime) {
		this.testTime = testTime;
	}
	
}