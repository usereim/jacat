package com.pro.jacat.licenseBoards.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.licenseBoards.vo.FileLicenseBoardVO;

@Repository
public class LicenseBoardsFileRepository {
	private final SqlSession template;

	@Autowired
	public LicenseBoardsFileRepository(SqlSession template) {
		super();
		this.template = template;
	}
	
	public int insertFiles(List<FileLicenseBoardVO> list) {
		return template.insert("licenseBoardsFilesMapper.insertFiles",list);
	}
	
	public int updateFiles(List<FileLicenseBoardVO> list) {
		return template.update(null);
	}
	
}
