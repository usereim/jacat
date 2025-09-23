package com.pro.jacat.mypage.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.csc.vo.CscVO;
import com.pro.jacat.freeboard.vo.FreeBoardReportVO;
import com.pro.jacat.freeboard.vo.FreeBoardVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardReportVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsVO;
import com.pro.jacat.licenseBoards.vo.UsersFavoritesLicenseVO;

@Repository
public class MypageRepository {
	private final SqlSession template;
	
	@Autowired
	public MypageRepository(SqlSession template) {
		super();
		this.template = template;
	}

	public List<FreeBoardVO> selectFreeBoardById(String id) {
		return template.selectList("mypageMapper.selectFreeBoardById", id);
	}

	public List<LicenseBoardsVO> selectLicenseBoards(LicenseBoardsVO vo) {
		return template.selectList("mypageMapper.selectLicenseBoards", vo);
	}

	public List<CscVO> selectBoards(CscVO vo) {
		return template.selectList("mypageMapper.selectBoards", vo);
	}

	public List<FreeBoardReportVO> selectBoardReport(String id) {
		return template.selectList("mypageMapper.selectBoardReport", id);
	}

	public List<LicenseBoardReportVO> selectLicenseBoardReport(String id) {
		return template.selectList("mypageMapper.selectLicenseBoardReport", id);
	}

	public List<UsersFavoritesLicenseVO> selectFavoritesLicense(String id) {
		return template.selectList("mypageMapper.selectFavoritesLicense", id);
	}

	public int deleteUserFavoritesLicense(UsersFavoritesLicenseVO vo) {
		return template.delete("mypageMapper.deleteUserFavoritesLicense", vo);
	}

}
