package com.pro.jacat.file.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.file.vo.BoardsFileVO;

@Repository
public class FileRepository {
	
	private SqlSession template;
	
	@Autowired
	public FileRepository(SqlSession template) {
		this.template = template;
	}



	public void insertFileBoardList(List<BoardsFileVO> fileList) {
		template.insert("fileBoardsMapper.insertFileBoardList", fileList);
	}

}
