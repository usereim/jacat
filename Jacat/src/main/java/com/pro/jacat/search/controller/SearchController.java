package com.pro.jacat.search.controller;

import java.lang.System.Logger;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.pro.jacat.licenses.vo.LicenseListVO;
import com.pro.jacat.search.service.SearchService;
import com.pro.jacat.search.vo.SearchResultVO;


@Controller
@RequestMapping("/search")
public class SearchController {
	
	@Autowired
	private SearchService searchService;
	
	@GetMapping("/result")
	public String search(@RequestParam("keyword") String keyword, Model model) {
		List<SearchResultVO> result = searchService.searchAll(keyword);
		model.addAttribute("result", result);
		model.addAttribute("keyword", keyword);
		return "search/searchResult";
	}
	

}
