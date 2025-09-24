package com.pro.jacat.freeboard.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.freeboard.vo.FreeBoardFileVO;

@Repository
public class FreeBoardFileRepository {
	
	private final SqlSession template;
	
	@Autowired
	public FreeBoardFileRepository(SqlSession template) {
		this.template = template;
	}
	
	public int insertFiles(List<FreeBoardFileVO> list) {
		return template.insert("freeboardFileMapper.insertFiles", list);
	}
	
	public List<FreeBoardFileVO> selectFileByBno(int board_num){
		return template.selectList("freeboardFileMapper.selectFileByBno", board_num);
	}
	
	// 단건 파일 insert
    public int insertFile(FreeBoardFileVO file) {
        return template.insert("freeboardFileMapper.insertFile", file);
    }

    // 파일 단건 조회
    public FreeBoardFileVO selectFileById(int fileNum) {
        return template.selectOne("freeboardFileMapper.selectFileById", fileNum);
    }

    // 파일 삭제
    public int deleteFile(int fileNum) {
        return template.delete("freeboardFileMapper.deleteFile", fileNum);
    }
}
