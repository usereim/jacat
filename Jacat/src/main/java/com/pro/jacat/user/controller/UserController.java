package com.pro.jacat.user.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.user.response.UserResponse;
import com.pro.jacat.user.service.UserServiceImpl;
import com.pro.jacat.user.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	private final UserServiceImpl userService;
	
	@Autowired
	public UserController(UserServiceImpl userService) {
		this.userService = userService;
	}

	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup() {
		return "user/signup";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "user/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(UserVO user, HttpSession session) {
		if (session.getAttribute("suspend") != null) {
			session.removeAttribute("suspend");
		}
		if (session.getAttribute("id") != null) {
			session.removeAttribute("id");
		}
		
		UserVO userVO = userService.selectUsersOne(user);
		
		if (userVO == null) {
			return "redirect:/user/login";
		}
		
		session.setAttribute("user", userVO);
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
	
	@PostMapping("/id-check")
	@ResponseBody
	public UserResponse idCheck(@RequestParam("id") String id) {
		return userService.selectUsersCntById(id);
	}
	
	@PostMapping("/nick-check")
	@ResponseBody
	public UserResponse nickCheck(@RequestParam("nick") String nick) {
		return userService.selectUsersCntByNick(nick);
	}
	
	@PostMapping("/email-check")
	@ResponseBody
	public UserResponse emailCheck(@RequestParam("email") String email) {
		return userService.selectUsersCntByEmail(email);
	}
	
	@PostMapping("/idmail-check")
	@ResponseBody
	public UserResponse idEmailCheck(@RequestParam("id") String id,
			@RequestParam("email") String email) {
		UserVO user = new UserVO();
		user.setId(id);
		user.setEmail(email);
		
		return userService.selectUsersCntByIdEmail(user);
	}
	
	@PostMapping("/join")
	public String join(UserVO user,
			@RequestParam("profile") MultipartFile profile) {
		userService.insertUsersOne(user, profile);
		return "redirect:/user/login";
	}
	
	@PostMapping("/modify")
	public String modify(UserVO user,
			@RequestParam(required = false) MultipartFile profile,
			HttpSession session) {
		if (session.getAttribute("user") != null) {
			UserVO _user = (UserVO)session.getAttribute("user");
			user.setId(_user.getId());
		} else {
			return "redirect:/";
		}
	
		userService.updateUsers(user, profile);
		return "redirect:/mypage/view-user";
	}
	
	@RequestMapping(value = "/id-search", method = RequestMethod.GET)
	public String idSearch() {
		return "user/id_search";
	}
	
	@RequestMapping(value = "/id-search", method = RequestMethod.POST)
	@ResponseBody
	public String idSearch(@RequestParam("email") String email) {
		return userService.selectUsersIdByEmail(email);
	}
	
	@RequestMapping(value = "/pw-search", method = RequestMethod.GET)
	public String pwSearch() {
		return "user/pw_search";
	}
	
	@RequestMapping(value = "/pw-search", method = RequestMethod.POST)
	@ResponseBody
	public UserResponse pwSearch(UserVO user) {		
		return userService.updateUsersPwByEmail(user);
	}
	
	@RequestMapping(value = "/id-suspend", method = RequestMethod.POST)
	@ResponseBody
	public UserResponse idSuspend(@RequestParam("id") String id) {
		// 정지회원 grade 'S'
		return userService.selectUsersSuspendById(id);
	}
}
