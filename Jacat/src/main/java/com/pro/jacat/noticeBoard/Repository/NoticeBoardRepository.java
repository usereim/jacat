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
		return template.selectList("NoticeboardMapper.selectAllBoard");
	}
	
	//3. 게시글 단건조회
	public NoticeBoardVO selectBoardByBno(int bno){
		return template.selectOne("NoticeboardMapper.selectBoardByBno", bno);
	}
	
	//2. 게시글 입력
	public int insertNoticeBoard(NoticeBoardVO vo){
		return template.insert("NoticeboardMapper.insertNoticeBoard", vo);
	}
	
	//4. 게시글 수정
	public int updateBoard(NoticeBoardVO vo){
		return template.update("NoticeboardMapper.updateBoard", vo);
	}
	
	//5. 게시글 삭제
	public int deleteBoard(int bno){
		return template.delete("NoticeboardMapper.deleteBoardOne", bno);
	}
}