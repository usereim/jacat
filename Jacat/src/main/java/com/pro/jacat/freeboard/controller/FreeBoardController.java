package com.pro.jacat.freeboard.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.freeboard.service.FreeBoardService;
import com.pro.jacat.freeboard.vo.FreeBoardVO;
import com.pro.jacat.user.vo.UserVO;

@Controller
@RequestMapping(value="/freeboard")
public class FreeBoardController {
	
	private final FreeBoardService freeboardService;
	
	@Autowired
	public FreeBoardController(FreeBoardService boardService) {
		this.freeboardService = boardService;
	}
	
	
	
	@RequestMapping(value="/freeboardWrite", method=RequestMethod.GET)
	public String write(HttpSession session) {
		return "freeboard/freeboardWrite";
	}
	
	@RequestMapping(value="/freeboardWrite", method=RequestMethod.POST)
	public String writePost(@ModelAttribute FreeBoardVO vo,
				@RequestParam("file") List<MultipartFile> file,
				@SessionAttribute("user") UserVO user
			) throws IllegalStateException, IOException {
			vo.setUsersId(user.getId());
			freeboardService.insertBoard(vo, file);
			return "redirect:/freeboard/boards/"+vo.getBoardNum();
			
			
	}
	//게시글 목록화면
	@RequestMapping(value="/boards", method=RequestMethod.GET)
	public String freeboardList(Model model) throws ClassNotFoundException, SQLException{
		
		List<FreeBoardVO> list = freeboardService.selectAllBoard(); 
		
		model.addAttribute("FreeBoardList", list);
		
		return "freeboard/freeboardList";
	}
	
	//게시글 단건 조회
	@RequestMapping(value="/boards/{board_num}", method=RequestMethod.GET)
	public String freeboardView(
		@PathVariable("board_num") int board_num,
		Model model
		) {
		
		FreeBoardVO vo = freeboardService.selectBoardByBno(board_num);
		
		model.addAttribute("FreeBoard", vo);
		return "freeboard/freeboardView";
		
		
	}
	
	//삭제 컨트롤러
	@RequestMapping(value = "/delete/{board_num}", method = RequestMethod.POST)
	public String delete(
			@PathVariable("board_num") int board_num,
			@SessionAttribute("user") UserVO user
	) {
		
		int result = freeboardService.deleteBoard(board_num, user.getId());
		if(result <= 0) {
			return "redirect:/freeboard/boards/"+board_num;
		}
		
		return "redirect:/freeboard/boards";
	}
}
