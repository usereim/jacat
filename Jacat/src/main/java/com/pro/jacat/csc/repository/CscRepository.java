package com.pro.jacat.csc.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pro.jacat.csc.vo.CscVO;

@Repository
public class CscRepository {

	private SqlSession template;
	
	public CscRepository(SqlSession template) {
		this.template = template;
	}

	public void insertBoardsOne(CscVO csc) {
		template.insert("cscMapper.insertBoardsOne", csc);
	}

	public List<CscVO> selectBoardsAllByType(String type) {
		return template.selectList("cscMapper.selectBoardsAllByType", type);
	}

	public CscVO selectBoardsOne(Map<String, Object> map) {
		return template.selectOne("cscMapper.selectBoardsOne", map);
	}

}
