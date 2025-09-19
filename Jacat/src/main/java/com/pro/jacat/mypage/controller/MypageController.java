package com.pro.jacat.mypage.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pro.jacat.user.response.UserResponse;
import com.pro.jacat.user.service.UserServiceImpl;
import com.pro.jacat.user.vo.UserVO;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	private final UserServiceImpl userService;
	
	public MypageController(UserServiceImpl userService) {
		this.userService = userService;
	}

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String mypageMain(HttpSession session) {
		
		if (session.getAttribute("user") == null) {
			return "redirect:/";
		}
		
		return "user/mypage";
	}
	
	@RequestMapping(value = "/pw-cert", method = RequestMethod.GET)
	public String pwCert(HttpSession session) {
		if (session.getAttribute("user") == null) {
			return "redirect:/";
		}
		return "user/pw_cert";
	}
	
	@RequestMapping(value = "/pw-cert", method = RequestMethod.POST)
	@ResponseBody
	public UserResponse pwCert(UserVO user, HttpSession session) {
		if (session.getAttribute("user") == null) {
			return null;
		} else {
			user.setId(((UserVO)session.getAttribute("user")).getId());
		}
	
		return userService.selectUsersByPw(user);
	}
	
	@RequestMapping(value = "/view-user", method = RequestMethod.POST)
	@ResponseBody
	public UserVO viewUser(HttpSession session) {
		if (session.getAttribute("user") == null) {
			return null;
		} else {
			UserVO user = (UserVO)session.getAttribute("user");
			return userService.selectUsersOneForMypage(user);
		}
	}
	
	@RequestMapping(value = "/modify-user", method = RequestMethod.GET)
	public String modifyUser(HttpSession session, Model model) {
		if (session.getAttribute("user") == null) {
			return "redirect:/";
		}
		
		UserVO user = (UserVO)session.getAttribute("user");
		model.addAttribute("userVO", userService.selectUsersOneForMypage(user));
		
		return "user/modify_user";
	}
}
