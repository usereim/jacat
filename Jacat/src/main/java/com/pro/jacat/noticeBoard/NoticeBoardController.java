 package com.pro.jacat.noticeBoard;

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.pro.jacat.noticeBoard.service.NoticeService;
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
	
	
	//3. �Խñ� ���ȭ�� ��Ʈ�ѷ�
		//��û�� ������ jspȭ������ ������
		@RequestMapping(value="", method=RequestMethod.GET)
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
		
		@RequestMapping(value="/list/{board_num}", method=RequestMethod.GET)
		public String view(
				@PathVariable("board_num") int board_num,
					Model model
				) {
			logger.info("bno : {}", board_num);
			NoticeBoardVO vo = noticeBoardService.selectnoticeBoardBybno(board_num);
			
			model.addAttribute("noticeboard", vo);
			return "notice/view";
		}
		
		//���� ��Ʈ�ѷ�
		@RequestMapping(value = "/delete/{board_num}", method = RequestMethod.POST)
		public String delete(
				@PathVariable("board_num") int board_num,
				@SessionAttribute("user") UserVO user
		) {
			//delete from board where bno = ?
			int result = noticeBoardService.deleteNoticeBoard(board_num, user.getId());
			//���� ������ noticeȭ�� ���
			if(result <= 0) {
				return "redirect:/notice";
			}
			//���� ���н�  
			return "redirect:/notice/list/" + board_num;
		}
		
}
	


