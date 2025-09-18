package com.pro.jacat.freeboard.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.freeboard.vo.FreeBoardReportVO;

@Repository
public class FreeBoardReportRepository {
	
	private final SqlSession template;
	
	@Autowired
	public FreeBoardReportRepository(SqlSession template) {
		this.template = template;
	}
	
	public int insertReport(FreeBoardReportVO vo) {
		return template.insert("freeboardReportMapper.insertReport", vo);
	}
	
}
