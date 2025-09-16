package com.pro.jacat.csc.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.pro.jacat.csc.vo.CscCommentsVO;
import com.pro.jacat.csc.vo.CscVO;
import com.pro.jacat.file.service.FileService;
import com.pro.jacat.user.vo.UserVO;

@Controller
@RequestMapping("/csc")
public class CscController {
	private static final Logger logger = LoggerFactory.getLogger(CscController.class);

	private CscServiceImpl cscService;
	private FileService fileService;

	@Autowired
	public CscController(CscServiceImpl cscService, FileService fileService) {
		this.cscService = cscService;
		this.fileService = fileService;
	}

	@GetMapping("/main")
	public String main() {
		return "csc/cscmain";
	}

	@GetMapping("/tab/{type}")
	public String tab(@PathVariable("type") String type, Model model,
			HttpSession session) {
		logger.info(type);

		if (type.equals("Q")) {
			CscVO csc = new CscVO();
			csc.setBoardType("Q");
			List<CscVO> boardsList = cscService.selectBoardsAll(csc);

			model.addAttribute("boardsList", boardsList);
			return "csc/faq";
		} else if (type.equals("I")) {
			UserVO user = (UserVO)session.getAttribute("user");
			if (user == null) {
				return "redirect:/csc/main";
			} else {
				CscVO csc = new CscVO();
				csc.setUsersId(user.getId());
				csc.setBoardType("I");
				List<CscVO> boardsList = cscService.selectBoardsAll(csc);
				
				model.addAttribute("boardsList", boardsList);
				return "csc/inquiry";
			}
			
		} else if (type.equals("A")) {
			UserVO user = (UserVO)session.getAttribute("user");
			if (user != null) {
				return "redirect:/csc/main";
			}
			return "csc/appeal";
		}

		return "redirect:/csc/main";
	}

	@RequestMapping(value = "/write/{type}", method = RequestMethod.GET)
	public String write(@PathVariable("type") String type, Model model) {
		model.addAttribute("type", type);
		return "csc/write";
	}

	@RequestMapping(value = "/write/{type}", method = RequestMethod.POST)
	public String write(@PathVariable("type") String type, CscVO csc, HttpSession session,
			@RequestParam("img") MultipartFile file) throws IllegalStateException, IOException {
		logger.info(type);
		UserVO user = null;

		if (type == null) {
			return  "redirect:/";
		}
		if (session.getAttribute("user") != null) {
			user = (UserVO) session.getAttribute("user");
			if (type.equals("Q") && user.getGrade().equals("G")) {
				return "redirect:/";
			}
		} else {
			return "redirect:/";
		}
	
		csc.setUsersId(user.getId());
		csc.setBoardType(type);

		int result = cscService.insertBoardsOne(csc);
		int bno = csc.getBoardNum();
		String subPath = "boards/" + bno + "/";
		logger.info("" + bno);
		if (result > 0) {
			try {
				fileService.uploadFile(file, subPath, bno);
			} catch (IllegalStateException e) {
				
			}
		}

		return "redirect:/csc/tab/" + type;
	}
	
	@RequestMapping(value = "/view/{type}/{boardsNum}", method = RequestMethod.GET)
	public String view(@PathVariable("boardsNum") int boardsNum,
			@PathVariable("type") String type,
			Model model) {
		logger.info("boardsNum : {}", boardsNum);
		CscVO csc = new CscVO();
		
		csc.setBoardNum(boardsNum);
		csc.setBoardType(type);
		
		CscVO cscVO = cscService.selectBoardsOne(csc);
		model.addAttribute("board", cscVO);
		return "csc/view";
	}

	@RequestMapping(value = "/view", method = RequestMethod.POST)
	@ResponseBody
	public CscVO view(@RequestParam("boardNum") int boardNum, @RequestParam("type") String type) {
		
		CscVO csc = new CscVO();
		csc.setBoardNum(boardNum);
		csc.setBoardType(type);
		
		return cscService.selectBoardsOne(csc);
	}

	@RequestMapping(value = "/modify/{type}/{boardNum}", method = RequestMethod.GET)
	public String modify(@PathVariable("type") String type, @PathVariable("boardNum") int boardNum, Model model) {
		
		CscVO cscVO = new CscVO();

		cscVO.setBoardNum(boardNum);
		cscVO.setBoardType(type);

		CscVO csc = cscService.selectBoardsOne(cscVO);
		if (csc != null) {
			model.addAttribute("csc", csc);
		}
		return "csc/modify";
	}

	@RequestMapping(value = "/modify/{type}/{delete}/{boardNum}", method = RequestMethod.POST)
	public String modify(CscVO csc, @RequestParam("img") MultipartFile file, @PathVariable("delete") String delete,
			@PathVariable("boardNum") int boardNum,
			@PathVariable("type") String type)
			throws IllegalStateException, IOException {
		csc.setBoardNum(boardNum);
		csc.setBoardType(type);
		
		cscService.updateBoards(csc);
		
		if (delete.equals("false")) {
			if (!file.isEmpty()) {
				// 이미지가 원래 없었는데 새로 추가
				String subPath = "boards/" + boardNum + "/";
				fileService.uploadFile(file, subPath, boardNum);
			} else {
				// 이미지 변경사항 없음
			}
		} else if (delete.equals("true")) {
			if (!file.isEmpty()) {
				// 이미지가 원래 있었고 삭제 후 새로 추가
				String subPath = "boards/" + boardNum + "/";
				fileService.deleteFile(file, subPath, boardNum);
			} else {
				logger.info("file delete");
				// 이미지 삭제
				String subPath = "boards/" + boardNum + "/";
				fileService.deleteFile(file, subPath, boardNum);
			}
		}

		return "redirect:/csc/tab/Q";
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String delete(CscVO csc) {
		logger.info("boardNum : {}", csc.getBoardNum());
		logger.info("boardType : {}", csc.getBoardType());
		
		cscService.deleteBoards(csc);
		
		return "delete success";
	}
	
	@PostMapping("/add-reply")
	@ResponseBody
	public List<CscCommentsVO> addReply(CscCommentsVO cscCommentsVO) {
		logger.info("comment content : {}", cscCommentsVO.getContent());
		logger.info("comment usersId : {}", cscCommentsVO.getUsersId());
		logger.info("commnet boardsBoardNum : {}", cscCommentsVO.getBoardsBoardNum());
		
		int result = cscService.insertComments(cscCommentsVO);
	
		List<CscCommentsVO> comments = cscService.selectCommentsAll(cscCommentsVO.getBoardsBoardNum());
		
		return comments;
	}
	
	@PostMapping("/view-reply")
	@ResponseBody
	public List<CscCommentsVO> viewReply(@RequestParam("boardNum") int boardNum) {
		
		return cscService.selectCommentsAll(boardNum);
	}
	
	@PostMapping("/delete-reply")
	@ResponseBody
	public List<CscCommentsVO> deleteReply(@RequestParam("commentNum") int commentNum,
			@RequestParam("boardNum") int boardNum) {
		
		cscService.deleteComments(commentNum);
		
		return cscService.selectCommentsAll(boardNum);
	}
	
	@PostMapping("/mod-reply")
	@ResponseBody
	public List<CscCommentsVO> modReply(CscCommentsVO cscCommentsVO) {
		cscService.updateComments(cscCommentsVO);
		
		return cscService.selectCommentsAll(cscCommentsVO.getBoardsBoardNum());
	}
}












