package com.pro.jacat.freeboard.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.file.repository.FileRepository;
import com.pro.jacat.freeboard.repository.FreeBoardCommentRepository;
import com.pro.jacat.freeboard.repository.FreeBoardFileRepository;
import com.pro.jacat.freeboard.repository.FreeBoardReportRepository;
import com.pro.jacat.freeboard.repository.FreeBoardRepository;
import com.pro.jacat.freeboard.vo.FreeBoardCommentVO;
import com.pro.jacat.freeboard.vo.FreeBoardFileVO;
import com.pro.jacat.freeboard.vo.FreeBoardReportVO;
import com.pro.jacat.freeboard.vo.FreeBoardVO;


@Service
public class FreeBoardServiceImpl implements FreeBoardService{
	
	private final FreeBoardRepository freeboardRepository;
	private final ServletContext context;
	private final FreeBoardFileRepository freeboardFileRepository;
	private final FreeBoardCommentRepository freeboardCommentRepository;
	private final FreeBoardReportRepository freeboardReportRepository;
	
	@Autowired
	public FreeBoardServiceImpl(
				FreeBoardRepository freeboardRepository,
				ServletContext context,
				FreeBoardFileRepository freeboardFileRepository,
				FreeBoardCommentRepository freeboardCommentRepository,
				FreeBoardReportRepository freeboardReportRepository
			) {
		this.freeboardRepository = freeboardRepository;
		this.context = context;
		this.freeboardFileRepository =freeboardFileRepository;
		this.freeboardCommentRepository = freeboardCommentRepository;
		this.freeboardReportRepository = freeboardReportRepository;
	}
	//�Խñ� ��� ��ȸ
	public List<FreeBoardVO> selectAllBoard(){
		return freeboardRepository.selectAllBoard();
	}
	
	//�Խñ� �ܰ� ��ȸ
	public FreeBoardVO selectBoardByBno(int board_num) {
		if(board_num <= 0) {
			return null;
		}
		return freeboardRepository.selectBoardByBno(board_num);
	}

	//�Խñ� ����ó��
	@Override
	public int deleteBoard(int board_num, String user_id) {
		FreeBoardVO vo = freeboardRepository.selectBoardByBno(board_num);
		if(!vo.getUsersId().equals(user_id)) {
			return 0;			
		}
		return freeboardRepository.deleteBoard(board_num);
	}
	
	//�Խñ� ����ó��
	@Override
	public boolean updateBoard(FreeBoardVO vo) {
		if(vo.getTitle() == null || vo.getTitle().equals("")) {
			return false;
		}
		int result = freeboardRepository.updateBoard(vo);
		if(result <=0) {
			return false;
		}else {
			return true;			
		}
	}

	@Override
	public void insertBoard(FreeBoardVO vo, List<MultipartFile> file) throws IllegalArgumentException, IOException {
		
		//÷������ ���ε带 ���� ���� ����
		String path = context.getRealPath("/uploads");
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		//�Խñ� insert
		freeboardRepository.insertBoard(vo);
		
		//÷������ ���ε�
		List<FreeBoardFileVO> list = new ArrayList<>();
		
		for(MultipartFile f : file) {
			if(f.isEmpty()) {
				continue;
			}
			
			//���Ͼ��ε�
			String realFileName = f.getOriginalFilename();
			String ext = realFileName.substring(realFileName.lastIndexOf("."));
			
			String fileName = UUID.randomUUID().toString()+ ext;
			String type = f.getContentType();
			
			File newFile = new File(path+"/"+fileName);
			f.transferTo(newFile);
			
			FreeBoardFileVO freeboardFileVO = new FreeBoardFileVO();
			freeboardFileVO.setBoardNum(vo.getBoardNum());
			freeboardFileVO.setType(type);
			freeboardFileVO.setRealFileName(realFileName);
			freeboardFileVO.setFileName(fileName);
			freeboardFileVO.setPath(path);
			
			list.add(freeboardFileVO);	
			
		}if(!list.isEmpty()) {
			freeboardFileRepository.insertFiles(list);
		}
		
	}

	//��� ���
	public boolean addComment(FreeBoardCommentVO vo) {
		return freeboardCommentRepository.insertComment(vo) > 0;
	}
	
	//���� ��ȸ
	public List<FreeBoardCommentVO> selectCComment(int board_num){
		return freeboardCommentRepository.selectCComment(board_num);
	}
	
	//�Ű��� 
	public void insertReport(FreeBoardReportVO vo) {
		freeboardReportRepository.insertReport(vo);
	}	
}


