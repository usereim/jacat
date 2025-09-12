package com.pro.jacat.freeboard.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.freeboard.vo.FreeBoardVO;

@Repository
public class FreeBoardRepository {

	private final SqlSession template;
	
	@Autowired
	public FreeBoardRepository(SqlSession template) {
		this.template = template;	//SqlSession -> 핵심 객체로 DB쿼리 실행과 매핑을 담당
	}
	
	//목록조회
	public List<FreeBoardVO> selectAllBoard(){
		return template.selectList("freeboardMapper.selectAllBoard");
	}
	
	//단건조회
	public FreeBoardVO selectBoardByBno(int board_num) {
		return template.selectOne("freeboardMapper.selectBoardByBno",board_num);
	}
	
	//게시글 삭제
	public int deleteBoard(int board_num) {
		return template.delete("freeboardMapper.deleteBoard", board_num);
	}
	
	//게시글 수정
	public int updateBoard(FreeBoardVO vo) {
		return template.update("freeboardMapper.updateBoard", vo);
	}
	
	//게시글 입력
	public int insertBoard(FreeBoardVO vo){
		return template.insert("freeboardMapper.insertBoard", vo);
	}

}
