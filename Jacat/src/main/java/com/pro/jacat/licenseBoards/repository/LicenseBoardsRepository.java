package com.pro.jacat.licenseBoards.repository;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Repository;

import com.pro.jacat.licenseBoards.vo.FileLicenseBoardVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardReportVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsCommentVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsVO;
import com.pro.jacat.licenseBoards.vo.UsersFavoritesLicenseVO;
import com.pro.jacat.licenseBoards.vo.VisitLicenseBoardVO;
import com.pro.jacat.licenses.vo.LicenseListVO;

@Repository
public class LicenseBoardsRepository {
	private final SqlSession template;

	//생성자
	@Autowired
	public LicenseBoardsRepository(SqlSession template) {
		//super();
		this.template = template;
	}
	
	//자격증 목록조회
	public List<LicenseListVO> selectLicenseLists() {
		return template.selectList("licenseBoardMapper.selectLicenseLists");
	}
	//자격증 상세조회
	public LicenseListVO selectLicenseOne(String jmcd) {
		return template.selectOne("licenseBoardMapper.selectLicenseOne",jmcd);
	}
	//관심자격증 추가
	public int insertFavoriteLicenseOne(UsersFavoritesLicenseVO vo) {
		return template.insert("licenseBoardMapper.insertFavoriteLicenseOne",vo);
	}
	//관심자격증 제거
	public int deleteFavoriteLicenseOne(UsersFavoritesLicenseVO vo) {
		return template.delete("licenseBoardMapper.deleteFavoriteLicenseOne", vo);
	}
	//관심자격증 여부 조회
	public int selectFavoriteLicenseYN(UsersFavoritesLicenseVO vo) {
		return template.selectOne("licenseBoardMapper.selectFavoriteLicenseYN",vo);
	}
	
	//QnA 게시판 목록조회
	public List<LicenseBoardsVO> selectQnABoards(String jmcd){
		return template.selectList("licenseBoardMapper.selectQnABoards", jmcd);
	}
	//QnA 게시판 상세조회
	public LicenseBoardsVO selectQnABoardOne(int boardNum) {
		return template.selectOne("licenseBoardMapper.selectQnABoardOne",boardNum);
	}
	//QnA 게시판 글 작성
	public int insertQnABoardOne(LicenseBoardsVO vo) {
		return template.insert("licenseBoardMapper.insertQnABoardOne",vo);
	}
	//QnA 게시판 글 수정
	public int updateQnABoardOne(LicenseBoardsVO vo) {
		return template.update("licenseBoardMapper.updateQnABoardOne",vo);
	}
	//QnA 게시판 글 삭제
	public int deleteQnABoardOne(int boardNum) {
		return template.update("licenseBoardMapper.deleteQnABoardOne",boardNum);
	}
	//QnA 게시판 게시글 신고
	public int insertQnABoardReportOne(LicenseBoardReportVO vo) {
		return template.insert("licenseBoardMapper.insertQnABoardReportOne",vo);
	}
	//자격증 자료실 목록조회
	public List<LicenseBoardsVO> selectDataroomBoards(){
		return template.selectList("licenseBoardMapper.selectDataroomBoards");
	}
	//자격증 자료실 상세조회
	public LicenseBoardsVO selectDataroomBoardOne(int boardNum) {
		return template.selectOne("licenseBoardMapper.selectDataroomBoardOne",boardNum);
	}
	//자격증 자료실 글 작성
	public int insertDataroomBoardOne(LicenseBoardsVO vo) {
		return template.insert("licenseBoardMapper.insertDataroomBoardOne",vo);
	}
	//자격증 자료실 글 수정
	public int updateDataroomBoardOne(LicenseBoardsVO vo) {
		return template.update("licenseBoardMapper.updateDataroomBoardOne",vo);
	}
	//자격증 자료실 글 삭제
	public int deleteDataroomBoardOne(LicenseBoardsVO vo) {
		return template.update("licenseBoardMapper.deleteDataroomBoardOne",vo);
	}
	
	//종목코드로 자격증 이름 조회하는 메서드 
	public String selectLicenseNameOne(String jmcd) {
		return template.selectOne("licenseBoardMapper.selectLicenseNameOne",jmcd);
	}
	
	//QnA 게시판 댓글 작성
	public int insertLicenseCommentOne(LicenseBoardsCommentVO vo){
		return template.insert("licenseBoardMapper.insertLicenseCommentOne",vo);
	}
	
	//QnA 게시판 댓글 단건 조회
	public LicenseBoardsCommentVO selectLicenseCommentOne(int commentNum) {
		return template.selectOne("licenseBoardMapper.selectLicenseCommentOne",commentNum);
	}
	
	//QnA 게시판 댓글 수정
	public int updateLicenseCommentOne(LicenseBoardsCommentVO vo) {
		return template.update("licenseBoardMapper.updateLicenseCommentOne",vo);
	}
	//QnA 게시판 댓글 삭제
	public int deleteLicenseCommentOne(int commentNum) {
		return template.update("licenseBoardMapper.deleteLicenseCommentOne",commentNum);
	}
	
	public int insertlBoardFiles(FileLicenseBoardVO vo) {
		return template.insert("licenseBoardsFilesMapper.insertlBoardFiles",vo);
	}
	
	public int deletelBoardFileOne(int fileNum) {
		return template.delete("licenseBoardsFilesMapper.deletelBoardFileOne", fileNum);
	}
	
	//게시글 조회수 
	public int insertQnABoardVisit(VisitLicenseBoardVO vvo) {
		try {
			return template.insert("licenseBoardMapper.insertQnABoardVisit", vvo);
		}catch(DuplicateKeyException e) {
			//e.printStackTrace();
			return 0;
		}
		
	}
}
