package com.pro.jacat.noticeBoard.Repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.noticeBoard.vo.NoticeBoardVO;

@Repository
public class NoticeBoardRepository {
	
	private final SqlSession template;
	
	@Autowired
	public NoticeBoardRepository(SqlSession template) {
		this.template = template;
	}
	
	public List<NoticeBoardVO> selectAllBoard(){
		return template.selectList("noticeboardMapper.selectAllBoard");
	}
	
	//3. �Խñ� �ܰ���ȸ
	public NoticeBoardVO selectBoardByBno(int bno){
		return template.selectOne("noticeboardMapper.selectBoardByBno", bno);
	}
	
	//2. �Խñ� �Է�
	public int insertBoard(NoticeBoardVO vo){
		return template.insert("NoticeboardMapper.insertBoardOne", vo);
	}
	
	//4. �Խñ� ����
	public int updateBoard(NoticeBoardVO vo){
		return template.update("NoticeboardMapper.updateBoardOne", vo);
	}
	
	//5. �Խñ� ����
	public int deleteBoard(int bno){
		return template.delete("NoticeboardMapper.deleteBoardOne", bno);
	}
}