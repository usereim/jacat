package com.pro.jacat.csc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.csc.service.CscServiceImpl;
import com.pro.jacat.csc.vo.CscVO;
import com.pro.jacat.user.vo.UserVO;

@Controller
@RequestMapping("/csc")
public class CscController {
	private static final Logger logger = LoggerFactory.getLogger(CscController.class);
	
	private CscServiceImpl cscService;
	
	public CscController(CscServiceImpl cscService) {
		this.cscService = cscService;
	}
	
	@GetMapping("/main")
	public String main() {
		return "csc/cscmain";
	}
	
	@GetMapping("/tab/{type}")
	public String tab(@PathVariable("type") String type,
			Model model) {
		logger.info(type);

		if (type.equals("Q")) {
			List<CscVO> boardsList = cscService.selectBoardsAllByType(type);
			
			model.addAttribute("boardsList", boardsList);
			return "csc/faq";
		} else if (type.equals("I")) {
			return "csc/inquiry";
		} else if (type.equals("A")) {
			return "csc/appeal";
		}
		
		return "redirect:/csc/main";
	}
	
	@RequestMapping(value = "/write/{type}", method = RequestMethod.GET)
	public String write(@PathVariable("type") String type,
			Model model) {
		model.addAttribute("type", type);
		return "csc/write";
	}
	
	@RequestMapping(value = "/write/{type}", method = RequestMethod.POST)
	public String write(@PathVariable("type") String type, CscVO csc, HttpSession session,
			List<MultipartFile> file) {
		logger.info(type);
		UserVO user = null;
		
		if (session.getAttribute("user") != null) {
			user = (UserVO)session.getAttribute("user");
			if (user.getGrade().equals("G")) {
				return "redirect:/";
			}
		} else {
			return "redirect:/";
		}
		if (type == null) {
			return "redirect:/";
		}
		
		csc.setUsersId(user.getId());
		csc.setBoardType(type);
		
		cscService.insertBoardsOne(csc);
		
		return "redirect:/csc/tab/" + type;
	}
	
	@PostMapping("/view")
	@ResponseBody
	public CscVO view(@RequestParam("boardNum") Integer boardNum,
			@RequestParam("type") String type) {
		Map<String, Object> map = new HashMap<>();
		
		map.put("boardNum", boardNum);
		map.put("type", type);
		
		return cscService.selectBoardsOne(map);
	}
}
