package com.pro.jacat.licenseBoards.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.HomeController;
import com.pro.jacat.licenseBoards.service.LicenseBoardsServiceImpl;
import com.pro.jacat.licenseBoards.vo.FileLicenseBoardVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardReportVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsCommentVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsVO;
import com.pro.jacat.licenseBoards.vo.UsersFavoritesLicenseVO;
import com.pro.jacat.licenseBoards.vo.VisitLicenseBoardVO;
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
	public String licenseView(
			@PathVariable("jmcd") String jmcd, 
			@SessionAttribute(name="user", required=false) UserVO user,
			Model model) {
		logger.info("�ڰ��� ������ ����(jmcd : {})",jmcd);
		
		LicenseListVO vo = lboardService.selectLicenseOne(jmcd);
		
		vo = lboardService.vacancyDiscernment(vo);
		
		if(user != null) {
			UsersFavoritesLicenseVO uvo = new UsersFavoritesLicenseVO();
			uvo.setUsersId(user.getId());
			uvo.setLicenseListJmcd(jmcd);
			
			String favoriteLicenseYN = lboardService.selectFavoriteLicenseYN(uvo);
			model.addAttribute("favoLi", favoriteLicenseYN);
		}
		
		logger.info("{} ������ ����",vo.getJmfldnm());
		
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("lListOne",vo);
		
		
		logger.info("lTest : {}, lTestDate : {}" , 1/*vo.getlTest()*/, vo.getlTestDate());
		logger.info("lTest : {}, lTestDate : {}" , 1/*vo.getlTest()*/, vo.getlTestDate().get(0).getDocExamEndDt());
		logger.info("������ : {}", vo.getLicensingAutority());
		return "licenseBoards/licenseView";
	}
	
	//�����ڰ��� �߰�
	@PostMapping("/lists/add-license")
	@ResponseBody
	public int addLisense (
			@RequestParam ("usersId") String id,
			@RequestParam ("licenseListJmcd") String jmcd
			) {
		
		logger.info("{} ����� {} �ڰ��� �߰�",id,jmcd);
		
		UsersFavoritesLicenseVO vo = new UsersFavoritesLicenseVO();
		vo.setUsersId(id);
		vo.setLicenseListJmcd(jmcd);
		logger.info("{} ����� {} �ڰ��� �߰�",vo.getUsersId(),vo.getLicenseListJmcd());
		
		int addResult = lboardService.insertFavoriteLicenseOne(vo);
		
		return addResult;
	}
	//�����ڰ��� ����
	@PostMapping("/lists/del-license")
	@ResponseBody
	public int delLicense(
			UsersFavoritesLicenseVO vo
			) {
		int delResult = lboardService.deleteFavoriteLicenseOne(vo);
		
		return delResult;
		
	}
	
	/*----------QnA----------*/
	
	//QnA �Խ��� �����ȸ
	@RequestMapping(value="/lists/{jmcd}/QnA",method=RequestMethod.GET)
	public String qnaBoards(
			Model model,
			@PathVariable("jmcd") String jmcd
			) throws ClassNotFoundException, SQLException {
		logger.info("�ڰ��� QnA �Խ��� ��� ����");
		
		List<LicenseBoardsVO> lists = lboardService.selectQnABoards(jmcd);
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		//String boardTypeStr = lboardService.boardTypetoString(vo.getBoardType()); 
		
		model.addAttribute("boardList", lists);
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("jmfldnm", jmfldnm);
		model.addAttribute("boardType","QnA");
		model.addAttribute("boardTypeStr","QnA");
		
		return "licenseBoards/boards/boardList";
	}
	
	//QnA �Խ��� ����ȸ
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}", method=RequestMethod.GET)
	public String qnaView(
			@PathVariable("boardNum") int boardNum,
			@PathVariable("jmcd") String jmcd,
			@SessionAttribute(name="user", required=false) UserVO user,
			Model model
			) {
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		LicenseBoardsVO vo = lboardService.selectQnABoardOne(boardNum);
		//logger.info(vo.getlFiles().get(0).getRealFileName());
		//logger.info(vo.getlFile().getRealFileName());
		
		//logger.info("0");
		if(user != null) {
			if(!(user.getId().equals(vo.getUsersId()))) {
				//logger.info("1");
				//logger.info(user.getId());
				VisitLicenseBoardVO vvo = new VisitLicenseBoardVO();
				vvo.setUsersId(user.getId());
				vvo.setLicenseBoardNum(boardNum);
				lboardService.insertQnABoardVisit(vvo);
			}
			
		}
		
		String boardTypeStr = lboardService.boardTypetoString(vo.getBoardType());
		
		logger.info("{} �ڰ��� {} �Խ���",jmfldnm,boardTypeStr);
		logger.info("{}�� �Խù� ����ȸ ����",boardNum);
		
		
		logger.info("�ڰ��� �̸� : {}",jmfldnm);
		
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("jmfldnm",jmfldnm);
		model.addAttribute("board",vo);
		model.addAttribute("boardType","QnA");
		model.addAttribute("boardTypeStr",boardTypeStr);
		
		return "licenseBoards/boards/boardsView";
	}
	
	//QnA �Խ��� �� �ۼ�
	@RequestMapping(value="/lists/{jmcd}/QnA/write", method=RequestMethod.GET)
	public String qnaBoardWrite(
			@PathVariable("jmcd") String jmcd,
			Model model
			) {
		logger.info("�ڰ��� QnA �Խñ� �ۼ� ������ ����");
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("jmfldnm",jmfldnm);
		model.addAttribute("boardType","QnA");
		model.addAttribute("boardTypeStr", "QnA");
		
		
		return "licenseBoards/boards/boardsWrite";
	}
	//QnA �Խ��� �� �ۼ� ó��
	@RequestMapping(value="/lists/{jmcd}/QnA/write", method=RequestMethod.POST)
	public String qnaBoardWritePost(
			LicenseBoardsVO vo, 
			@RequestParam("file") MultipartFile file,
			@SessionAttribute("user") UserVO user,
			@PathVariable("jmcd") String jmcd
			) throws IllegalStateException, IOException {
		
		vo.setUsersId(user.getId());
		vo.setLicenseListJmcd(jmcd);
		//lboardService.insertQnABoardOne(vo,file);
		
		logger.info(vo.getUsersId()+","+vo.getLicenseListJmcd());
		
		lboardService.insertQnABoardOne(vo);
		lboardService.insertlBoardFiles(file,vo.getBoardNum());
		
		logger.info("��ȣ : "+vo.getBoardNum());
		
		return "redirect:/licenses/lists/"+jmcd+"/QnA/"+vo.getBoardNum();
		
	}
	
	//QnA �Խ��� �� ����
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}/update", method=RequestMethod.GET)
	public String qnaBoardUpdate(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			Model model,
			LicenseBoardsVO vo
			) {
		logger.info("�ڰ��� QnA {}�� �Խñ� ���� ������ ����",boardNum);
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		vo = lboardService.selectQnABoardOne(boardNum);
		
		model.addAttribute("jmfldnm", jmfldnm);
		model.addAttribute("board",vo);
		model.addAttribute("boardTypeStr","QnA");
		
		return "licenseBoards/boards/boardsUpdate";
	}
	//QnA �Խ��� �� ���� ó��
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}/update", method=RequestMethod.POST)
	public String qnaBoardUpdate(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			@RequestParam("file") MultipartFile file,
			LicenseBoardsVO vo
			) {
		
		int result = lboardService.updateQnABoardOne(vo);
		
		try {
			lboardService.insertlBoardFiles(file, boardNum);
		} catch (IllegalStateException e) {
			
			//e.printStackTrace();
		} catch (IOException e) {
			
			//e.printStackTrace();
		}
		
		logger.info("�ڰ��� QnA {}�� �Խñ� ���� ó��",boardNum);
		
		return "redirect:/licenses/lists/"+jmcd+"/QnA/"+vo.getBoardNum();
	}
	
	//QnA �Խ��� ���� ����
	@PostMapping("/lists/{jmcd}/QnA/{boardNum}/file-update/{fileNum}")
	@ResponseBody
	public void qnaBoardBoardUpdateFileDelete(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			@PathVariable("fileNum") int fileNum
			) {
		lboardService.deletelBoardFileOne(fileNum);
	}
	
	//QnA �Խ��� �� ���� ó��
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}/delete", method=RequestMethod.POST)
	public String qnaBoardDelete(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum
			) {
		logger.info("�ڰ��� QnA {}�� �Խñ� ����",boardNum);
		
		int result = lboardService.deleteQnABoardOne(boardNum);
		
		return "redirect:/licenses/lists/"+jmcd+"/QnA";
	}
	
	/*----------QnA �Ű�----------*/
	//QnA �Ű� ȭ��
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}/report", method=RequestMethod.GET)
	public String qnaReport(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum
			) {
		
		return "licenseBoards/licenseBoardReportPopup";
	}
	//QnA �Ű� ó��
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}/report", method=RequestMethod.POST)
	
	public void qnaReportPost(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			@SessionAttribute("user") UserVO user,
			@RequestParam("etcOrExplanation") String etcOrExplanation,
			LicenseBoardReportVO vo,
			HttpServletResponse response
			) throws IOException  {
		vo.setUsersId(user.getId());
		vo.setLicenseBoardsBoardNum(boardNum);
		vo.setReportContent(etcOrExplanation);
		
		logger.info("QnA �Խ��� �Ű� ó����!");
		
		lboardService.insertQnABoardReportOne(vo);
		
		response.setContentType("text/html");
		response.getWriter().append("<script>window.close();</script>");
		
	}
	
	
	/*----------QnA ���----------*/
	
	//QnA �Խ��� ��� �ۼ�
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}/comment/write", method=RequestMethod.POST)
	@ResponseBody
	public LicenseBoardsCommentVO qnaBoardCommentWrite(
			/*@RequestParam("usersId") String id,
			@RequestParam("licenseBoardsBoardNum") int boardNum,
			@RequestParam("content") String content,
			@RequestParam("parentComment") int parentCommentNum*/
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			LicenseBoardsCommentVO cvo
			) throws Exception{
		
		//int intBoardNum = Integer.parseInt(boardNum);
		
		//LicenseBoardsCommentVO cvo = new LicenseBoardsCommentVO();
		/*cvo.setUsersId(id);
		cvo.setLicenseBoardsBoardNum(boardNum);
		cvo.setContent(content);
		cvo.setParentCommentNum(parentCommentNum);*/
		
		logger.info("��� ���� : {}, ���̵� : {}",cvo.getContent(),cvo.getUsersId());
		logger.info("�ۼ��� ���̵� : {} \n�Խù� ��ȣ : {}",cvo.getUsersId(),cvo.getLicenseBoardsBoardNum());
		logger.info("�θ��� ��ȣ : {} \n��� ���� : {}",cvo.getParentCommentNum(),cvo.getContent());
		
		int result = lboardService.insertLicenseCommentOne(cvo);
		
		logger.info("�ۼ��� ���̵� : {} \n�Խù� ��ȣ : {}",cvo.getUsersId(),cvo.getLicenseBoardsBoardNum());
		logger.info("�θ��� ��ȣ : {} \n��� ���� : {}",cvo.getParentCommentNum(),cvo.getContent());
		
		String resultStr;
		if(result >= 1) {
			resultStr = "success";
		}
		else {
			resultStr = "fail";
		}
		
		logger.info("��� ���� ��� : {}",resultStr);
		
		cvo = lboardService.selectLicenseCommentOne(cvo.getCommentNum());
		
		return cvo;
	}
	
	//QnA �Խ��� ��� �ϳ� ��ȸ
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}/comment/read-one", method=RequestMethod.POST)
	@ResponseBody
	public LicenseBoardsCommentVO qnaBoardCommentReadOne(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			LicenseBoardsCommentVO cvo
			) {
		
		return lboardService.selectLicenseCommentOne(cvo.getCommentNum());
		
	}
	
	//QnA �Խ��� ��� ����
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}/comment/update", method=RequestMethod.POST)
	@ResponseBody
	public LicenseBoardsCommentVO qnaBoardCommentUpdate(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			LicenseBoardsCommentVO uvo
			) {
		
		int result = lboardService.updateLicenseCommentOne(uvo);
		
		uvo = lboardService.selectLicenseCommentOne(uvo.getCommentNum());
		
		return uvo;
	}
	
	//QnA �Խ��� ��� ����
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}/comment/delete", method=RequestMethod.POST)
	@ResponseBody
	public int qnaBoardCommentDelete(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			@RequestParam("commentNum") int commentNum
			) {
		
		//int commentNum = Integer.parseInt(commentNumStr);
		
		logger.info(""+commentNum);
		int result = lboardService.deleteLicenseCommentOne(commentNum);
		
		return result;
	}
	
