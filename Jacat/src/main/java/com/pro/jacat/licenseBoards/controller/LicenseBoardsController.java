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

	//자격증 목록
	@RequestMapping(value="/lists", method=RequestMethod.GET)
	public String licenseInfo(Model model) {
		logger.info("자격증 정보 진입");
		
		List<LicenseListVO> list = lboardService.selectLicenseLists();
		
		model.addAttribute("lList",list);
		
		return "licenseBoards/licenses";
	}
	
	//자격증 상세조회
	@RequestMapping(value="/lists/{jmcd}",method=RequestMethod.GET)
	public String licenseView(
			@PathVariable("jmcd") String jmcd, 
			@SessionAttribute(name="user", required=false) UserVO user,
			Model model) {
		logger.info("자격증 상세정보 진입(jmcd : {})",jmcd);
		
		LicenseListVO vo = lboardService.selectLicenseOne(jmcd);
		
		vo = lboardService.vacancyDiscernment(vo);
		
		if(user != null) {
			UsersFavoritesLicenseVO uvo = new UsersFavoritesLicenseVO();
			uvo.setUsersId(user.getId());
			uvo.setLicenseListJmcd(jmcd);
			
			String favoriteLicenseYN = lboardService.selectFavoriteLicenseYN(uvo);
			model.addAttribute("favoLi", favoriteLicenseYN);
		}
		
		logger.info("{} 상세정보 진입",vo.getJmfldnm());
		
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("lListOne",vo);
		
		
		logger.info("lTest : {}, lTestDate : {}" , 1/*vo.getlTest()*/, vo.getlTestDate());
		logger.info("lTest : {}, lTestDate : {}" , 1/*vo.getlTest()*/, vo.getlTestDate().get(0).getDocExamEndDt());
		logger.info("시행기관 : {}", vo.getLicensingAutority());
		return "licenseBoards/licenseView";
	}
	
	//관심자격증 추가
	@PostMapping("/lists/add-license")
	@ResponseBody
	public int addLisense (
			@RequestParam ("usersId") String id,
			@RequestParam ("licenseListJmcd") String jmcd
			) {
		
		logger.info("{} 사용자 {} 자격증 추가",id,jmcd);
		
		UsersFavoritesLicenseVO vo = new UsersFavoritesLicenseVO();
		vo.setUsersId(id);
		vo.setLicenseListJmcd(jmcd);
		logger.info("{} 사용자 {} 자격증 추가",vo.getUsersId(),vo.getLicenseListJmcd());
		
		int addResult = lboardService.insertFavoriteLicenseOne(vo);
		
		return addResult;
	}
	//관심자격증 제거
	@PostMapping("/lists/del-license")
	@ResponseBody
	public int delLicense(
			UsersFavoritesLicenseVO vo
			) {
		int delResult = lboardService.deleteFavoriteLicenseOne(vo);
		
		return delResult;
		
	}
	
	/*----------QnA----------*/
	
	//QnA 게시판 목록조회
	@RequestMapping(value="/lists/{jmcd}/QnA",method=RequestMethod.GET)
	public String qnaBoards(
			Model model,
			@PathVariable("jmcd") String jmcd
			) throws ClassNotFoundException, SQLException {
		logger.info("자격증 QnA 게시판 목록 진입");
		
		List<LicenseBoardsVO> lists = lboardService.selectQnABoards(jmcd);
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		model.addAttribute("boardList", lists);
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("jmfldnm", jmfldnm);
		
		return "licenseBoards/qnaBoard/qnaBoards";
	}
	
	//QnA 게시판 상세조회
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
		//logger.info("2");
		//logger.info(vo.getUsersId());
		
		
		logger.info("{} 자격증 QnA게시판 {}번 게시물 상세조회 진입",jmfldnm,boardNum);
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
		
		logger.info("자격증 이름 : {}",jmfldnm);
		
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("jmfldnm",jmfldnm);
		model.addAttribute("board",vo);
		
		return "licenseBoards/qnaBoard/qnaBoardsView";
	}
	
	//QnA 게시판 글 작성
	@RequestMapping(value="/lists/{jmcd}/QnA/write", method=RequestMethod.GET)
	public String qnaBoardWrite(
			@PathVariable("jmcd") String jmcd,
			Model model
			) {
		logger.info("자격증 QnA 게시글 작성 페이지 진입");
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("jmfldnm",jmfldnm);
		
		return "licenseBoards/qnaBoard/qnaWrite";
	}
	//QnA 게시판 글 작성 처리
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
		
		logger.info("번호 : "+vo.getBoardNum());
		
		return "redirect:/licenses/lists/"+jmcd+"/QnA/"+vo.getBoardNum();
		
	}
	
	//QnA 게시판 글 수정
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}/update", method=RequestMethod.GET)
	public String qnaBoardUpdate(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			Model model,
			LicenseBoardsVO vo
			) {
		logger.info("자격증 QnA {}번 게시글 수정 페이지 진입",boardNum);
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		vo = lboardService.selectQnABoardOne(boardNum);
		
		model.addAttribute("jmfldnm", jmfldnm);
		model.addAttribute("board",vo);
		
		return "licenseBoards/qnaBoard/qnaUpdate";
	}
	//QnA 게시판 글 수정 처리
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		logger.info("자격증 QnA {}번 게시글 수정 처리",boardNum);
		
		return "redirect:/licenses/lists/"+jmcd+"/QnA/"+vo.getBoardNum();
	}
	
	@PostMapping("/lists/{jmcd}/QnA/{boardNum}/file-update/{fileNum}")
	@ResponseBody
	public void qnaBoardBoardUpdateFileDelete(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			@PathVariable("fileNum") int fileNum
			) {
		lboardService.deletelBoardFileOne(fileNum);
	}
	
	//QnA 게시판 글 삭제 처리
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}/delete", method=RequestMethod.POST)
	public String qnaBoardDelete(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum
			) {
		logger.info("자격증 QnA {}번 게시글 삭제",boardNum);
		
		int result = lboardService.deleteQnABoardOne(boardNum);
		
		return "redirect:/licenses/lists/"+jmcd+"/QnA";
	}
	
	/*----------QnA 신고----------*/
	//QnA 신고 화면
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}/report", method=RequestMethod.GET)
	public String qnaReport(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum
			) {
		
		return "licenseBoards/licenseBoardReportPopup";
	}
	//QnA 신고 처리
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
		
		logger.info("QnA 게시판 신고 처리중!");
		
		lboardService.insertQnABoardReportOne(vo);
		
		response.setContentType("text/html");
		response.getWriter().append("<script>window.close();</script>");
		
	}
	
	
	/*----------QnA 댓글----------*/
	
	//QnA 게시판 댓글 작성
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
		
		logger.info("댓글 내용 : {}, 아이디 : {}",cvo.getContent(),cvo.getUsersId());
		logger.info("작성자 아이디 : {} \n게시물 번호 : {}",cvo.getUsersId(),cvo.getLicenseBoardsBoardNum());
		logger.info("부모댓글 번호 : {} \n댓글 내용 : {}",cvo.getParentCommentNum(),cvo.getContent());
		
		int result = lboardService.insertLicenseCommentOne(cvo);
		
		logger.info("작성자 아이디 : {} \n게시물 번호 : {}",cvo.getUsersId(),cvo.getLicenseBoardsBoardNum());
		logger.info("부모댓글 번호 : {} \n댓글 내용 : {}",cvo.getParentCommentNum(),cvo.getContent());
		
		String resultStr;
		if(result >= 1) {
			resultStr = "success";
		}
		else {
			resultStr = "fail";
		}
		
		logger.info("댓글 쓰기 결과 : {}",resultStr);
		
		cvo = lboardService.selectLicenseCommentOne(cvo.getCommentNum());
		
		return cvo;
	}
	
	//QnA 게시판 댓글 하나 조회
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}/comment/read-one", method=RequestMethod.POST)
	@ResponseBody
	public LicenseBoardsCommentVO qnaBoardCommentReadOne(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			LicenseBoardsCommentVO cvo
			) {
		
		return lboardService.selectLicenseCommentOne(cvo.getCommentNum());
		
	}
	
	//QnA 게시판 댓글 수정
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
	
	//QnA 게시판 댓글 삭제
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
