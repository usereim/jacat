package com.pro.jacat.licenseBoards.service;

import java.io.File;
import java.io.IOException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.licenseBoards.repository.LicenseBoardsFileRepository;
import com.pro.jacat.licenseBoards.repository.LicenseBoardsRepository;
import com.pro.jacat.licenseBoards.vo.FileLicenseBoardVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardReportVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsCommentVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsVO;
import com.pro.jacat.licenseBoards.vo.UsersFavoritesLicenseVO;
import com.pro.jacat.licenseBoards.vo.VisitLicenseBoardVO;
import com.pro.jacat.licenses.vo.LicenseListVO;
import com.pro.jacat.licenses.vo.LicenseTestDateVO;

@Service
public class LicenseBoardsServiceImpl implements LicenseBoardsService {
	
	private static final Logger logger = LoggerFactory.getLogger(LicenseBoardsService.class);
	private final LicenseBoardsRepository lBoardRepo;
	private final ServletContext context;
	private final LicenseBoardsFileRepository lFileRepo;
	
	//생성자
	@Autowired
	public LicenseBoardsServiceImpl(
			LicenseBoardsRepository lBoardRepo, 
			ServletContext context,
			LicenseBoardsFileRepository lFileRepo
			) {
		//super();
		this.lBoardRepo = lBoardRepo;
		this.context = context;
		this.lFileRepo = lFileRepo;
	}
	
