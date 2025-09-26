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
	
//2. �Խñ� ����ȭ�� ��Ʈ�ѷ�
		//��û�� ������ jspȭ������ ������
		@RequestMapping(value="/modify/{board_num}", method=RequestMethod.GET)
		public String modify(
				@PathVariable("board_num") int board_num,
				Model model
		) {
			
			NoticeBoardVO vo = noticeBoardService.selectnoticeBoardBybno(board_num);
			model.addAttribute("NoticeBoard", vo);
			return "notice/modify";
			///WEB-INF/views/board/modify.jsp�� ������
		}
		
//2.5 �Խñ� ����ó�� ��Ʈ�ѷ�
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
	
//3. �Խñ� ���ȭ�� ��Ʈ�ѷ�
		//��û�� ������ jspȭ������ ������
		@RequestMapping(value="/list", method=RequestMethod.GET)
		public String list(Model model) throws ClassNotFoundException, SQLException {
			//�������� �Խñ��� ��ȸ�ؼ� jsp�� ������ �� �� �����͸� ����ش�.
		
			//2. ����Ʈ
			//����
			
			List<NoticeBoardVO> list = noticeBoardService.selectAllNoticeBoard();
			//�������丮�� ���� �������� �ʰ� ���� ���̾ ���� �������丮�� ����
			
			//���� �� boardMapper namespace�� id�� selectAllBoard�� �ش��ϴ�
			//sql�� �����ϰ� ������� �ڹٰ�ü�� ��ȯ�Ͽ� �����ش�.
			
			model.addAttribute("boardList", list);
			
			return "notice/list";
		}

		
// �Խñ� ��
		@RequestMapping(value="/boards/{boardNum}", method=RequestMethod.GET)
		public String view(
				@PathVariable("boardNum") int boardNum,
					Model model
				) {
			NoticeBoardVO vo = noticeBoardService.selectnoticeBoardBybno(boardNum);
		
			
			model.addAttribute("noticeboard", vo);
			return "notice/view";
		}
	
// �Խñ� �ۼ� ��Ʈ�ѷ�
	@RequestMapping(value="/write",method = RequestMethod.GET)
		public String write() {
			return "notice/write";
		}
		
// �Խñ� ��� ��Ʈ�ѷ�
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
		
//4.���� ��Ʈ�ѷ�
		@RequestMapping(value = "/delete/{board_num}", method = RequestMethod.POST)
		public String delete(
				@PathVariable("board_num") int board_num,
				@SessionAttribute("user") UserVO user
		) {
			//delete from board where bno = ?
			int result = noticeBoardService.deleteNoticeBoard(board_num);
			//���� ������ noticeȭ�� ���
			if(result == 1) {
				return "redirect:/notice/list";
			}
			//���� ���н�  
			return "redirect:/notice/list/" + board_num;
		}
}