//---------------------------------------------------------------------------------------------------------------------------
	//�ڷ��
	
	//�ڷ�� ��� ��ȸ
	@RequestMapping(value="/lists/{jmcd}/dataroom", method=RequestMethod.GET)
	public String dataroomBoards(
			Model model,
			@PathVariable("jmcd") String jmcd
			) {
		logger.info("�ڰ��� �ڷ�� ��� ����");
		
		List<LicenseBoardsVO> lists = lboardService.selectDataroomBoards(jmcd);
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		model.addAttribute("boardList",lists);
		model.addAttribute("jmcd", jmcd);
		model.addAttribute("jmfldnm", jmfldnm);
		model.addAttribute("boardType","dataroom");
		model.addAttribute("boardTypeStr","�ڷ��");
		
		return "licenseBoards/boards/boardList";
	}
	
	//�ڷ�� ����ȸ
	@RequestMapping(value="/lists/{jmcd}/dataroom/{boardNum}", method=RequestMethod.GET)
	public String dataroomBoardView(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			@SessionAttribute(name="user", required=false) UserVO user,
			Model model
			) {
		logger.info("�ڰ��� �ڷ�� ����ȸ ����");
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		LicenseBoardsVO vo = lboardService.selectQnABoardOne(boardNum);
		
		if(user != null) {
			if(!(user.getId().equals(vo.getUsersId()))) {
				//logger.info("1");
				//logger.info(user.getId());
				VisitLicenseBoardVO vvo = new VisitLicenseBoardVO();
				vvo.setUsersId(user.getId());
				vvo.setLicenseBoardNum(boardNum);
				lboardService.insertQnABoardVisit(vvo);
			}
			
		}
		
		logger.info("{} �ڰ��� QnA�Խ��� {}�� �Խù� ����ȸ ����",jmfldnm,boardNum);
		
		logger.info("�ڰ��� �̸� : {}",jmfldnm);
		
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("jmfldnm",jmfldnm);
		model.addAttribute("board",vo);
		model.addAttribute("boardType","dataroom");
		model.addAttribute("boardTypeStr","�ڷ��");
		
		return "licenseBoards/boards/boardsView";
	}
	
	//�ڷ�� ���ۼ�
	@RequestMapping(value="/lists/{jmcd}/dataroom/write", method=RequestMethod.GET)
	public String dataroomBoardWrite(
			@PathVariable("jmcd") String jmcd,
			Model model
			) {
		logger.info("�ڰ��� �Խ��� �۾��� ����");
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("jmfldnm",jmfldnm);
		
		return "licenseBoards/boards/boardsWrite";
	}
	
	//�ڷ�� �� �ۼ� ó��
	@RequestMapping(value="", method=RequestMethod.POST)
	public String dataroomBoardWritePost(
			LicenseBoardsVO vo,
			@RequestParam("file") MultipartFile file,
			@SessionAttribute("user") UserVO user,
			@PathVariable("jmcd") String jmcd
			) throws IllegalStateException, IOException {
		
		vo.setUsersId(user.getId());
		vo.setLicenseListJmcd(jmcd);

		lboardService.insertQnABoardOne(vo);
		lboardService.insertlBoardFiles(file,vo.getBoardNum());
		
		return "redirect:/licenses/lists/"+jmcd+"/QnA/"+vo.getBoardNum();
	}
	
	//�ڷ�� �ۼ���
	@RequestMapping(value="/lists/{jmcd}/dataroom/{boardNum}/update", method=RequestMethod.GET)
	public String dataroomBoardUpdate(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			Model model,
			LicenseBoardsVO vo
			) {
		logger.info("�ڰ��� �Խ��� �ۼ��� ����");
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		vo = lboardService.selectQnABoardOne(boardNum);

		String boardTypeStr = "�ڷ��";

		model.addAttribute("jmfldnm", jmfldnm);
		model.addAttribute("board",vo);
		model.addAttribute("boardType","dataroom");
		model.addAttribute("boardTypeStr",boardTypeStr);
		
		return "licenseBoards/dataroom/dataroomUpdate";
	}
	
	//�ڷ�� �� ���� ó��
	@PostMapping("/lists/{jmcd}/dataroom/{boardNum}/update")
	public String dataroomBoardUpdatePost(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			@RequestParam("file") MultipartFile file,
			LicenseBoardsVO vo
			) {
		
		int result = lboardService.updateQnABoardOne(vo);
		
		try {
			lboardService.insertlBoardFiles(file, boardNum);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		
		logger.info("�ڰ��� QnA {}�� �Խñ� ���� ó��",boardNum);
		
		return "redirect:/licenses/lists/"+jmcd+"/dataroom/"+vo.getBoardNum();
		
	}
	
	//�ڷ�� �ۻ���
	@RequestMapping(value="/lists/{jmcd}/dataroom/{boardNum}/delete", method=RequestMethod.POST)
	@ResponseBody
	public String dataroomBoardDelete(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum
			) {
		logger.info("�ڰ��� �Խ��� ����");

		int result = lboardService.deleteQnABoardOne(boardNum);
		
		return "redirect:/licenseBoards/dataroom/dataroomBoards";
	}
	
}
