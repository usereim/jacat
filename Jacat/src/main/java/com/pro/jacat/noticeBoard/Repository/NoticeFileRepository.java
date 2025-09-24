package com.pro.jacat.noticeBoard.Repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.freeboard.vo.FreeBoardFileVO;
import com.pro.jacat.noticeBoard.vo.NoticeBoardFileVO;

@Repository
public class NoticeFileRepository {
		
		private final SqlSession template;
		
		@Autowired
		public NoticeFileRepository(SqlSession template) {
			this.template = template;
		}

		//
		public void insertFiles(List<FreeBoardFileVO> list) {
			template.insert("freeboardFileMapper.insertFiles", list);
		}	

		
		public List<NoticeBoardFileVO> selectFileByBno(int bno){
			return template.selectList("freeboardFileMapper.selectFileByBno", bno);
		}

		// 파일 삭제
	    public int deleteFile(int fileNum) {
	        return template.delete("freeboardFileMapper.deleteFile", fileNum);
	    }
}
