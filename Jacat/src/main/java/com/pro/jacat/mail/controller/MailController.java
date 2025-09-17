package com.pro.jacat.mail.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pro.jacat.mail.service.MailService;

@Controller
@RequestMapping("/mail")
public class MailController {
	private static final Logger logger = LoggerFactory.getLogger(MailController.class);
	private final MailService mailService;
	
	@Autowired
	public MailController(MailService mailService) {
		this.mailService = mailService;
	}
	
	@PostMapping("/send-mail")
	@ResponseBody
	public String sendMail(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam("email") String email,
			HttpSession session) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		
		logger.info(email);
		
		String code = mailService.sendMail(email);
		session.setAttribute("code", code);
		
		return "success";
	}
	
	@PostMapping("/code-check")
	@ResponseBody
	public String codeCheck(@RequestParam("code") String code,
			HttpSession session) {
		String sessionCode = (String)session.getAttribute("code");
		
		logger.info(code);
		
		if (code.equals(sessionCode)) {
			session.removeAttribute("code");
			return "success";
		} else {
			return "fail";
		}
	}
}
