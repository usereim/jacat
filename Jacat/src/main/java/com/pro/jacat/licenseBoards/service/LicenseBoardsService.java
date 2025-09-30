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
	
	public List<LicenseListVO> selectAllLicenseLists();
	
	public List<LicenseListVO> selectAllLicenseLists(LicenseListVO vo);
	
	public List<LicenseListVO> selectTechOrProQualLicenseList(String qualgbcd);
	
	public List<LicenseListVO> selectTechQualGradeLicenseList(String seriescd);
	
	public LicenseListVO selectLicenseOne(String jmcd);
	
	public LicenseListVO vacancyDiscernment(LicenseListVO vo);
	
	public int insertFavoriteLicenseOne(UsersFavoritesLicenseVO vo);
	
	public int deleteFavoriteLicenseOne(UsersFavoritesLicenseVO vo);
	
	public String selectFavoriteLicenseYN(UsersFavoritesLicenseVO vo);
	
	public List<LicenseBoardsVO> selectQnABoards(String jmcd);
	
	public LicenseBoardsVO selectLicenseBoardOne(int boardNum);
	/*
	public void insertLicenseBoardOne(LicenseBoardsVO vo, List<MultipartFile> file)
			throws IllegalStateException, IOException;
	*/
	public int insertLicenseBoardOne(LicenseBoardsVO vo) throws IllegalStateException, IOException;
	
	public int updateLicenseBoardOne(LicenseBoardsVO vo);
	
	public int deleteLicenseBoardOne(int boardNum);
	
	public int insertLicenseBoardReportOne(LicenseBoardReportVO vo);
	
	public List<LicenseBoardsVO> selectDataroomBoards(String jmcd);
	
	public String selectLicenseNameOne(String jmcd);
	
	public int insertLicenseCommentOne(LicenseBoardsCommentVO vo);
	
	public LicenseBoardsCommentVO selectLicenseCommentOne(int commentNum);
	
	public int updateLicenseCommentOne(LicenseBoardsCommentVO vo);
	
	public int deleteLicenseCommentOne(int commentNum);
	
	public int insertlBoardFiles(MultipartFile file, int boardNum) throws IllegalStateException, IOException;
	
	public int deletelBoardFileOne(int fileNum);
	
	public int insertLicenseBoardVisit(VisitLicenseBoardVO vvo);
	
	public String boardTypetoString(String boardType);
}
