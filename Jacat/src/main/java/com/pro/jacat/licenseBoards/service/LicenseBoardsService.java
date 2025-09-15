package com.pro.jacat.licenseBoards.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.licenseBoards.vo.LicenseBoardsVO;
import com.pro.jacat.licenses.vo.LicenseListVO;

public interface LicenseBoardsService {
	
	public List<LicenseListVO> selectLicenseLists();
	
	public LicenseListVO selectLicenseOne(String jmcd);
	
	public List<LicenseBoardsVO> selectQnABoards();
	
	public LicenseBoardsVO selectQnABoardOne(int boardNum);
	
	public void insertQnABoardOne(LicenseBoardsVO vo, List<MultipartFile> file)
			throws IllegalStateException, IOException;
	
	public int updateQnABoardOne(LicenseBoardsVO vo);
	
	public int deleteQnABoardOne(LicenseBoardsVO vo);
	
	public List<LicenseBoardsVO> selectDataroomBoards();
	
	public LicenseBoardsVO selectDataroomBoardOne(int boardNum);
	
	public int insertDataroomBoardOne(LicenseBoardsVO vo);
	
	public int updateDataroomBoardOne(LicenseBoardsVO vo);
	
	public int deleteDataroomBoardOne(LicenseBoardsVO vo);
	
}
