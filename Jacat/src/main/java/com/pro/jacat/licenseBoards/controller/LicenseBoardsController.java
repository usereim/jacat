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
		
		
		LicenseListVO vo = lboardService.selectLicenseOne(jmcd);
		
		vo = lboardService.vacancyDiscernment(vo);
		
		if(user != null) {
			UsersFavoritesLicenseVO uvo = new UsersFavoritesLicenseVO();
			uvo.setUsersId(user.getId());
			uvo.setLicenseListJmcd(jmcd);
			
			String favoriteLicenseYN = lboardService.selectFavoriteLicenseYN(uvo);
			model.addAttribute("favoLi", favoriteLicenseYN);
		}
		
		
		
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("lListOne",vo);
		
		
		
		return "licenseBoards/licenseView";
	}
	
	//관심자격증 추가
	@PostMapping("/lists/add-license")
	@ResponseBody
	public int addLisense (
			@RequestParam ("usersId") String id,
			@RequestParam ("licenseListJmcd") String jmcd
			) {
		
		
		
		UsersFavoritesLicenseVO vo = new UsersFavoritesLicenseVO();
		vo.setUsersId(id);
		vo.setLicenseListJmcd(jmcd);
		
		
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
	
	//QnA 게시판 상세조회
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}", method=RequestMethod.GET)
	public String qnaView(
			@PathVariable("boardNum") int boardNum,
			@PathVariable("jmcd") String jmcd,
			@SessionAttribute(name="user", required=false) UserVO user,
			Model model
			) {
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		LicenseBoardsVO vo = lboardService.selectLicenseBoardOne(boardNum);
		
		if(user != null) {
			if(!(user.getId().equals(vo.getUsersId()))) {
				
				VisitLicenseBoardVO vvo = new VisitLicenseBoardVO();
				vvo.setUsersId(user.getId());
				vvo.setLicenseBoardNum(boardNum);
				lboardService.insertLicenseBoardVisit(vvo);
			}
			
		}
		
		String boardTypeStr = lboardService.boardTypetoString(vo.getBoardType());
		
		
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("jmfldnm",jmfldnm);
		model.addAttribute("board",vo);
		model.addAttribute("boardType","QnA");
		model.addAttribute("boardTypeStr",boardTypeStr);
		
		return "licenseBoards/boards/boardsView";
	}
	
	//QnA 게시판 글 작성
	@RequestMapping(value="/lists/{jmcd}/QnA/write", method=RequestMethod.GET)
	public String qnaBoardWrite(
			@PathVariable("jmcd") String jmcd,
			Model model
			) {
		
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("jmfldnm",jmfldnm);
		model.addAttribute("boardType","QnA");
		model.addAttribute("boardTypeStr", "QnA");
		
		
		return "licenseBoards/boards/boardsWrite";
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
		vo.setBoardType("Q");
		//lboardService.insertLicenseBoardOne(vo,file);
		
		
		
		lboardService.insertLicenseBoardOne(vo);
		try {
			lboardService.insertlBoardFiles(file,vo.getBoardNum());
		}catch(IllegalStateException e) {
			
		}catch(IOException e) {
			
		}
		
		
		
		
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
		
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		vo = lboardService.selectLicenseBoardOne(boardNum);
		
		model.addAttribute("jmfldnm", jmfldnm);
		model.addAttribute("board",vo);
		model.addAttribute("boardType","QnA");
		model.addAttribute("boardTypeStr","QnA");
		
		return "licenseBoards/boards/boardsUpdate";
	}
	//QnA 게시판 글 수정 처리
	@RequestMapping(value="/lists/{jmcd}/QnA/{boardNum}/update", method=RequestMethod.POST)
	public String qnaBoardUpdate(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			@RequestParam("file") MultipartFile file,
			LicenseBoardsVO vo
			) {
		
		int result = lboardService.updateLicenseBoardOne(vo);
		
		try {
			lboardService.insertlBoardFiles(file, boardNum);
		} catch (IllegalStateException e) {
			
			//e.printStackTrace();
		} catch (IOException e) {
			
			//e.printStackTrace();
		}
		
		
		
		return "redirect:/licenses/lists/"+jmcd+"/QnA/"+vo.getBoardNum();
	}
	
	//QnA 게시판 파일 삭제
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
		
		
		int result = lboardService.deleteLicenseBoardOne(boardNum);
		
		return "redirect:/licenses/lists/"+jmcd+"/QnA";
	}
	
	/*----------신고----------*/
	//신고 화면
	@RequestMapping(value="/lists/{jmcd}/{boardType}/{boardNum}/report", method=RequestMethod.GET)
	public String qnaReport(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardType") String boardType,
			@PathVariable("boardNum") int boardNum
			) {
		
		return "licenseBoards/licenseBoardReportPopup";
	}
	//신고 처리
	@RequestMapping(value="/lists/{jmcd}/{boardType}/{boardNum}/report", method=RequestMethod.POST)
	
	public void qnaReportPost(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardType") String boardType,
			@PathVariable("boardNum") int boardNum,
			@SessionAttribute("user") UserVO user,
			@RequestParam("etcOrExplanation") String etcOrExplanation,
			LicenseBoardReportVO vo,
			HttpServletResponse response
			) throws IOException  {
		
		vo.setUsersId(user.getId());
		vo.setLicenseBoardsBoardNum(boardNum);
		vo.setReportContent(etcOrExplanation);
		
		lboardService.insertLicenseBoardReportOne(vo);
		
		response.setContentType("text/html");
		response.getWriter().append("<script>window.close();</script>");
		
	}
	
	
	/*----------댓글----------*/
	
	//게시판 댓글 작성
	@RequestMapping(value="/lists/{jmcd}/{boardType}/{boardNum}/comment/write", method=RequestMethod.POST)
	@ResponseBody
	public LicenseBoardsCommentVO qnaBoardCommentWrite(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardType") String boardType,
			@PathVariable("boardNum") int boardNum,
			LicenseBoardsCommentVO cvo
			) throws Exception{
		
		
		int result = lboardService.insertLicenseCommentOne(cvo);
		
		String resultStr;
		if(result >= 1) {
			resultStr = "success";
		}
		else {
			resultStr = "fail";
		}
		
		cvo = lboardService.selectLicenseCommentOne(cvo.getCommentNum());
		
		return cvo;
	}
	
	//게시판 댓글 하나 조회
	@RequestMapping(value="/lists/{jmcd}/{boardType}/{boardNum}/comment/read-one", method=RequestMethod.POST)
	@ResponseBody
	public LicenseBoardsCommentVO qnaBoardCommentReadOne(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardType") String boardType,
			@PathVariable("boardNum") int boardNum,
			LicenseBoardsCommentVO cvo
			) {
		
		return lboardService.selectLicenseCommentOne(cvo.getCommentNum());
		
	}
	
	//게시판 댓글 수정
	@RequestMapping(value="/lists/{jmcd}/{boardType}/{boardNum}/comment/update", method=RequestMethod.POST)
	@ResponseBody
	public LicenseBoardsCommentVO qnaBoardCommentUpdate(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardType") String boardType,
			@PathVariable("boardNum") int boardNum,
			LicenseBoardsCommentVO uvo
			) {
		
		int result = lboardService.updateLicenseCommentOne(uvo);
		
		uvo = lboardService.selectLicenseCommentOne(uvo.getCommentNum());
		
		return uvo;
	}
	
	//게시판 댓글 삭제
	@RequestMapping(value="/lists/{jmcd}/{boardType}/{boardNum}/comment/delete", method=RequestMethod.POST)
	@ResponseBody
	public int qnaBoardCommentDelete(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardType") String boardType,
			@PathVariable("boardNum") int boardNum,
			@RequestParam("commentNum") int commentNum
			) {
		
		//int commentNum = Integer.parseInt(commentNumStr);
		
		
		int result = lboardService.deleteLicenseCommentOne(commentNum);
		
		return result;
	}
	
