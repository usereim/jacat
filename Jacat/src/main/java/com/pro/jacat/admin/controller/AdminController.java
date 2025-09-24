package com.pro.jacat.admin.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pro.jacat.user.vo.UserVO;

@Controller
@RequestMapping("/adminPage")
public class AdminController {
	
	@GetMapping("/main")
	public String main(HttpSession session) {
		if (session.getAttribute("user") == null) {
			return "redirect:/";
		} else {
			UserVO vo = (UserVO)session.getAttribute("user");
			String grade = vo.getGrade();
			
			if (!grade.equals("A")) {
				return "redirect:/";
			}
			
			return "admin/adminpage";
		}	
	}
}
