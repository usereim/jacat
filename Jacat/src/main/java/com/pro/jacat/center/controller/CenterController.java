package com.pro.jacat.center.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pro.jacat.center.service.CenterServiceImpl;
import com.pro.jacat.licenses.vo.LicenseTestCenterVO;

@Controller
public class CenterController {
	
	private final CenterServiceImpl centerService;
	
	public CenterController(CenterServiceImpl centerService) {
		this.centerService = centerService;
	}

	@RequestMapping(value = "/licenses/center/list", method = RequestMethod.GET)
	public String list() {
		
		return "center/list";
	}
	
	@PostMapping("/licenses/center/search")
	@ResponseBody
	public List<LicenseTestCenterVO> search(@RequestParam("keyword") String keyword) {
		if (keyword == null) {
			return null;
		}
		return centerService.selectLicenseTestCenterByKeyword(keyword);
	}
	
	@RequestMapping("/licenses/center/view/{addno}")
	public String view(@PathVariable("addno") int addno, Model model) {
		
		LicenseTestCenterVO vo = centerService.selectLicenseTestCenterOne(addno);
		
		model.addAttribute("center", vo)
;		return "center/view";
	}
}
