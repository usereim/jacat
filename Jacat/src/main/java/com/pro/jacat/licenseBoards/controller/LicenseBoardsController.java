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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.HomeController;
import com.pro.jacat.licenseBoards.service.LicenseBoardsServiceImpl;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsCommentVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsVO;
import com.pro.jacat.licenses.vo.LicenseListVO;
import com.pro.jacat.user.vo.UserVO;

@Controller
@RequestMapping(value="/licenses")
public class LicenseBoardsController {
	
	private static final Logger logger = LoggerFactory.getLogger(LicenseBoardsController.class);
	
	private final LicenseBoardsServiceImpl lboardService;
	
	@Autowired
	public LicenseBoardsController(LicenseBoardsServiceImpl lboardService) {
		//super();
		this.lboardService = lboardService;
	}

	//�ڰ��� ���
	@RequestMapping(value="/lists", method=RequestMethod.GET)
	public String licenseInfo(Model model) {
		logger.info("�ڰ��� ���� ����");
		
		List<LicenseListVO> list = lboardService.selectLicenseLists();
		
		model.addAttribute("lList",list);
		
		return "licenseBoards/licenses";
	}
	
	//�ڰ��� ����ȸ
	@RequestMapping(value="/lists/{jmcd}",method=RequestMethod.GET)
	public String licenseView(@PathVariable("jmcd") String jmcd, Model model) {
		logger.info("�ڰ��� ������ ����(jmcd : {})",jmcd);
		
		LicenseListVO vo = lboardService.selectLicenseOne(jmcd);
		
		logger.info("{} ������ ����",vo.getJmfldnm());
		
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("lListOne",vo);
		
		logger.info("lTest : {}, lTestDate : {}" , 1/*vo.getlTest()*/, vo.getlTestDate());
		logger.info("lTest : {}, lTestDate : {}" , 1/*vo.getlTest()*/, vo.getlTestDate().get(0).getDocExamEndDt());
		logger.info("������ : {}", vo.getLicensingAutority());
		return "licenseBoards/licenseView";
	}
	
	/*@PostMapping("/license/lists/{jmcd}/add-license")
	public String addLisense () {
		
	}
	*/
	//QnA �Խ��� �����ȸ
	@RequestMapping(value="/lists/{jmcd}/QnA",method=RequestMethod.GET)
	public String qnaBoards(
			Model model,
			@PathVariable("jmcd") String jmcd
			) throws ClassNotFoundException, SQLException {
		logger.info("�ڰ��� QnA �Խ��� ��� ����");
		
		List<LicenseBoardsVO> lists = lboardService.selectQnABoards();
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		model.addAttribute("boardList", lists);
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("jmfldnm", jmfldnm);
		
		return "licenseBoards/qnaBoard/qnaBoards";
	}
	
	//QnA �Խ��� ����ȸ
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}", method=RequestMethod.GET)
	public String qnaView(
			@PathVariable("boardNum") int boardNum,
			@PathVariable("jmcd") String jmcd,
			Model model
			) {
		
		
		/*
		 * LicenseBoardsVO urlVo = new LicenseBoardsVO(); urlVo.setBoardNum(boardNum);
		 * urlVo.setLicenseListJmcd(jmcd);
		 */
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		LicenseBoardsVO vo = lboardService.selectQnABoardOne(boardNum);
		
		logger.info("{} �ڰ��� QnA�Խ��� {}�� �Խù� ����ȸ ����",jmfldnm,boardNum);
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
		
		logger.info("�ڰ��� �̸� : {}",jmfldnm);
		
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("jmfldnm",jmfldnm);
		model.addAttribute("board",vo);
		
		return "licenseBoards/qnaBoard/qnaBoardsView";
	}
	
	//QnA �Խ��� �� �ۼ�
	@RequestMapping(value="/{jmcd}/QnA/write", method=RequestMethod.GET)
	public String qnaBoardWrite() {
		logger.info("�ڰ��� QnA �Խñ� �ۼ� ������ ����");
		
		return "licenseBoards/qnaBoard/qnaWrite";
	}
	//QnA �Խ��� �� ����
	@RequestMapping(value="/{jmcd}/QnA/write", method=RequestMethod.POST)
	public String qnaBoardWritePost(
			@ModelAttribute LicenseBoardsVO vo, 
			//@RequestParam("file") List<MultipartFile> file,
			@SessionAttribute("user") UserVO user,
			@PathVariable("jmcd") String jmcd
			) throws IllegalStateException, IOException {
		
		vo.setUsersId(user.getId());
		vo.setLicenseListJmcd(jmcd);
		//lboardService.insertQnABoardOne(vo,file);
		lboardService.insertQnABoardOne(vo);
		
		return "redirect:licenseBoards/qnaBoard/qnaBoardsView/"+vo.getBoardNum();
		
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
	
	//QnA �Խ��� ��� �ۼ�
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}/comment/write", method=RequestMethod.POST)
	@ResponseBody
	public LicenseBoardsCommentVO qnaBoardCommentWrite(
			@PathVariable("jmcd") String jmcd,
			/*
			 * @PathVariable("boardNum") int boardNum,
			 * 
			 * @RequestParam("content") String content,
			 * 
			 * @SessionAttribute UserVO uvo,
			 */
			LicenseBoardsCommentVO cvo
			) {
		/*
		cvo.setUsersId(uvo.getId());
		cvo.setLicenseBoardsBoardNum(boardNum);
		cvo.setContent(content);
		*/
		int result = lboardService.insertLicenseCommentOne(cvo);
		
		logger.info("��� ���� ��� : {}",result);
		
		return cvo;
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
