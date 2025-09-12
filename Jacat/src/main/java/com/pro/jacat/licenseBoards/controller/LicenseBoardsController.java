package com.pro.jacat.licenseBoards.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

import com.pro.jacat.HomeController;
import com.pro.jacat.licenseBoards.service.licenseBoardsServiceImpl;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsVO;
import com.pro.jacat.licenses.vo.LicenseListVO;
import com.pro.jacat.user.vo.UserVO;

@Controller
@RequestMapping(value="/licenses")
public class LicenseBoardsController {
	
	private static final Logger logger = LoggerFactory.getLogger(LicenseBoardsController.class);
	
	private final licenseBoardsServiceImpl lboardService;
	
	@Autowired
	public LicenseBoardsController(licenseBoardsServiceImpl lboardService) {
		//super();
		this.lboardService = lboardService;
	}

	//자격증 목록
	@RequestMapping(value="/lists", method=RequestMethod.GET)
	public String licenseInfo(Model model) {
		logger.info("자격증 정보 진입");
		
		//List<LicenseListVO> list = 
		
		return "licenseBoards/licenses";
	}
	
	//자격증 상세조회
	@RequestMapping(value="/lists/{jmcd}",method=RequestMethod.GET)
	public String licenseView() {
		logger.info("자격증 상세정보 진입");
		
		return "licenseBoards/licenseView";
	}
	
	//QnA 게시판 목록조회
	@RequestMapping(value="/QnA",method=RequestMethod.GET)
	public String qnaBoards(Model model) throws ClassNotFoundException, SQLException {
		logger.info("자격증 QnA 게시판 목록 진입");
		
		List<LicenseBoardsVO> lists = lboardService.selectQnABoards();
		
		model.addAttribute("boardList", lists);
		
		return "licenseBoards/qnaBoard/qnaBoards";
	}
	
	//QnA 게시판 상세조회
	@RequestMapping(value="/QnA/view/{boardNum}", method=RequestMethod.GET)
	public String qnaView(
			@PathVariable("boardNum") int boardNum,
			Model model
			) {
		logger.info("QnA게시판 {}번 게시물 상세조회 진입",boardNum);
		
		LicenseBoardsVO vo = lboardService.selectQnABoardOne(boardNum);
		
		/*
		 * logger.info("결과\n 파일수 : {}, 댓글수 : {}",vo.getlFile().size(),vo.getlComment().
		 * size()); logger.info("댓글1 : {} ",vo.getlComment().get(0).getContent());
		 * logger.info("댓글1 : {} ",vo.getlComment().get(0).getParentComment());
		 * logger.info("댓글1 : {} ",vo.getlComment().get(0).getNick());
		 * logger.info("댓글2 : {} ",vo.getlComment().get(1).getContent());
		 * logger.info("댓글2 : {} ",vo.getlComment().get(1).getParentComment());
		 * logger.info("댓글2 : {} ",vo.getlComment().get(0).getNick());
		 * logger.info("댓글3 : {} ",vo.getlComment().get(2).getContent());
		 * logger.info("댓글3 : {} ",vo.getlComment().get(2).getParentComment());
		 * logger.info("댓글3 : {} ",vo.getlComment().get(0).getNick());
		 */
		
		logger.info("자격증 이름 : {}",vo.getLicenseName());
		
		model.addAttribute("board",vo);
		
		return "licenseBoards/qnaBoard/qnaBoardsView";
	}
	
	//QnA 게시판 글 작성
	@RequestMapping(value="/QnA/write", method=RequestMethod.GET)
	public String qnaBoardWrite() {
		logger.info("자격증 QnA 게시글 작성 페이지 진입");
		
		return "licenseBoards/qnaBoard/qnaWrite";
	}
	//QnA 게시판 글 수정
	@RequestMapping(value="/QnA/write", method=RequestMethod.POST)
	public String qnaBoardWritePost(
			@ModelAttribute LicenseBoardsVO vo, 
			@RequestParam("file") List<MultipartFile> file,
			@SessionAttribute("user") UserVO user
			) throws IllegalStateException, IOException {
		
		vo.setUsersId(user.getId());
		lboardService.insertQnABoardOne(vo,file);
		
		return "redirect:licenseBoards/qnaBoard/qnaBoardsView"+vo.getBoardNum();
	}
	
	//QnA 게시판 글 수정
	@RequestMapping(value="/QnA/update/{boardNum}", method=RequestMethod.GET)
	public String qnaBoardUpdate() {
		logger.info("자격증 QnA 게시글 수정 페이지 진입");
		
		return "licenseBoards/qnaBoard/qnaUpdate";
	}
	
	//QnA 게시판 글 삭제
	@RequestMapping(value="/QnA/delete/{boardNum}", method=RequestMethod.GET)
	public String qnaBoardDelete() {
		logger.info("자격증 QnA 게시글 삭제");
		
		return "redirect:/licenseBoards/qnaBoard/qnaBoards";
	}
	
	//자료실 목록 조회
	@RequestMapping(value="/dataroom", method=RequestMethod.GET)
	public String dataroomBoards() {
		logger.info("자격증 자료실 진입");
		
		return "licenseBoards/dataroom/dataroomBoards";
	}
	
	//자료실 상세조회
	@RequestMapping(value="/dataroom/view/{boardNum}", method=RequestMethod.GET)
	public String dataroomBoardView() {
		logger.info("자격증 자료실 상세조회 진입");
		
		return "licenseBoards/dataroom/dataroomView";
	}
	
	//자료실 글작성
	@RequestMapping(value="/dataroom/write/{boardNum}", method=RequestMethod.GET)
	public String dataroomBoardWrite() {
		logger.info("자격증 게시판 글쓰기 진입");
		
		return "licenseBoards/dataroom/dataroomWrite";
	}
	
	//자료실 글수정
	@RequestMapping(value="/dataroom/update/{boardNum}", method=RequestMethod.GET)
	public String dataroomBoardUpdate() {
		logger.info("자격증 게시판 글수정 진입");
		
		return "licenseBoards/dataroom/dataroomUpdate";
	}
	
	//자료실 글삭제
	@RequestMapping(value="/dataroom/delete/{boardNum}", method=RequestMethod.GET)
	public String dataroomBoardDelete() {
		logger.info("자격증 게시판 삭제");
		
		return "redirect:/licenseBoards/dataroom/dataroomBoards";
	}
	
}
