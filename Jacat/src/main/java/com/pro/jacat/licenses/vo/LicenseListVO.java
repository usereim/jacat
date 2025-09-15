package com.pro.jacat.licenses.vo;

import java.util.List;

//�ڰ��� ����Ʈ ���̺� VO
public class LicenseListVO {
	private String jmcd;				//���� �ڵ�
	private String qualgbcd;			//�ڰݱ���
	private String qualgbnm;			//�ڰݱ��� ��
	private String seriescd;			//�迭 �ڵ�
	private String seriesnm;			//�迭 ��
	private String jmfldnm;				//���� ��
	private String obligfldcd;			//�������о� �ڵ�
	private String obligfldnm;			//�������о� ��
	private String mdobligfldcd;		//�������о� �ڵ�
	private String mdobligfldnm;		//�������о� ��
	private String licensingAutority;	//�ڰ��� ���
	
	private List<LicenseTestVO> lTest;
	
	private List<LicenseTestDateVO> lTestDate;
	
	public String getJmcd() {
		return jmcd;
	}
	public void setJmcd(String jmcd) {
		this.jmcd = jmcd;
	}
	public String getQualgbcd() {
		return qualgbcd;
	}
	public void setQualgbcd(String qualgbcd) {
		this.qualgbcd = qualgbcd;
	}
	public String getQualgbnm() {
		return qualgbnm;
	}
	public void setQualgbnm(String qualgbnm) {
		this.qualgbnm = qualgbnm;
	}
	public String getSeriescd() {
		return seriescd;
	}
	public void setSeriescd(String seriescd) {
		this.seriescd = seriescd;
	}
	public String getSeriesnm() {
		return seriesnm;
	}
	public void setSeriesnm(String seriesnm) {
		this.seriesnm = seriesnm;
	}
	public String getJmfldnm() {
		return jmfldnm;
	}
	public void setJmfldnm(String jmfldnm) {
		this.jmfldnm = jmfldnm;
	}
	public String getObligfldcd() {
		return obligfldcd;
	}
	public void setObligfldcd(String obligfldcd) {
		this.obligfldcd = obligfldcd;
	}
	public String getObligfldnm() {
		return obligfldnm;
	}
	public void setObligfldnm(String obligfldnm) {
		this.obligfldnm = obligfldnm;
	}
	public String getMdobligfldcd() {
		return mdobligfldcd;
	}
	public void setMdobligfldcd(String mdobligfldcd) {
		this.mdobligfldcd = mdobligfldcd;
	}
	public String getMdobligfldnm() {
		return mdobligfldnm;
	}
	public void setMdobligfldnm(String mdobligfldnm) {
		this.mdobligfldnm = mdobligfldnm;
	}
	public String getLicensingAutority() {
		return licensingAutority;
	}
	public void setLicensingAutority(String licensingAutority) {
		this.licensingAutority = licensingAutority;
	}
	
	public List<LicenseTestVO> getlTest() {
		return lTest;
	}
	public void setlTest(List<LicenseTestVO> lTest) {
		this.lTest = lTest;
	}
	
	public List<LicenseTestDateVO> getlTestDate() {
		return lTestDate;
	}
	public void setlTestDate(List<LicenseTestDateVO> lTestDate) {
		this.lTestDate = lTestDate;
	}
	
}
