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
	
	public List<FreeBoardVO> selectAllBoard(){
		return template.selectList("freeboardMapper.selectAllBoard");
	}
	
	public FreeBoardVO selectBoardByBno(int board_num) {
		return template.selectOne("freeboardMapper.selectBoardByBno");
	}
}
