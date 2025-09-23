package com.pro.jacat.mypage.service;

import java.util.List;

import com.pro.jacat.csc.vo.CscVO;
import com.pro.jacat.freeboard.vo.FreeBoardVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsVO;
import com.pro.jacat.licenseBoards.vo.UsersFavoritesLicenseVO;
import com.pro.jacat.mypage.response.BoardResponse;

public interface MypageService {

	BoardResponse<FreeBoardVO> selectFreeBoardById(String id);

	BoardResponse<LicenseBoardsVO> selectLicenseBoards(LicenseBoardsVO vo);

	BoardResponse<CscVO> selectBoards(CscVO vo);

	List<BoardResponse> selectBoardReport(String id);

	List<UsersFavoritesLicenseVO> selectFavoritesLicense(String id);

	int deleteUserFavoritesLicense(UsersFavoritesLicenseVO vo);
}
