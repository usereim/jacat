package com.pro.jacat.apiData.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pro.jacat.apiData.service.ApiDataServiceImpl;

@Controller
@RequestMapping("/api")
public class ApiDataController {
	
	private final ApiDataServiceImpl apiDataService; 
	
	@Autowired
	public ApiDataController(ApiDataServiceImpl apiDataService) {
		this.apiDataService = apiDataService;
	}

	@RequestMapping(value = "/license-list", method = RequestMethod.POST)
	@ResponseBody
	public String licenseList() {
		apiDataService.insertLicenseList();
		return "success";
	}
	
	@RequestMapping(value = "/license-test-date", method = RequestMethod.POST)
	@ResponseBody
	public String licenseTestDate() {
		apiDataService.deleteLicenseTestDate();
		apiDataService.insertLicenseTestDate();
		return "success";
	}
	
	@RequestMapping(value = "/license-test-center", method = RequestMethod.POST)
	@ResponseBody
	public String licenseTestCenter() {
		apiDataService.deleteLicenseTestCenter();
		apiDataService.insertLicenseTestCenter();
		return "success";
	}
	
	@RequestMapping(value = "/license-eligibility", method = RequestMethod.POST)
	@ResponseBody
	public String licenseEligibility() {
		apiDataService.insertLicenceEligibility();
		return "success";
	}
	
	
}
