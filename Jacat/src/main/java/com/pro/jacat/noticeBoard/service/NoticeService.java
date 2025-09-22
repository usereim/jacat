package com.pro.jacat.noticeBoard.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.noticeBoard.vo.NoticeBoardVO;

public interface NoticeService {
	//게시글 목록 조회
	List<NoticeBoardVO> selectAllNoticeBoard();
	
	//게시글 목록 단건 조회
	NoticeBoardVO selectnoticeBoardBybno(int board_num);
	
	//게시글 수정 조회
	boolean updateNoticeBoard(NoticeBoardVO vo,List<MultipartFile> file);
	
	//게시글 삭제
	int deleteNoticeBoard(int bno, String id);
	
	//게시글 작성
	void insertNoticeBoard(NoticeBoardVO vo, List<MultipartFile> file)
		throws IllegalArgumentException, IOException;
	}

