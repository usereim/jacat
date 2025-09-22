package com.pro.jacat.noticeBoard.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.noticeBoard.vo.NoticeBoardVO;

public interface NoticeService {
	//�Խñ� ��� ��ȸ
	List<NoticeBoardVO> selectAllNoticeBoard();
	
	//�Խñ� ��� �ܰ� ��ȸ
	NoticeBoardVO selectnoticeBoardBybno(int board_num);
	
	//�Խñ� ���� ��ȸ
	boolean updateNoticeBoard(NoticeBoardVO vo,List<MultipartFile> file);
	
	//�Խñ� ����
	int deleteNoticeBoard(int bno, String id);
	
	//�Խñ� �ۼ�
	void insertNoticeBoard(NoticeBoardVO vo, List<MultipartFile> file)
		throws IllegalArgumentException, IOException;
	}

