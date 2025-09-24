package com.pro.jacat;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pro.jacat.licenseBoards.service.LicenseBoardsServiceImpl;
import com.pro.jacat.licenses.vo.LicenseListVO;
import com.pro.jacat.noticeBoard.service.NoticeService;
import com.pro.jacat.noticeBoard.vo.NoticeBoardVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private final LicenseBoardsServiceImpl lboardService;
	private final NoticeService nBoardService;
	
	public HomeController(LicenseBoardsServiceImpl lboardService, NoticeService nBoardService) {
		super();
		this.lboardService = lboardService;
		this.nBoardService = nBoardService;
	}

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		List<NoticeBoardVO> nvo = nBoardService.selectAllNoticeBoard();
		List<LicenseListVO> lvo = lboardService.selectLicenseLists();
		
		model.addAttribute("nList", nvo);
		model.addAttribute("lList", lvo);
		
		return "home";
	}
	
}
