package com.pro.jacat.freeboard.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.csc.controller.CscController;
import com.pro.jacat.freeboard.service.FreeBoardService;
import com.pro.jacat.freeboard.vo.FreeBoardCommentVO;
import com.pro.jacat.freeboard.vo.FreeBoardReportVO;
import com.pro.jacat.freeboard.vo.FreeBoardVO;
import com.pro.jacat.user.vo.UserVO;

@Controller
@RequestMapping(value="/freeboard")
public class FreeBoardController {
	private static final Logger logger = LoggerFactory.getLogger(FreeBoardController.class);
	private final FreeBoardService freeboardService;
	
	
	@Autowired
	public FreeBoardController(FreeBoardService boardService) {
		this.freeboardService = boardService;
	}
	
	
	//글쓰기
	@RequestMapping(value="/freeboardWrite", method=RequestMethod.GET)
	public String write(HttpSession session) {
		return "freeboard/freeboardWrite";
	}
	
	@RequestMapping(value="/freeboardWrite", method=RequestMethod.POST)
	public String writePost(@ModelAttribute FreeBoardVO vo,
				@RequestParam("file") List<MultipartFile> file,
				@SessionAttribute("user") UserVO user
			) throws IllegalStateException, IOException {
			System.out.println("freeBoardWrite Post ");
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
		HttpSession session,
		@PathVariable("board_num") int board_num,
		Model model
		) {
			
		UserVO user = (UserVO)session.getAttribute("user");
		if (user != null) {
			FreeBoardVO visit = new FreeBoardVO();
			
			visit.setBoardNum(board_num);
			visit.setUsersId(user.getId());
			
			//조회수 증가
			
			freeboardService.visit(visit);
			
		}

		FreeBoardVO vo = freeboardService.selectBoardByBno(board_num);
		
		
		//대댓글 목록 조회 데이터 가져오기
		List<FreeBoardCommentVO> ccomentList = freeboardService.selectCComment(board_num);
		
		model.addAttribute("FreeBoard", vo);
		model.addAttribute("ccomentList", ccomentList);
		
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
	
		//게시글 수정화면 컨트롤러
		@RequestMapping(value="/freeboardModify/{board_num}", method=RequestMethod.GET)
		public String modify(
				@PathVariable("board_num") int board_num,
				Model model
				
		) {
			
			FreeBoardVO vo = freeboardService.selectBoardByBno(board_num);
			model.addAttribute("FreeBoardModify", vo);
			return "freeboard/freeboardModify";
			///WEB-INF/views/board/modify.jsp로 포워딩
		}
		
		@RequestMapping(value="/modify/{board_num}", method=RequestMethod.POST)
		public String modifyPost(
				@PathVariable("board_num") int board_num,
				FreeBoardVO vo,
				@RequestParam("file") List<MultipartFile> files
			) {
			vo.setBoardNum(board_num);
			boolean result = freeboardService.updateBoard(vo,files);
			if(!result) {
				return "redirect:/freeboard/boards/";
			}
			//화면에서 전달한 데이터를 받고
			//데이터베이스에서 update처리
			//금방 수정한 게시글로 리다이렉트
			return "redirect:/freeboard/boards/"+board_num;
			
		}
		
		//댓글등록
		@RequestMapping(value="/comment", method=RequestMethod.POST)
		public String addComment(@ModelAttribute FreeBoardCommentVO vo,
				@SessionAttribute("user") UserVO user
			) throws IllegalStateException, IOException {
			System.out.println("addComment Post ");
			vo.setUsersID(user.getId());
			freeboardService.addComment(vo);
			return "redirect:/freeboard/boards/"+vo.getBoardNum();
    }
		
		@PostMapping("/comment/modify")
		@ResponseBody
	    public String modifyComment(FreeBoardCommentVO vo, HttpSession session) {
	        // 로그인 사용자 확인
	        UserVO user = (UserVO) session.getAttribute("user");
	        if (user == null) {
	            return "redirect:/login"; // 로그인 안 했을 경우
	        }

	        System.out.println(vo.getCommentNum());
	        // 댓글 내용 수정
	        freeboardService.updateComment(vo);

	        // 다시 해당 게시글 상세보기로 리다이렉트
	        return "redirect:/freeboard/boards/" + vo.getBoardNum();
	    }
		
		//신고insert
		@RequestMapping(value="/report", method=RequestMethod.POST)
		public void insertReport(@ModelAttribute FreeBoardReportVO vo,
				@SessionAttribute("user") UserVO user,
				HttpServletResponse response
			) throws IllegalStateException, IOException {
			System.out.println(vo.getBoardsBoardNum());
			vo.setUsersId(user.getId());
			freeboardService.insertReport(vo);
			
			response.setContentType("text/html");
			response.getWriter()
					.append("<script>")
					.append("alert('신고가 완료되었습니다.');")
		            .append("window.close();")
		            .append("</script>")
		            .flush();
			
		
		}
		
		//신고 팝업창
		@RequestMapping(value="/report/{boardNum}", method=RequestMethod.GET)
		public String showReportPopup(@PathVariable("boardNum") int boardNum, Model model) {
		    // 팝업에 보낼 게시글 번호
		    model.addAttribute("boardNum", boardNum);
		    return "freeboard/freeboardReport"; // /WEB-INF/views/freeboard/reportPopup.jsp
		}
		
		@PostMapping("/comment/delete")
		@ResponseBody
		public Map<String, Object> deleteComments(@RequestParam(value="commentNums", required=false) List<Integer> commentNums,
		                                          HttpSession session) {
		    Map<String, Object> result = new HashMap<>();
		    UserVO user = (UserVO) session.getAttribute("user");
		    if(user == null) {
		        result.put("status", "fail");
		        result.put("message", "로그인 필요");
		        return result;
		    }

		    if(commentNums != null) {
		        for(Integer commentNum : commentNums) {
		        	FreeBoardCommentVO vo = new FreeBoardCommentVO();
		        	vo.setCommentNum(commentNum);
		        	vo.setUsersID(user.getId());
		            freeboardService.deleteComment(vo);
		        }
		    }

		    result.put("status", "success");
		    return result;
		}
		
}
		
		
		
		
		
