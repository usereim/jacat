package com.pro.jacat.mypage.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.jacat.csc.vo.CscVO;
import com.pro.jacat.freeboard.vo.FreeBoardReportVO;
import com.pro.jacat.freeboard.vo.FreeBoardVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardReportVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsVO;
import com.pro.jacat.licenseBoards.vo.UsersFavoritesLicenseVO;
import com.pro.jacat.mypage.repository.MypageRepository;
import com.pro.jacat.mypage.response.BoardResponse;

@Service
public class MypageServiceImpl implements MypageService {
	private final MypageRepository mypageRepository;
	
	@Autowired
	public MypageServiceImpl(MypageRepository mypageRepository) {
		this.mypageRepository = mypageRepository;
	}

	@Override
	public BoardResponse<FreeBoardVO> selectFreeBoardById(String id) {
		BoardResponse<FreeBoardVO> boardResponse = new BoardResponse<>();
		boardResponse.setBoardList(mypageRepository.selectFreeBoardById(id));
		return boardResponse;
	}

	@Override
	public BoardResponse<LicenseBoardsVO> selectLicenseBoards(LicenseBoardsVO vo) {
		BoardResponse<LicenseBoardsVO> boardResponse = new BoardResponse<>();
		boardResponse.setBoardList(mypageRepository.selectLicenseBoards(vo));
		return boardResponse;
	}

	@Override
	public BoardResponse<CscVO> selectBoards(CscVO vo) {
		BoardResponse<CscVO> boardResponse = new BoardResponse<>();
		boardResponse.setBoardList(mypageRepository.selectBoards(vo));
		return boardResponse;
	}
	
	@Override
	public List<BoardResponse> selectBoardReport(String id) {
		List<BoardResponse> list = new ArrayList<>();
		BoardResponse<FreeBoardReportVO> bReport = new BoardResponse<>();
		BoardResponse<LicenseBoardReportVO> lReport = new BoardResponse<>();
		
		bReport.setBoardList(mypageRepository.selectBoardReport(id));
		lReport.setBoardList(mypageRepository.selectLicenseBoardReport(id));
		
		list.add(bReport);
		list.add(lReport);
		return list;
	}

	@Override
	public List<UsersFavoritesLicenseVO> selectFavoritesLicense(String id) {
		return mypageRepository.selectFavoritesLicense(id);
	}
	
	@Override
	public int deleteUserFavoritesLicense(UsersFavoritesLicenseVO vo) {
		return mypageRepository.deleteUserFavoritesLicense(vo);
	}

}
