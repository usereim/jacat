package com.pro.jacat.licenseBoards.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.licenseBoards.vo.LicenseBoardsVO;
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
	
	//QnA 게시판 목록조회
	public List<LicenseBoardsVO> selectQnABoards(){
		return template.selectList("licenseBoardMapper.selectQnABoards");
	}
	//QnA 게시판 상세조회
	public LicenseBoardsVO selectQnABoardOne(int boardNum) {
		return template.selectOne("licenseBoardMapper.selectQnABoardOne",boardNum);
	}
	//QnA 게시판 글 작성
	public int insertQnABoardOne(LicenseBoardsVO vo) {
		return template.insert("licenseBoardMapper.insertBoardOne",vo);
	}
	//QnA 게시판 글 수정
	public int updateQnABoardOne(LicenseBoardsVO vo) {
		return template.update("licenseBoardMapper.updateBoardOne",vo);
	}
	//QnA 게시판 글 삭제
	public int deleteQnABoardOne(LicenseBoardsVO vo) {
		return template.update("licenseBoardMapper.deleteBoardOne",vo);
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
}
