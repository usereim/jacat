package com.pro.jacat.noticeBoard.Repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.noticeBoard.vo.NoticeBoardFileVO;

@Repository
public class NoticeFileRepository {
		
		private final SqlSession template;
		
		@Autowired
		public NoticeFileRepository(SqlSession template) {
			this.template = template;
		}

		public int insertFiles(List<NoticeBoardFileVO> list) {
			return template.insert("fileMapper.insertFiles", list);
		}
		
		public List<NoticeBoardFileVO> selectFileByBno(int bno){
			return template.selectList("fileMapper.selectFileByBno", bno);
		}
	}
