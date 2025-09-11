package com.pro.jacat.freeboard.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.freeboard.repository.FreeBoardRepository;
import com.pro.jacat.freeboard.vo.FreeBoardVO;

@Service
public class FreeBoardServiceImpl implements FreeBoardService{
	private final FreeBoardRepository freeboardRepository;
	
	@Autowired
	public FreeBoardServiceImpl(
				FreeBoardRepository freeboardRepository
			) {
		this.freeboardRepository = freeboardRepository;
	}
	
	//게시글 목록 조회
	public List<FreeBoardVO> selectAllBoard(){
		return freeboardRepository.selectAllBoard();
	}
	
	//게시글 단건 조회
	public FreeBoardVO selectBoardByBno(int board_num) {
		if(board_num <= 0) {
			return null;
		}
		return freeboardRepository.selectBoardByBno(board_num);
	}

	//게시글 삭제처리
	@Override
	public int deleteBoard(int board_num, String user_id) {
		FreeBoardVO vo = freeboardRepository.selectBoardByBno(board_num);
		if(!vo.getUsersId().equals(user_id)) {
			return 0;			
		}
		return freeboardRepository.deleteBoard(board_num);
	}

	@Override
	public void insertBoard(FreeBoardVO vo, List<MultipartFile> file) throws IllegalArgumentException, IOException {
		// TODO Auto-generated method stub
		
	}
		
	
}
	



