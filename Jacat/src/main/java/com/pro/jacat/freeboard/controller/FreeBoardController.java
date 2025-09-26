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
	
	
	//�۾���
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
	//�Խñ� ���ȭ��
	@RequestMapping(value="/boards", method=RequestMethod.GET)
	public String freeboardList(Model model) throws ClassNotFoundException, SQLException{
		
		List<FreeBoardVO> list = freeboardService.selectAllBoard(); 
		
		model.addAttribute("FreeBoardList", list);
		
		
		return "freeboard/freeboardList";
	}
	
		//�Խñ� �ܰ� ��ȸ
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
			
			//��ȸ�� ����
			
			freeboardService.visit(visit);
			
		}

		FreeBoardVO vo = freeboardService.selectBoardByBno(board_num);
		
		
		//���� ��� ��ȸ ������ ��������
		List<FreeBoardCommentVO> ccomentList = freeboardService.selectCComment(board_num);
		
		model.addAttribute("FreeBoard", vo);
		model.addAttribute("ccomentList", ccomentList);
		
		return "freeboard/freeboardView";
		
		
	}
	
	//���� ��Ʈ�ѷ�
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
	
		//�Խñ� ����ȭ�� ��Ʈ�ѷ�
		@RequestMapping(value="/freeboardModify/{board_num}", method=RequestMethod.GET)
		public String modify(
				@PathVariable("board_num") int board_num,
				Model model
				
		) {
			
			FreeBoardVO vo = freeboardService.selectBoardByBno(board_num);
			model.addAttribute("FreeBoardModify", vo);
			return "freeboard/freeboardModify";
			///WEB-INF/views/board/modify.jsp�� ������
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
			//ȭ�鿡�� ������ �����͸� �ް�
			//�����ͺ��̽����� updateó��
			//�ݹ� ������ �Խñ۷� �����̷�Ʈ
			return "redirect:/freeboard/boards/"+board_num;
			
		}
		
		//��۵��
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
	        // �α��� ����� Ȯ��
	        UserVO user = (UserVO) session.getAttribute("user");
	        if (user == null) {
	            return "redirect:/login"; // �α��� �� ���� ���
	        }

	        System.out.println(vo.getCommentNum());
	        // ��� ���� ����
	        freeboardService.updateComment(vo);

	        // �ٽ� �ش� �Խñ� �󼼺���� �����̷�Ʈ
	        return "redirect:/freeboard/boards/" + vo.getBoardNum();
	    }
		
		//�Ű�insert
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
					.append("alert('�Ű� �Ϸ�Ǿ����ϴ�.');")
		            .append("window.close();")
		            .append("</script>")
		            .flush();
			
		
		}
		
		//�Ű� �˾�â
		@RequestMapping(value="/report/{boardNum}", method=RequestMethod.GET)
		public String showReportPopup(@PathVariable("boardNum") int boardNum, Model model) {
		    // �˾��� ���� �Խñ� ��ȣ
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
		        result.put("message", "�α��� �ʿ�");
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
		
		
		
		
		
