package com.pro.jacat.mypage.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pro.jacat.csc.vo.CscVO;
import com.pro.jacat.freeboard.vo.FreeBoardVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsVO;
import com.pro.jacat.licenseBoards.vo.UsersFavoritesLicenseVO;
import com.pro.jacat.mypage.response.BoardResponse;
import com.pro.jacat.mypage.service.MypageServiceImpl;
import com.pro.jacat.user.response.UserResponse;
import com.pro.jacat.user.service.UserServiceImpl;
import com.pro.jacat.user.vo.UserVO;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	private final UserServiceImpl userService;
	private final MypageServiceImpl mypageService;
	
	@Autowired
	public MypageController(UserServiceImpl userService, MypageServiceImpl mypageService) {
		this.userService = userService;
		this.mypageService = mypageService;
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
	
	@RequestMapping(value = "/view-user", method = RequestMethod.GET)
	public String viewUser(HttpSession session, Model model){
		if (session.getAttribute("user") == null) {
			return "redirect:/";
		}
		return "user/mypage";
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
	
	// ����� �ۼ� �����Խ��� ��� ��ȸ
	@PostMapping("/free-board")
	@ResponseBody
	public BoardResponse<FreeBoardVO> freeBoard(HttpSession session) {
		if (session.getAttribute("user") == null) {
			return null;
		} else {
			UserVO user = (UserVO)session.getAttribute("user");
			String id = user.getId();
			return mypageService.selectFreeBoardById(id);
		}
	}
	
	// ����� �ۼ� �ڰ��� �Խ��� ��� ��ȸ(qna, �ڷ��)
	@PostMapping("/license-board")
	@ResponseBody
	public BoardResponse<LicenseBoardsVO> licenseBoard(HttpSession session,
			@RequestParam("type") String type) {
		if (session.getAttribute("user") == null) {
			return null;
		} else {
			UserVO user = (UserVO)session.getAttribute("user");
			String id = user.getId();
			
			LicenseBoardsVO vo = new LicenseBoardsVO();
			vo.setUsersId(id);
			vo.setBoardType(type);
			return mypageService.selectLicenseBoards(vo);
		}	
	}
	
	// ����� �ۼ� 1:1 ���� �� ��� ��ȸ
	@PostMapping("/inquiry-board")
	@ResponseBody
	public BoardResponse<CscVO> inquiryBoard(HttpSession session,
			@RequestParam("type") String type) {
		if (session.getAttribute("user") == null) {
			return null;
		} else {
			UserVO user = (UserVO)session.getAttribute("user");
			String id = user.getId();
			
			CscVO vo = new CscVO();
			vo.setUsersId(id);
			vo.setBoardType(type);
			return mypageService.selectBoards(vo);
		}	
	}
	
	// ����� �Ű�� ��ȸ(�Ϲ�(����) �Խ���, �ڰ��� �Խ���)
	@PostMapping("/board-report")
	@ResponseBody
	public List<BoardResponse> boardReport(HttpSession session) {
		if (session.getAttribute("user") == null) {
			return null;
		} else {
			UserVO user = (UserVO)session.getAttribute("user");
			String id = user.getId();
			return mypageService.selectBoardReport(id);
		}
	}
	
	// ����� �����ڰ��� ����Ʈ ��ȸ
	@PostMapping("/favorite-license")
	@ResponseBody
	public List<UsersFavoritesLicenseVO> favoriteLicense(HttpSession session) {
		if (session.getAttribute("user") == null) {
			return null;
		} else {
			UserVO user = (UserVO)session.getAttribute("user");
			String id = user.getId();
			return mypageService.selectFavoritesLicense(id);
		}
	}
	
	@PostMapping("/cancle-favorite")
	@ResponseBody
	public String cancleFavorite(HttpSession session,
			@RequestParam("licenseListJmcd") String jmcd) {
		if (session.getAttribute("user") == null) {
			return null;
		} else {
			UserVO user = (UserVO)session.getAttribute("user");
			String id = user.getId();
			
			UsersFavoritesLicenseVO vo = new UsersFavoritesLicenseVO();
			vo.setUsersId(id);
			vo.setLicenseListJmcd(jmcd);
			
			int result = mypageService.deleteUserFavoritesLicense(vo);
			
			if (result == 0) {
				return "fail";
			} else if (result == 1) {
				return "success";
			}
			
			return null;
		}
		
		
	}
}

