	//자격증 목록 조회
	@Override
	public List<LicenseListVO> selectLicenseLists(){
		return lBoardRepo.selectLicenseLists();
	}
	//자격증 상세조회
	@Override
	public LicenseListVO selectLicenseOne(String jmcd) {
		return lBoardRepo.selectLicenseOne(jmcd);
	}
	//빈자리접수 판별
	@Override
	public LicenseListVO vacancyDiscernment(LicenseListVO vo) {
		
		List<LicenseTestDateVO> dvo = vo.getlTestDate();
		
		// 종목코드가 같다면
		// 회차가 같다면
		// doc_reg_start_dt가 더 작은게 본접수
		// 아니면 빈자리 접수
		
		for(int i=0;i<dvo.size();i++) {
			String[] docRegStartDtArr = dvo.get(i).getDocRegStartDt().split(",");
			String[] docRegEndDtArr = dvo.get(i).getDocRegEndDt().split(",");
			String[] docExamStartDtArr = dvo.get(i).getDocExamStartDt().split(",");
			String[] docExamEndDtArr = dvo.get(i).getDocExamEndDt().split(",");
			
			String[] pracRegStartDtArr = dvo.get(i).getPracRegStartDt().split(",");
			String[] pracRegEndDtArr = dvo.get(i).getPracRegEndDt().split(",");
			String[] pracExamStartDtArr = dvo.get(i).getPracExamStartDt().split(",");
			String[] pracExamEndDtArr = dvo.get(i).getPracExamEndDt().split(",");
			
			//logger.info("리스트 길이 : {}",dvo.size());
			//logger.info("0번 인덱스 : {}",docRegStartDtArr[0]);
			//logger.info("1번 인덱스 : {}",docRegStartDtArr[1]);
			
			int[] intDocRegStartDtArr = new int[docRegStartDtArr.length];
			int[] intDocRegEndDtArr = new int[docRegEndDtArr.length];
			int[] intDocExamStartDtArr = new int[docExamStartDtArr.length];
			int[] intDocExamEndDtArr = new int[docExamEndDtArr.length];
			
			int[] intPracRegStartDtArr = new int[pracRegStartDtArr.length];
			int[] intPracRegEndDtArr = new int[pracRegEndDtArr.length];
			int[] intPracExamStartDtArr = new int[pracExamStartDtArr.length];
			int[] intPracExamEndDtArr = new int[pracExamEndDtArr.length];
			
			//doc transform
			for(int j=0;j<intDocRegStartDtArr.length;j++) {
				intDocRegStartDtArr[j] = Integer.parseInt(docRegStartDtArr[j]);
			}
			for(int j=0;j<intDocRegEndDtArr.length;j++) {
				intDocRegEndDtArr[j] = Integer.parseInt(docRegEndDtArr[j]);
			}
			for(int j=0;j<intDocExamStartDtArr.length;j++) {
				intDocExamStartDtArr[j] = Integer.parseInt(docExamStartDtArr[j]);
			}
			for(int j=0;j<intDocExamEndDtArr.length;j++) {
				intDocExamEndDtArr[j] = Integer.parseInt(docExamEndDtArr[j]);
			}
			
			//prac tarnsform
			for(int j=0;j<intPracRegStartDtArr.length;j++) {
				intPracRegStartDtArr[j] = Integer.parseInt(pracRegStartDtArr[j]);
			}
			for(int j=0;j<intPracRegEndDtArr.length;j++) {
				intPracRegEndDtArr[j] = Integer.parseInt(pracRegEndDtArr[j]);
			}
			for(int j=0;j<intPracExamStartDtArr.length;j++) {
				intPracExamStartDtArr[j] = Integer.parseInt(pracExamStartDtArr[j]);
			}
			for(int j=0;j<intPracExamEndDtArr.length;j++) {
				intPracExamEndDtArr[j] = Integer.parseInt(pracExamEndDtArr[j]);
			}
			
			//doc 값 판별 및 삽입
			if(intDocRegStartDtArr[0] < intDocRegStartDtArr[1]) {
				dvo.get(i).setDocRegStartDt(docRegStartDtArr[0]); 
				dvo.get(i).setDocRegStartVacancyDt(docRegStartDtArr[1]); 
			}
			else {
				dvo.get(i).setDocRegStartDt(docRegStartDtArr[1]);
				dvo.get(i).setDocRegStartVacancyDt(docRegStartDtArr[0]); 
			}
			if(intDocRegEndDtArr[0] < intDocRegEndDtArr[1]) {
				dvo.get(i).setDocRegEndDt(docRegStartDtArr[0]);
				dvo.get(i).setDocRegEndVacancyDt(docRegStartDtArr[1]);
			}
			else {
				dvo.get(i).setDocRegEndDt(docRegStartDtArr[1]);
				dvo.get(i).setDocRegEndVacancyDt(docRegStartDtArr[0]);
			}
			if(intDocExamStartDtArr[0] < intDocExamStartDtArr[1]) {
				dvo.get(i).setDocExamStartDt(docRegStartDtArr[0]);
				dvo.get(i).setDocExamStartVacancyDt(docRegStartDtArr[1]);
			}
			else {
				dvo.get(i).setDocExamStartDt(docRegStartDtArr[1]);
				dvo.get(i).setDocExamStartVacancyDt(docRegStartDtArr[0]);
			}
			if(intDocExamEndDtArr[0] < intDocExamEndDtArr[1]) {
				dvo.get(i).setDocExamEndDt(docRegStartDtArr[0]);
				dvo.get(i).setDocExamEndVacancyDt(docRegStartDtArr[1]);
			}
			else {
				dvo.get(i).setDocExamEndDt(docRegStartDtArr[1]);
				dvo.get(i).setDocExamEndVacancyDt(docRegStartDtArr[0]);
			}
			
			
			//prac 값 판별 및 삽입
			if(intPracRegStartDtArr[0] < intPracRegStartDtArr[1]) {
				dvo.get(i).setPracRegStartDt(pracRegStartDtArr[0]); 
				dvo.get(i).setPracRegStartVacancyDt(pracRegStartDtArr[1]); 
			}
			else {
				dvo.get(i).setPracRegStartDt(pracRegStartDtArr[1]);
				dvo.get(i).setPracRegStartVacancyDt(pracRegStartDtArr[0]); 
			}
			if(intPracRegEndDtArr[0] < intPracRegEndDtArr[1]) {
				dvo.get(i).setPracRegEndDt(pracRegStartDtArr[0]);
				dvo.get(i).setPracRegEndVacancyDt(pracRegStartDtArr[1]);
			}
			else {
				dvo.get(i).setPracRegEndDt(pracRegStartDtArr[1]);
				dvo.get(i).setPracRegEndVacancyDt(pracRegStartDtArr[0]);
			}
			if(intPracExamStartDtArr[0] < intPracExamStartDtArr[1]) {
				dvo.get(i).setPracExamStartDt(pracRegStartDtArr[0]);
				dvo.get(i).setPracExamStartVacancyDt(pracRegStartDtArr[1]);
			}
			else {
				dvo.get(i).setPracExamStartDt(pracRegStartDtArr[1]);
				dvo.get(i).setPracExamStartVacancyDt(pracRegStartDtArr[0]);
			}
			if(intPracExamEndDtArr[0] < intPracExamEndDtArr[1]) {
				dvo.get(i).setPracExamEndDt(pracRegStartDtArr[0]);
				dvo.get(i).setPracExamEndVacancyDt(pracRegStartDtArr[1]);
			}
			else {
				dvo.get(i).setPracExamEndDt(pracRegStartDtArr[1]);
				dvo.get(i).setPracExamEndVacancyDt(pracRegStartDtArr[0]);
			}
			
			
		}
		
		
		return vo;
	}
	
