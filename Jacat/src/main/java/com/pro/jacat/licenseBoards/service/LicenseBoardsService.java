package com.pro.jacat.licenseBoards.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.licenseBoards.vo.FileLicenseBoardVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardReportVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsCommentVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsVO;
import com.pro.jacat.licenseBoards.vo.UsersFavoritesLicenseVO;
import com.pro.jacat.licenseBoards.vo.VisitLicenseBoardVO;
import com.pro.jacat.licenses.vo.LicenseListVO;

public interface LicenseBoardsService {
	
	public List<LicenseListVO> selectLicenseLists();
	
	public LicenseListVO selectLicenseOne(String jmcd);
	
	public LicenseListVO vacancyDiscernment(LicenseListVO vo);
	
	public int insertFavoriteLicenseOne(UsersFavoritesLicenseVO vo);
	
	public int deleteFavoriteLicenseOne(UsersFavoritesLicenseVO vo);
	
	public String selectFavoriteLicenseYN(UsersFavoritesLicenseVO vo);
	
	public List<LicenseBoardsVO> selectQnABoards(String jmcd);
	
	public LicenseBoardsVO selectQnABoardOne(int boardNum);
	/*
	public void insertQnABoardOne(LicenseBoardsVO vo, List<MultipartFile> file)
			throws IllegalStateException, IOException;
	*/
	public int insertQnABoardOne(LicenseBoardsVO vo) throws IllegalStateException, IOException;
	
	public int updateQnABoardOne(LicenseBoardsVO vo);
	
	public int deleteQnABoardOne(int boardNum);
	
	public int insertQnABoardReportOne(LicenseBoardReportVO vo);
	
	public List<LicenseBoardsVO> selectDataroomBoards(String jmcd);
	
	public LicenseBoardsVO selectDataroomBoardOne(int boardNum);
	
	public int insertDataroomBoardOne(LicenseBoardsVO vo);
	
	public int updateDataroomBoardOne(LicenseBoardsVO vo);
	
	public int deleteDataroomBoardOne(LicenseBoardsVO vo);
	
	public String selectLicenseNameOne(String jmcd);
	
	public int insertLicenseCommentOne(LicenseBoardsCommentVO vo);
	
	public LicenseBoardsCommentVO selectLicenseCommentOne(int commentNum);
	
	public int updateLicenseCommentOne(LicenseBoardsCommentVO vo);
	
	public int deleteLicenseCommentOne(int commentNum);
	
	public int insertlBoardFiles(MultipartFile file, int boardNum) throws IllegalStateException, IOException;
	
	public int deletelBoardFileOne(int fileNum);
	
	public int insertQnABoardVisit(VisitLicenseBoardVO vvo);
	
	public String boardTypetoString(String boardType);
}
