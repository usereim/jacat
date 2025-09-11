package com.pro.jacat.apiData.service;

import java.net.URI;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.mysql.cj.x.protobuf.MysqlxDatatypes.Array;
import com.pro.jacat.apiData.repository.ApiDataRepository;
import com.pro.jacat.apiData.vo.licenseList.LicenseListResponse;
import com.pro.jacat.apiData.vo.licenseList.Response;
import com.pro.jacat.apiData.vo.licenseTestCenter.LicenseTestCenterResponse;
import com.pro.jacat.apiData.vo.licenseTestDate.LicenseTestDateResponse;
import com.pro.jacat.apiData.vo.licenseEligibility.LicenseEligibilityResponse;
import com.pro.jacat.apiData.vo.licenseList.Item;

@Service
public class ApiDataServiceImpl implements ApiDataService {
	private static final Logger logger = LoggerFactory.getLogger(ApiDataServiceImpl.class);
	
	private final RestTemplate restTemplate;
	private final ApiDataRepository apiDataRepository;
	
	@Autowired
	public ApiDataServiceImpl(RestTemplate restTemplate, ApiDataRepository apiDataRepository) {
		this.restTemplate = restTemplate;
		this.apiDataRepository = apiDataRepository;
	}

	@Override
	public String insertLicenseList() {
		URI uri = UriComponentsBuilder
				.fromHttpUrl("http://openapi.q-net.or.kr/api/service/rest/InquiryListNationalQualifcationSVC/getList")
				.queryParam("serviceKey", "17qav45bH5sOXG2U95qmEH%2Bsli2ekdvd6slwKOyuwfdmZdROK%2FhFPhZPwlpDF31V0xZu3Wrr0kbOqfnLp6XKtA%3D%3D")
				.build(false)
				.toUri();
		
		LicenseListResponse data = restTemplate.getForObject(uri, LicenseListResponse.class);
		
		List<Item> item = data.getResponse().getBody().getItems().getItem();
		
		apiDataRepository.insertLicenseList(item);
		
		return null;
	}

	@Override
	public String insertLicenseTestDate() {
		List<String> jmcdList = apiDataRepository.selectLicenseListJmcd();
		
		URI uri = null;
		for (String jmcd : jmcdList ) {
			uri = UriComponentsBuilder
					.fromHttpUrl("http://apis.data.go.kr/B490007/qualExamSchd/getQualExamSchdList")
					.queryParam("serviceKey", "17qav45bH5sOXG2U95qmEH%2Bsli2ekdvd6slwKOyuwfdmZdROK%2FhFPhZPwlpDF31V0xZu3Wrr0kbOqfnLp6XKtA%3D%3D")
					.queryParam("numOfRows", "50")
					.queryParam("pageNo", "1")
					.queryParam("dataFormat", "json")
					.queryParam("implYy", "2025")
					.queryParam("jmCd", jmcd)
					.build(true)
					.toUri();
			System.out.println(uri.toString());
			
			LicenseTestDateResponse data 
				= restTemplate.getForObject(uri, LicenseTestDateResponse.class);
			System.out.println(data);
			
			List<com.pro.jacat.apiData.vo.licenseTestDate.Item> itemList = data.getBody().getItems();
			if (itemList.size() <= 0) {
				continue;
			}
			
			for (com.pro.jacat.apiData.vo.licenseTestDate.Item item : itemList) {
				item.setJmcd(jmcd);
			}
			
			apiDataRepository.insertLicenseTestDate(itemList);
		}
		
		return null;
	}
	
	@Override
	public String insertLicenseTestCenter() {
		String[] brchCds = {"00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10",
				"11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"};
		
		URI uri = null;
		
		for (String brchCd : brchCds) {
			uri = UriComponentsBuilder
					.fromHttpUrl("http://openapi.q-net.or.kr/api/service/rest/InquiryExamAreaSVC/getList")
					.queryParam("ServiceKey", "17qav45bH5sOXG2U95qmEH%2Bsli2ekdvd6slwKOyuwfdmZdROK%2FhFPhZPwlpDF31V0xZu3Wrr0kbOqfnLp6XKtA%3D%3D")
					.queryParam("brchCd", brchCd)
					.queryParam("numOfRows", "10")
					.queryParam("pageNo", "1")
					.build(true)
					.toUri();
			logger.info(uri.toString());
			
			LicenseTestCenterResponse data = restTemplate.getForObject(uri, LicenseTestCenterResponse.class);
			List<com.pro.jacat.apiData.vo.licenseTestCenter.Item> itemList = data.getResponse().getBody().getItems().getItem(); 
			
			if (itemList.size() <= 0) {
				continue;
			}
			
			apiDataRepository.insertLicenseTestCenter(itemList);
		}
		
		return null;
	}

	@Override
	public String insertLicenceEligibility() {
		URI uri = UriComponentsBuilder
				.fromHttpUrl("http://openapi.q-net.or.kr/api/service/rest/InquiryExamQualItemSVC/getList")
				.queryParam("ServiceKey", "17qav45bH5sOXG2U95qmEH%2Bsli2ekdvd6slwKOyuwfdmZdROK%2FhFPhZPwlpDF31V0xZu3Wrr0kbOqfnLp6XKtA%3D%3D")
				.queryParam("pageNo", "1")
				.queryParam("numOfRows", "128")
				.build(true)
				.toUri();
		
		LicenseEligibilityResponse data = restTemplate.getForObject(uri, LicenseEligibilityResponse.class);
		List<com.pro.jacat.apiData.vo.licenseEligibility.Item> itemList = data.getResponse().getBody().getItems().getItem();
		
		apiDataRepository.insertLicenceEligibility(itemList);
		
		return null;
	}	
}