	//관심자격증 추가
	@Override
	public int insertFavoriteLicenseOne(UsersFavoritesLicenseVO vo) {
		
		return lBoardRepo.insertFavoriteLicenseOne(vo);
	}
	//관심자격증 제거
	@Override
	public int deleteFavoriteLicenseOne(UsersFavoritesLicenseVO vo) {
		
		return lBoardRepo.deleteFavoriteLicenseOne(vo);
	}
	//관심자격증 여부 조회
	@Override
	public String selectFavoriteLicenseYN(UsersFavoritesLicenseVO vo) {
		
		int result = lBoardRepo.selectFavoriteLicenseYN(vo);
		
		String favoriteLicenseYN;
		
		if(result == 1) {
			favoriteLicenseYN = "Y";
		}
		else {
			favoriteLicenseYN = "N";
		}
		
		return favoriteLicenseYN;
	}
	
	//QnA 게시판 목록조회
	@Override
	public List<LicenseBoardsVO> selectQnABoards(String jmcd){
		return lBoardRepo.selectQnABoards(jmcd);
	}
	//QnA 게시판 상세조회
	@Override
	public LicenseBoardsVO selectQnABoardOne(int boardNum) {
		return lBoardRepo.selectQnABoardOne(boardNum);
	}
	
	
	@Override
	@Transactional
	public int insertQnABoardOne(LicenseBoardsVO vo) throws IllegalStateException, IOException {
		//게시글 insert
		return lBoardRepo.insertQnABoardOne(vo);
		
	}
	
	//QnA 게시판 글 수정
	@Override
	public int updateQnABoardOne(LicenseBoardsVO vo) {
		return lBoardRepo.updateQnABoardOne(vo);
	}
	//QnA 게시판 글 삭제
	@Override
	public int deleteQnABoardOne(int boardNum) {
		return lBoardRepo.deleteQnABoardOne(boardNum);
	}
	
	//자격증 자료실 목록조회
	@Override
	public List<LicenseBoardsVO> selectDataroomBoards(String jmcd){
		return lBoardRepo.selectDataroomBoards(jmcd);
	}
	//자격증 자료실 상세조회
	@Override
	public LicenseBoardsVO selectDataroomBoardOne(int boardNum) {
		return lBoardRepo.selectDataroomBoardOne(boardNum);
	}
	//자격증 자료실 글 작성
	@Override
	public int insertDataroomBoardOne(LicenseBoardsVO vo) {
		return lBoardRepo.insertDataroomBoardOne(vo);
	}
	//자격증 자료실 글 수정
	@Override
	public int updateDataroomBoardOne(LicenseBoardsVO vo) {
		return lBoardRepo.updateDataroomBoardOne(vo);
	}
	//자격증 자료실 글 삭제
	@Override
	public int deleteDataroomBoardOne(LicenseBoardsVO vo) {
		return lBoardRepo.deleteDataroomBoardOne(vo);
	}

	//종목코드로 자격증 이름 조회 메서드 
	@Override
	public String selectLicenseNameOne(String jmcd) {
		return lBoardRepo.selectLicenseNameOne(jmcd);
	}
	
