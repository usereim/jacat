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
	private final NoticeFileRepository noticeFileRepository;
	
	@Autowired
	public NoticeServiceImpl(
			NoticeBoardRepository noticeBoardRepository,
			ServletContext context,
			NoticeFileRepository noticeFileRepository
	) {
		this.noticeBoardRepository = noticeBoardRepository;
		this.context = context;
		this.noticeFileRepository = noticeFileRepository;
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

	//�Խñ� ����ó��
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
	//�Խñ� ����ó��
	public int deleteNoticeBoard(int board_num, String id) {
		NoticeBoardVO vo = noticeBoardRepository.selectBoardByBno(board_num);
		if(!vo.getUsersId().equals(id)) {
			return 0;
		}
		return noticeBoardRepository.deleteBoard(board_num);
			
	}

	@Override
	//�Խñ� �ۼ� + ���� ���ε� + ���� insert
	public void insertNoticeBoard(NoticeBoardVO vo, List<MultipartFile> file)throws IllegalArgumentException, IOException {		
		String path = context.getRealPath("/uploads/");
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdirs();
		}		
		//�Խñ� insert
		noticeBoardRepository.insertBoard(vo);
		
		//÷������ ���ε�
		List<NoticeBoardFileVO> list = new ArrayList<>();
		
		for(MultipartFile f : file) {
			if(f.isEmpty()) {
				continue;
			}
			
			//���� ���ε�
			
			String originalName = f.getOriginalFilename();
			String ext
				= originalName.substring(originalName.lastIndexOf("."));
			
			String savedName = UUID.randomUUID().toString() + ext;
			long fileSize = f.getSize();
			String contentType = f.getContentType();
			
			f.transferTo(new File(path+savedName));
			//~~~~~/webapp/uploads/04afb2af-c19c8e4c.jpg
			
			NoticeBoardFileVO fileVO = new NoticeBoardFileVO();
			fileVO.setBoards_board_num(vo.getBoardNum());
			fileVO.setType(contentType);
			fileVO.setReal_file_name(originalName);
			fileVO.setFile_name(savedName);
		 	fileVO.setPath(path);
			
			list.add(fileVO); }
			
			if(!list.isEmpty()) {
				noticeFileRepository.insertFiles(list);
		}
	}
}
