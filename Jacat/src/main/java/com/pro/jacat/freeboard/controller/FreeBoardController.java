package com.pro.jacat.freeboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pro.jacat.freeboard.service.FreeBoardService;

@Controller
@RequestMapping("/freeboard")
public class FreeBoardController {
	
	private final FreeBoardService freeboardService;
	
	@Autowired
	public FreeBoardController(FreeBoardService boardService) {
		this.freeboardService = boardService;
	}

}
