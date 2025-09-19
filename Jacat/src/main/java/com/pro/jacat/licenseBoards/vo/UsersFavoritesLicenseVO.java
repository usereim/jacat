package com.pro.jacat.licenseBoards.vo;

import java.util.List;

import com.pro.jacat.licenses.vo.LicenseTestDateVO;

public class UsersFavoritesLicenseVO {
	private String usersId;
	private String licenseListJmcd;
	private String wDate;
	
	private List<LicenseTestDateVO> dateList;
	
	private String jmfldnm;
	
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
	public String getwDate() {
		return wDate;
	}
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	public List<LicenseTestDateVO> getDateList() {
		return dateList;
	}
	public void setDateList(List<LicenseTestDateVO> dateList) {
		this.dateList = dateList;
	}
	public String getJmfldnm() {
		return jmfldnm;
	}
	public void setJmfldnm(String jmfldnm) {
		this.jmfldnm = jmfldnm;
	}
}