	//QnA 게시판 댓글 작성
	@Override
	public int insertLicenseCommentOne(LicenseBoardsCommentVO vo) {
		
		return lBoardRepo.insertLicenseCommentOne(vo);
	}
	
	//QnA 게시판 댓글 하나 조회
	@Override
	public LicenseBoardsCommentVO selectLicenseCommentOne(int commentNum) {
		
		return lBoardRepo.selectLicenseCommentOne(commentNum);
	}
	
	//QnA 게시판 댓글 수정
	@Override
	public int updateLicenseCommentOne(LicenseBoardsCommentVO vo) {
		
		return lBoardRepo.updateLicenseCommentOne(vo);
	}
	
	//QnA 게시판 댓글 삭제
	@Override
	public int deleteLicenseCommentOne(int commentNum) {
		
		return lBoardRepo.deleteLicenseCommentOne(commentNum);
		
	}
	
	//QnA 게시판 게시글 신고
	@Override
	public int insertQnABoardReportOne(LicenseBoardReportVO vo) {
		
		int result = lBoardRepo.insertQnABoardReportOne(vo);
		
		if(result != 0) {
			logger.info("QnA 게시판 신고 완료!");
		}
		else {
			logger.info("QnA 게시판 신고 중 이상 발생!");
		}
		
		return result;
	}
	
	//QnA 게시글 파일 업로드
	@Override
	public int insertlBoardFiles(MultipartFile file, int boardNum) throws IllegalStateException, IOException{
		
		if(file.isEmpty()) {
			throw new IllegalStateException();
		}
		
		String path = context.getRealPath("/uploads/licenses/boards/files/"+boardNum +"/"); 
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdir();
		}
		
		FileLicenseBoardVO fvo = new FileLicenseBoardVO(); 
		
		String realFileName = file.getOriginalFilename();
		String ext = realFileName.substring(realFileName.lastIndexOf("."));
		
		String fileName = UUID.randomUUID().toString() + ext;
		
		String type = file.getContentType();
		
		file.transferTo(new File(path+fileName));
		
		fvo.setLicenseBoardsBoardNum(boardNum);
		fvo.setRealFileName(realFileName);
		fvo.setFileName(fileName);
		fvo.setPath(path);
		fvo.setType(type);
		return lBoardRepo.insertlBoardFiles(fvo);
		
	}
	
	@Override
	public int deletelBoardFileOne(int fileNum) {
		return lBoardRepo.deletelBoardFileOne(fileNum);
	}

	//게시글 조회수 추가 
	@Override
	public int insertQnABoardVisit(VisitLicenseBoardVO vvo) {
		
		return lBoardRepo.insertQnABoardVisit(vvo);
		
	}

	
	//QnA 게시판 글 작성
	/*@Override
	public void insertQnABoardOne(LicenseBoardsVO vo, List<MultipartFile> file)
	throws IllegalStateException, IOException
	{	
		
		
		//게시글 insert
		lBoardRepo.insertQnABoardOne(vo);
		
		//첨부파일 업로드
		List<FileLicenseBoardVO> list = new ArrayList<>();
		
		for(MultipartFile f : file) {
			if(f.isEmpty()) {
				continue;
			}
			
			String realFileName = f.getOriginalFilename();
			String ext = realFileName.substring(realFileName.lastIndexOf("."));
			
			String fileName = UUID.randomUUID().toString() + ext;
			//long fileSize = f.getSize();
			String fileType = f.getContentType();
			
			f.transferTo(new File(path+fileName));
			
			FileLicenseBoardVO flbVO = new FileLicenseBoardVO();
			flbVO.setLicenseBoardsBoardNum(vo.getBoardNum());
			flbVO.setRealFileName(realFileName);
			flbVO.setFileName(fileName);
			flbVO.setPath(path);
			flbVO.setType(fileType);
			
			list.add(flbVO);
			
		}
		
		if(!list.isEmpty()) {
			lFileRepo.insertFiles(list);
		}
		
	}*/

	
}
