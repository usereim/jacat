package com.pro.jacat.apiData.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pro.jacat.apiData.service.ApiDataServiceImpl;

@Controller
@RequestMapping("/api")
public class ApiDataController {
	
	private final ApiDataServiceImpl apiDataService; 
	
	@Autowired
	public ApiDataController(ApiDataServiceImpl apiDataService) {
		this.apiDataService = apiDataService;
	}

	@RequestMapping(value = "/license-list", method = RequestMethod.GET)
	public String licenseList() {
		apiDataService.insertLicenseList();
		return "home";
	}
	
	@RequestMapping(value = "/license-test-date", method = RequestMethod.GET)
	public String licenseTestDate() {
		apiDataService.insertLicenseTestDate();
		return "home";
	}
	
	@RequestMapping(value = "/license-test-center", method = RequestMethod.GET)
	public String licenseTestCenter() {
		apiDataService.insertLicenseTestCenter();
		return "home";
	}
	
	@RequestMapping(value = "/license-eligibility", method = RequestMethod.GET)
	public String licenseEligibility() {
		apiDataService.insertLicenceEligibility();
		return "home";
	}
	
	
}
