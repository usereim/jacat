package com.pro.jacat.freeboard.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.freeboard.vo.FreeBoardCommentVO;
import com.pro.jacat.freeboard.vo.FreeBoardVO;

@Repository
public class FreeBoardCommentRepository {
	
	private final SqlSession template;
	
	@Autowired
	public FreeBoardCommentRepository(SqlSession template) {
		this.template = template;
	}
	
	public int insertComment(FreeBoardCommentVO vo) {
		return template.insert("freeboardCommentMapper.insertComment", vo);
	}
	
	public List<FreeBoardCommentVO> selectCComment(int board_num) {
		return template.selectList("freeboardCommentMapper.selectCComment", board_num);
	}
	
	public int updateComment(FreeBoardCommentVO vo) {
		return template.update("freeboardCommentMapper.update", vo);
	}
	
}
