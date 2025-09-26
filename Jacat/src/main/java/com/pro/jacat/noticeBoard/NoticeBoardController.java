 package com.pro.jacat.noticeBoard;

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

import com.pro.jacat.noticeBoard.service.NoticeService;
import com.pro.jacat.noticeBoard.vo.NoticeBoardFileVO;
import com.pro.jacat.noticeBoard.vo.NoticeBoardVO;
import com.pro.jacat.user.vo.UserVO;

@Controller
@RequestMapping("/notice")

public class NoticeBoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeBoardController.class);
	private final NoticeService noticeBoardService;
	
	@Autowired
	public NoticeBoardController(NoticeService noticeBoardService) {
		this.noticeBoardService = noticeBoardService;
	}
	
//2. 게시글 수정화면 컨트롤러
		//요청을 받으면 jsp화면으로 포워딩
		@RequestMapping(value="/modify/{board_num}", method=RequestMethod.GET)
		public String modify(
				@PathVariable("board_num") int board_num,
				Model model
		) {
			
			NoticeBoardVO vo = noticeBoardService.selectnoticeBoardBybno(board_num);
			model.addAttribute("NoticeBoard", vo);
			return "notice/modify";
			///WEB-INF/views/board/modify.jsp로 포워딩
		}
		
//2.5 게시글 수정처리 컨트롤러
		@RequestMapping(value="/modify/{bno}", method=RequestMethod.POST)
		public String modifyPost(
				@PathVariable("bno") int bno,
				NoticeBoardVO vo
				, @RequestParam("files") List<MultipartFile> files
			) {
			System.out.println(vo.getContent());
			vo.setBoardNum(bno);
			boolean result = noticeBoardService.updateNoticeBoard(vo,files);
			if(!result) {
				return "redirect:/notice/boards/"+bno;
			}
			return "redirect:/notice/boards/"+bno;
		}
	
//3. 게시글 목록화면 컨트롤러
		//요청을 받으면 jsp화면으로 포워딩
		@RequestMapping(value="/list", method=RequestMethod.GET)
		public String list(Model model) throws ClassNotFoundException, SQLException {
			//여러개의 게시글을 조회해서 jsp에 포워딩 할 때 데이터를 담아준다.
		
			//2. 리스트
			//적합
			
			List<NoticeBoardVO> list = noticeBoardService.selectAllNoticeBoard();
			//레파지토리에 직접 접근하지 않고 서비스 레이어를 통해 레파지토리에 접근
			
			//매퍼 중 boardMapper namespace의 id가 selectAllBoard에 해당하는
			//sql을 실행하고 결과값을 자바객체로 변환하여 돌려준다.
			
			model.addAttribute("boardList", list);
			
			return "notice/list";
		}

		
// 게시글 상세
		@RequestMapping(value="/boards/{boardNum}", method=RequestMethod.GET)
		public String view(
				@PathVariable("boardNum") int boardNum,
					Model model
				) {
			NoticeBoardVO vo = noticeBoardService.selectnoticeBoardBybno(boardNum);
		
			
			model.addAttribute("noticeboard", vo);
			return "notice/view";
		}
	
// 게시글 작성 컨트롤러
	@RequestMapping(value="/write",method = RequestMethod.GET)
		public String write() {
			return "notice/write";
		}
		
// 게시글 등록 컨트롤러
	@RequestMapping(value="/write",method = RequestMethod.POST)
	public String upload(
			@ModelAttribute NoticeBoardVO vo,
			@RequestParam("files") List<MultipartFile> files,
			@SessionAttribute("user") UserVO user
			) throws IllegalStateException, IOException {
		 vo.setUsersId(user.getId());
		 vo.setBoardType("N");
		 noticeBoardService.insertNoticeBoard(vo, files);

		return "redirect:/notice/list";
	}
		
//4.삭제 컨트롤러
		@RequestMapping(value = "/delete/{board_num}", method = RequestMethod.POST)
		public String delete(
				@PathVariable("board_num") int board_num,
				@SessionAttribute("user") UserVO user
		) {
			//delete from board where bno = ?
			int result = noticeBoardService.deleteNoticeBoard(board_num);
			//삭제 성공시 notice화면 출력
			if(result == 1) {
				return "redirect:/notice/list";
			}
			//삭제 실패시  
			return "redirect:/notice/list/" + board_num;
		}
}