package com.pro.jacat.licenses.vo;

//�ڰ��� �������� ���̺� VO
public class LicenseTestVO {
	private int licenseNum;		//�ڰ��� ���� �ڵ�
	private String jmcd;		//�ڰ��� ���� �ڵ�
	private String subjectName;	//���� ��
	private String testType;	//���� ����
	private String testCount;	//���� ��
	private String testVersion;	//�ʱ�/�Ǳ� ����
	private String testTime;	//���� �ð�
	
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