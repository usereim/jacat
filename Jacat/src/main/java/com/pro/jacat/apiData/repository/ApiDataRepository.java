package com.pro.jacat.apiData.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.apiData.vo.licenseList.Item;

@Repository
public class ApiDataRepository {
	private final SqlSession template;
	
	@Autowired
	public ApiDataRepository(SqlSession template) {
		this.template = template;
	}

	public int insertLicenseList(List<Item> item) {
		return template.insert("apiDataMapper.insertLicenseList", item);
	}

	public List<String> selectLicenseListJmcd() {
		return template.selectList("apiDataMapper.selectLicenseListJmcd");
	}

	public int insertLicenseTestDate(List<com.pro.jacat.apiData.vo.licenseTestDate.Item> itemList) {
		return template.insert("apiDataMapper.insertLicenseTestDate", itemList);
		
	}

	public int insertLicenseTestCenter(
			List<com.pro.jacat.apiData.vo.licenseTestCenter.Item> itemList) {
		return template.insert("apiDataMapper.insertLicenseTestCenter", itemList);
	}

	public int insertLicenceEligibility(List<com.pro.jacat.apiData.vo.licenseEligibility.Item> itemList) {
		return template.insert("apiDataMapper.insertLicenceEligibility", itemList);
	}

}
