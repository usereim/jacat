package com.pro.jacat.freeboard.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.freeboard.vo.FreeBoardFileVO;

@Repository
public class FreeBoardFileRepository {
	
	private final SqlSession template;
	
	@Autowired
	public FreeBoardFileRepository(SqlSession template) {
		this.template = template;
	}
	
	public int insertFiles(List<FreeBoardFileVO> list) {
		return template.insert("freeboardFileMapper.insertFiles", list);
	}
	
	public List<FreeBoardFileVO> selectFileByBno(int board_num){
		return template.selectList("freeboardFileMapper.selectFileByBno", board_num);
	}
}
