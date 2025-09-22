package com.pro.jacat.search.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.search.vo.SearchResultVO;

@Repository
public class SearchRepository {
	
	private final SqlSession template;
	
	@Autowired
	public SearchRepository(SqlSession template) {
		this.template =template;
	}

	public List<SearchResultVO> searchAll(String keyword) {
		return template.selectList("SearchMapper.searchAll", keyword);
	}

}
