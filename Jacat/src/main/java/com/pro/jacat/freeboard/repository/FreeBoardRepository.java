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
		this.template = template;	//SqlSession -> �ٽ� ��ü�� DB���� ����� ������ ���
	}
	
	//�����ȸ
	public List<FreeBoardVO> selectAllBoard(){
		return template.selectList("freeboardMapper.selectAllBoard");
	}
	
	//�ܰ���ȸ
	public FreeBoardVO selectBoardByBno(int board_num) {
		return template.selectOne("freeboardMapper.selectBoardByBno",board_num);
	}
	
	//�Խñ� ����
	public int deleteBoard(int board_num) {
		return template.delete("freeboardMapper.deleteBoard", board_num);
	}
	
	//�Խñ� ����
	public int updateBoard(FreeBoardVO vo) {
		return template.update("freeboardMapper.updateBoard", vo);
	}
	
	//�Խñ� �Է�
	public int insertBoard(FreeBoardVO vo){
		return template.insert("freeboardMapper.insertBoard", vo);
	}

}
