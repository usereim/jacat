package com.pro.jacat.freeboard.controller;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pro.jacat.freeboard.service.FreeBoardService;
import com.pro.jacat.freeboard.vo.FreeBoardVO;

@Controller
@RequestMapping(value="/freeboard")
public class FreeBoardController {
	
	private final FreeBoardService freeboardService;
	
	@Autowired
	public FreeBoardController(FreeBoardService boardService) {
		this.freeboardService = boardService;
	}
	
	//게시글 목록화면
	@RequestMapping(value="", method=RequestMethod.GET)
	public String freeboardList(Model model) throws ClassNotFoundException, SQLException{
		
		List<FreeBoardVO> list = freeboardService.selectAllBoard(); 
		
		model.addAttribute("FreeBoardList", list);
		
		return "freeboard/freeboardList";
	
	}
	
	@RequestMapping(value="/freeboards/{board_num}", method=RequestMethod.GET)
	public String freeboardView(
		@PathVariable("board_num") int board_num,
		Model model
		) {
		
		FreeBoardVO vo = freeboardService.selectBoardByBno(board_num);
		
		model.addAttribute("FreeBoard", vo);
		return "freeboard/freeboardView";
		
		
	}
	
	
}
