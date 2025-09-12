package com.pro.jacat.noticeBoard.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.noticeBoard.Repository.NoticeBoardRepository;
import com.pro.jacat.noticeBoard.Repository.NoticeFileRepository;
import com.pro.jacat.noticeBoard.vo.NoticeBoardFileVO;
import com.pro.jacat.noticeBoard.vo.NoticeBoardVO;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	private final NoticeBoardRepository noticeBoardRepository;
	private final ServletContext context;
	
	@Autowired
	public NoticeServiceImpl(
			NoticeBoardRepository noticeBoardRepository,
			ServletContext context
	) {
		this.noticeBoardRepository = noticeBoardRepository;
		this.context = context;
	}

	@Override
	public List<NoticeBoardVO> selectAllNoticeBoard() {
		return noticeBoardRepository.selectAllBoard();
	}

	@Override
	public NoticeBoardVO selectnoticeBoardBybno(int board_num) {
		if(board_num <= 0) {
			return null;
		}
		return noticeBoardRepository.selectBoardByBno(board_num);
	}

	//게시글 수정처리
	@Override
	public boolean updateNoticeBoard(NoticeBoardVO vo){
		if(vo.getTitle() == null || vo.getTitle().equals("")) {
			return false;
		}
		int result = noticeBoardRepository.updateBoard(vo);
		if(result <= 0) {
			return false;
		}else {
			return true;
		}
	}
	@Override
	//게시글 삭제처리
	public int deleteNoticeBoard(int board_num, String id) {
		NoticeBoardVO vo = noticeBoardRepository.selectBoardByBno(board_num);
		if(!vo.getUsers_id().equals(id)) {
			return 0;
		}
		return noticeBoardRepository.deleteBoard(board_num);
			
	}

	@Override
	//게시글 작성 + 파일 업로드 + 파일 insert
	public void insertNoticeBoard(NoticeBoardVO vo, List<MultipartFile> file)throws IllegalArgumentException, IOException {		
		String path = context.getRealPath("/uploads/");
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdirs();
		}		
		//게시글 insert
		noticeBoardRepository.insertBoard(vo);
		
		//첨부파일 업로드
		List<NoticeBoardFileVO> list = new ArrayList<>();
		
		for(MultipartFile f : file) {
			if(f.isEmpty()) {
				continue;
			}
			
			//파일 업로드
			
			String originalName = f.getOriginalFilename();
			String ext
				= originalName.substring(originalName.lastIndexOf("."));
			
			String savedName = UUID.randomUUID().toString() + ext;
			long fileSize = f.getSize();
			String contentType = f.getContentType();
			
			f.transferTo(new File(path+savedName));
			//~~~~~/webapp/uploads/04afb2af-c19c8e4c.jpg
			
			NoticeBoardFileVO fileVO = new NoticeBoardFileVO();
			/*
			 * fileVO.setboard_num(vo.getboard_num()); fileVO.setContentType(contentType);
			 * fileVO.setFileSize(fileSize); fileVO.setOriginalName(originalName);
			 * fileVO.setSavedName(savedName); fileVO.setUploadPath(path);
			 * 
			 * list.add(fileVO); }
			 * 
			 * if(!list.isEmpty()) { NoticeFileRepository.insertFiles(list);
			 */
		}
	}
}
