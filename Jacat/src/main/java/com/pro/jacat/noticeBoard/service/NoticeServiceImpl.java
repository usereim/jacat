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

import com.pro.jacat.freeboard.vo.FreeBoardFileVO;
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
		NoticeBoardVO vo = noticeBoardRepository.selectBoardByBno(board_num);
		vo.setFileList(noticeFileRepository.selectFileByBno(board_num));
		return vo;
	}

	//�Խñ� ����ó��
	@Override
	public boolean updateNoticeBoard(NoticeBoardVO vo, List<MultipartFile> files) {
	    if(vo.getTitle() == null || vo.getTitle().equals("")) {
	        return false;
	    }
	    int result = noticeBoardRepository.updateNoticeBoard(vo);
	    if(result <= 0) {
	        return false;
	    }
		if (files != null && !files.isEmpty()) {
			System.out.println("���� ���� ����");
			noticeFileRepository.deleteFile(vo.getBoardNum());
			//÷������ ���ε�
			List<FreeBoardFileVO> list = new ArrayList<>();
			for(MultipartFile file : files) {
				if(!file.isEmpty()) {
					try {
						String uploadDir = context.getRealPath("/uploads");
						
						File dir = new File(uploadDir);
						if (!dir.exists()) {
							dir.mkdirs();
						}
						
						String realName = file.getOriginalFilename();
						String saveName = UUID.randomUUID().toString()+ "_" + realName;
						File dest = new File(uploadDir, saveName);
						
						//���� ���� ����
						file.transferTo(dest);
						
						//DB�� ���� ���� ����
						FreeBoardFileVO fileVO = new FreeBoardFileVO();
						fileVO.setBoardNum(vo.getBoardNum());
						fileVO.setRealFileName(realName);
						fileVO.setFileName(saveName);
						fileVO.setPath(uploadDir);
						fileVO.setType(file.getContentType());
						
						list.add(fileVO);	
					
					} catch (Exception e) {
						e.printStackTrace();
						return false;
					}
					
					
				}
			}
			
			if(!list.isEmpty()) {
				noticeFileRepository.insertFiles(list);	
			}
		}
	    
	    return true;
	}

	@Override
	//�Խñ� ����ó��
	public int deleteNoticeBoard(int board_num) {
		return noticeBoardRepository.deleteBoard(board_num);
			
	}

	@Override
	//�Խñ� �ۼ� + ���� ���ε� + ���� insert
	public void insertNoticeBoard(NoticeBoardVO vo, List<MultipartFile> file)
			throws IllegalArgumentException, IOException {		
		String path = context.getRealPath("/uploads/");
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdirs();
		}		
		//�Խñ� insert
		noticeBoardRepository.insertNoticeBoard(vo);
		
		//÷������ ���ε�
		List<FreeBoardFileVO> list = new ArrayList<>();
		
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
			
			FreeBoardFileVO fileVO = new FreeBoardFileVO();
			fileVO.setBoardNum(vo.getBoardNum());
			fileVO.setType(contentType);
			fileVO.setRealFileName(originalName);
			fileVO.setFileName(savedName);
		 	fileVO.setPath(path);
			
			list.add(fileVO); }
			
			if(!list.isEmpty()) {
				noticeFileRepository.insertFiles(list);
		}
	}
}
