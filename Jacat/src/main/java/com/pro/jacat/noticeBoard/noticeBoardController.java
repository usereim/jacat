package com.pro.jacat.noticeBoard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/noticeBoard")

public class noticeBoardController {
	@Autowired
	public noticeBoardController(noticeBoardService noticeBoardService) {
		this.noticeBoardService = noticeBoardService;
	}
	@RequeatMappig
}


