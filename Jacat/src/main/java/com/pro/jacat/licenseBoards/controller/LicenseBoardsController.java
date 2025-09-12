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

	//�ڰ��� ���
	@RequestMapping(value="/lists", method=RequestMethod.GET)
	public String licenseInfo(Model model) {
		logger.info("�ڰ��� ���� ����");
		
		//List<LicenseListVO> list = 
		
		return "licenseBoards/licenses";
	}
	
	//�ڰ��� ����ȸ
	@RequestMapping(value="/lists/{jmcd}",method=RequestMethod.GET)
	public String licenseView() {
		logger.info("�ڰ��� ������ ����");
		
		return "licenseBoards/licenseView";
	}
	
	//QnA �Խ��� �����ȸ
	@RequestMapping(value="/QnA",method=RequestMethod.GET)
	public String qnaBoards(Model model) throws ClassNotFoundException, SQLException {
		logger.info("�ڰ��� QnA �Խ��� ��� ����");
		
		List<LicenseBoardsVO> lists = lboardService.selectQnABoards();
		
		model.addAttribute("boardList", lists);
		
		return "licenseBoards/qnaBoard/qnaBoards";
	}
	
	//QnA �Խ��� ����ȸ
	@RequestMapping(value="/QnA/view/{boardNum}", method=RequestMethod.GET)
	public String qnaView(
			@PathVariable("boardNum") int boardNum,
			Model model
			) {
		logger.info("QnA�Խ��� {}�� �Խù� ����ȸ ����",boardNum);
		
		LicenseBoardsVO vo = lboardService.selectQnABoardOne(boardNum);
		
		/*
		 * logger.info("���\n ���ϼ� : {}, ��ۼ� : {}",vo.getlFile().size(),vo.getlComment().
		 * size()); logger.info("���1 : {} ",vo.getlComment().get(0).getContent());
		 * logger.info("���1 : {} ",vo.getlComment().get(0).getParentComment());
		 * logger.info("���1 : {} ",vo.getlComment().get(0).getNick());
		 * logger.info("���2 : {} ",vo.getlComment().get(1).getContent());
		 * logger.info("���2 : {} ",vo.getlComment().get(1).getParentComment());
		 * logger.info("���2 : {} ",vo.getlComment().get(0).getNick());
		 * logger.info("���3 : {} ",vo.getlComment().get(2).getContent());
		 * logger.info("���3 : {} ",vo.getlComment().get(2).getParentComment());
		 * logger.info("���3 : {} ",vo.getlComment().get(0).getNick());
		 */
		
		logger.info("�ڰ��� �̸� : {}",vo.getLicenseName());
		
		model.addAttribute("board",vo);
		
		return "licenseBoards/qnaBoard/qnaBoardsView";
	}
	
	//QnA �Խ��� �� �ۼ�
	@RequestMapping(value="/QnA/write", method=RequestMethod.GET)
	public String qnaBoardWrite() {
		logger.info("�ڰ��� QnA �Խñ� �ۼ� ������ ����");
		
		return "licenseBoards/qnaBoard/qnaWrite";
	}
	//QnA �Խ��� �� ����
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
	
	//QnA �Խ��� �� ����
	@RequestMapping(value="/QnA/update/{boardNum}", method=RequestMethod.GET)
	public String qnaBoardUpdate() {
		logger.info("�ڰ��� QnA �Խñ� ���� ������ ����");
		
		return "licenseBoards/qnaBoard/qnaUpdate";
	}
	
	//QnA �Խ��� �� ����
	@RequestMapping(value="/QnA/delete/{boardNum}", method=RequestMethod.GET)
	public String qnaBoardDelete() {
		logger.info("�ڰ��� QnA �Խñ� ����");
		
		return "redirect:/licenseBoards/qnaBoard/qnaBoards";
	}
	
	//�ڷ�� ��� ��ȸ
	@RequestMapping(value="/dataroom", method=RequestMethod.GET)
	public String dataroomBoards() {
		logger.info("�ڰ��� �ڷ�� ����");
		
		return "licenseBoards/dataroom/dataroomBoards";
	}
	
	//�ڷ�� ����ȸ
	@RequestMapping(value="/dataroom/view/{boardNum}", method=RequestMethod.GET)
	public String dataroomBoardView() {
		logger.info("�ڰ��� �ڷ�� ����ȸ ����");
		
		return "licenseBoards/dataroom/dataroomView";
	}
	
	//�ڷ�� ���ۼ�
	@RequestMapping(value="/dataroom/write/{boardNum}", method=RequestMethod.GET)
	public String dataroomBoardWrite() {
		logger.info("�ڰ��� �Խ��� �۾��� ����");
		
		return "licenseBoards/dataroom/dataroomWrite";
	}
	
	//�ڷ�� �ۼ���
	@RequestMapping(value="/dataroom/update/{boardNum}", method=RequestMethod.GET)
	public String dataroomBoardUpdate() {
		logger.info("�ڰ��� �Խ��� �ۼ��� ����");
		
		return "licenseBoards/dataroom/dataroomUpdate";
	}
	
	//�ڷ�� �ۻ���
	@RequestMapping(value="/dataroom/delete/{boardNum}", method=RequestMethod.GET)
	public String dataroomBoardDelete() {
		logger.info("�ڰ��� �Խ��� ����");
		
		return "redirect:/licenseBoards/dataroom/dataroomBoards";
	}
	
}
