package com.pro.jacat.csc.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pro.jacat.csc.vo.CscCommentsVO;
import com.pro.jacat.csc.vo.CscVO;

@Repository
public class CscRepository {

	private SqlSession template;
	
	public CscRepository(SqlSession template) {
		this.template = template;
	}

	public int insertBoardsOne(CscVO csc) {
		return template.insert("cscMapper.insertBoardsOne", csc);
	}

	public List<CscVO> selectBoardsAll(CscVO csc) {
		return template.selectList("cscMapper.selectBoardsAll", csc);
	}

	public CscVO selectBoardsOne(CscVO csc) {
		return template.selectOne("cscMapper.selectBoardsOne", csc);
	}

	public void updateBoards(CscVO csc) {
		template.update("cscMapper.updateBoards", csc);
		
	}

	public void deleteBoards(CscVO csc) {
		template.update("cscMapper.deleteBoards", csc);
		
	}

	public int insertComments(CscCommentsVO cscCommentsVO) {
		return template.insert("cscMapper.insertComments", cscCommentsVO);
	}

	public List<CscCommentsVO> selectCommentsAll(int boardsBoardNum) {
		return template.selectList("cscMapper.selectCommentsAll", boardsBoardNum);
	}

	public void deleteComments(int commentNum) {
		template.update("cscMapper.deleteComments", commentNum);
		
	}

	public void updateComments(CscCommentsVO cscCommentsVO) {
		template.update("cscMapper.updateComments", cscCommentsVO);
		
	}

}