//---------------------------------------------------------------------------------------------------------------------------
	//자료실
	
	//자료실 목록 조회
	@RequestMapping(value="/lists/{jmcd}/dataroom", method=RequestMethod.GET)
	public String dataroomBoards(
			Model model,
			@PathVariable("jmcd") String jmcd
			) {
		
		
		List<LicenseBoardsVO> lists = lboardService.selectDataroomBoards(jmcd);
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		model.addAttribute("boardList",lists);
		model.addAttribute("jmcd", jmcd);
		model.addAttribute("jmfldnm", jmfldnm);
		model.addAttribute("boardType","dataroom");
		model.addAttribute("boardTypeStr","자료실");
		
		return "licenseBoards/boards/boardList";
	}
	
	//자료실 상세조회
	@RequestMapping(value="/lists/{jmcd}/dataroom/{boardNum}", method=RequestMethod.GET)
	public String dataroomBoardView(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			@SessionAttribute(name="user", required=false) UserVO user,
			Model model
			) {
		
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		LicenseBoardsVO vo = lboardService.selectLicenseBoardOne(boardNum);
		
		//logger.info("vo : "+vo);
		//logger.info("user : "+user);
		
		if(user != null) {
			if(!(user.getId().equals(vo.getUsersId()))) {
				
				VisitLicenseBoardVO vvo = new VisitLicenseBoardVO();
				vvo.setUsersId(user.getId());
				vvo.setLicenseBoardNum(boardNum);
				lboardService.insertLicenseBoardVisit(vvo);
			}
			
		}
		
		
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("jmfldnm",jmfldnm);
		model.addAttribute("board",vo);
		model.addAttribute("boardType","dataroom");
		model.addAttribute("boardTypeStr","자료실");
		
		return "licenseBoards/boards/boardsView";
	}
	
	//자료실 글작성
	@RequestMapping(value="/lists/{jmcd}/dataroom/write", method=RequestMethod.GET)
	public String dataroomBoardWrite(
			@PathVariable("jmcd") String jmcd,
			Model model
			) {
		
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		model.addAttribute("jmcd",jmcd);
		model.addAttribute("jmfldnm",jmfldnm);
		model.addAttribute("boardType","dataroom");
		model.addAttribute("boardTypeStr", "자료실");
		
		return "licenseBoards/boards/boardsWrite";
	}
	
	//자료실 글 작성 처리
	@RequestMapping(value="/lists/{jmcd}/dataroom/write", method=RequestMethod.POST)
	public String dataroomBoardWritePost(
			LicenseBoardsVO vo,
			@RequestParam("file") MultipartFile file,
			@SessionAttribute("user") UserVO user,
			@PathVariable("jmcd") String jmcd
			) throws IllegalStateException, IOException {
		
		vo.setUsersId(user.getId());
		vo.setLicenseListJmcd(jmcd);
		vo.setBoardType("D");

		lboardService.insertLicenseBoardOne(vo);
		
		try {
			lboardService.insertlBoardFiles(file,vo.getBoardNum());
		}catch(IllegalStateException e) {
			
		}catch(IOException e) {
			
		}
		
		return "redirect:/licenses/lists/"+jmcd+"/dataroom/"+vo.getBoardNum();
	}
	
	//자료실 글수정
	@RequestMapping(value="/lists/{jmcd}/dataroom/{boardNum}/update", method=RequestMethod.GET)
	public String dataroomBoardUpdate(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			Model model,
			LicenseBoardsVO vo
			) {
		
		
		String jmfldnm = lboardService.selectLicenseNameOne(jmcd);
		
		vo = lboardService.selectLicenseBoardOne(boardNum);

		model.addAttribute("jmfldnm", jmfldnm);
		model.addAttribute("board",vo);
		model.addAttribute("boardType","dataroom");
		model.addAttribute("boardTypeStr","자료실");
		
		return "licenseBoards/boards/boardsUpdate";
	}
	
	//자료실 글 수정 처리
	@PostMapping("/lists/{jmcd}/dataroom/{boardNum}/update")
	public String dataroomBoardUpdatePost(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum,
			@RequestParam("file") MultipartFile file,
			LicenseBoardsVO vo
			) {
		
		int result = lboardService.updateLicenseBoardOne(vo);
		
		try {
			lboardService.insertlBoardFiles(file, boardNum);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		
		
		
		return "redirect:/licenses/lists/"+jmcd+"/dataroom/"+vo.getBoardNum();
		
	}
	
	//자료실 글삭제 처리
	@RequestMapping(value="/lists/{jmcd}/dataroom/{boardNum}/delete", method=RequestMethod.POST)
	@ResponseBody
	public String dataroomBoardDelete(
			@PathVariable("jmcd") String jmcd,
			@PathVariable("boardNum") int boardNum
			) {
		

		int result = lboardService.deleteLicenseBoardOne(boardNum);
		
		return "redirect:/licenseBoards/dataroom/dataroomBoards";
	}
	
}
