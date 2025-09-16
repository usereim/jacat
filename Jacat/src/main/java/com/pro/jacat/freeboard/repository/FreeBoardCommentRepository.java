package com.pro.jacat.freeboard.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.freeboard.vo.FreeBoardCommentVO;

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
}
