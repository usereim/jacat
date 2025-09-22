package com.pro.jacat.licenseBoards.service;

import java.io.File;
import java.io.IOException;
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
import com.pro.jacat.licenses.vo.LicenseListVO;

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
	
	//관심자격증 추가
	@Override
	public int insertFavoriteLicenseOne(UsersFavoritesLicenseVO vo) {
		
		return lBoardRepo.insertFavoriteLicenseOne(vo);
	}
	
	//QnA 게시판 목록조회
	@Override
	public List<LicenseBoardsVO> selectQnABoards(){
		return lBoardRepo.selectQnABoards();
	}
	//QnA 게시판 상세조회
	@Override
	public LicenseBoardsVO selectQnABoardOne(int boardNum) {
		return lBoardRepo.selectQnABoardOne(boardNum);
	}
	
	@Transactional
	//QnA 게시판 글 작성
	/*@Override
	public void insertQnABoardOne(LicenseBoardsVO vo, List<MultipartFile> file)
	throws IllegalStateException, IOException
	{	
		String path = context.getRealPath("/uploads/licenses/boards/files"); 
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdir();
		}
		
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
	@Override
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
	public List<LicenseBoardsVO> selectDataroomBoards(){
		return lBoardRepo.selectDataroomBoards();
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
		
		return lBoardRepo.insertQnABoardReportOne(vo);
	}

	

	
}
