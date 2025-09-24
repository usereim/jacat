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
public class FreeBoardServiceImpl implements FreeBoardService {

	private final FreeBoardRepository freeboardRepository;
	private final ServletContext context;
	private final FreeBoardFileRepository freeboardFileRepository;
	private final FreeBoardCommentRepository freeboardCommentRepository;
	private final FreeBoardReportRepository freeboardReportRepository;

	@Autowired
	public FreeBoardServiceImpl(FreeBoardRepository freeboardRepository, ServletContext context,
			FreeBoardFileRepository freeboardFileRepository, FreeBoardCommentRepository freeboardCommentRepository,
			FreeBoardReportRepository freeboardReportRepository) {
		this.freeboardRepository = freeboardRepository;
		this.context = context;
		this.freeboardFileRepository = freeboardFileRepository;
		this.freeboardCommentRepository = freeboardCommentRepository;
		this.freeboardReportRepository = freeboardReportRepository;
	}

	// 게시글 목록 조회
	public List<FreeBoardVO> selectAllBoard() {
		return freeboardRepository.selectAllBoard();
	}

	// 게시글 단건 조회
	public FreeBoardVO selectBoardByBno(int board_num) {
		if (board_num <= 0) {
			return null;
		}
		return freeboardRepository.selectBoardByBno(board_num);
	}

	// 게시글 삭제처리
	@Override
	public int deleteBoard(int board_num, String user_id) {
		FreeBoardVO vo = freeboardRepository.selectBoardByBno(board_num);
		if (!vo.getUsersId().equals(user_id)) {
			return 0;
		}
		return freeboardRepository.deleteBoard(board_num);
	}

	// 게시글 수정처리
	@Override
	public boolean updateBoard(FreeBoardVO vo,List<MultipartFile> files) {
		if(vo.getTitle() == null || vo.getTitle().equals("")) {
			return false;
		}
		int result = freeboardRepository.updateBoard(vo);
		if(result <=0) {
			return false;
		}
		if (files != null && !files.isEmpty()) {
			freeboardFileRepository.deleteFile(vo.getBoardNum());
			//첨부파일 업로드
			List<FreeBoardFileVO> list = new ArrayList<>();
			for(MultipartFile file : files) {
				if(!file.isEmpty()) {
					try {
						String uploadDir = context.getRealPath("/uploads");
						String realName = file.getOriginalFilename();
						String saveName = UUID.randomUUID().toString()+ "_" + realName;
						File dest = new File(uploadDir, saveName);
						
						//실제 파일 저장
						file.transferTo(dest);
						
						//DB에 파일 정보 저장
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
				
				freeboardFileRepository.insertFiles(list);		
			}
		}
		return true;
	}

	@Override
	public void insertBoard(FreeBoardVO vo, List<MultipartFile> file) throws IllegalArgumentException, IOException {

		// 첨부파일 업로드를 위한 폴더 생성
		String path = context.getRealPath("/uploads");
		File dir = new File(path);
		if (!dir.exists()) {
			dir.mkdirs();
		}

		// 게시글 insert
		freeboardRepository.insertBoard(vo);

		// 첨부파일 업로드
		List<FreeBoardFileVO> list = new ArrayList<>();

		for (MultipartFile f : file) {
			if (f.isEmpty()) {
				continue;
			}

			// 파일업로드
			String realFileName = f.getOriginalFilename();
			String ext = realFileName.substring(realFileName.lastIndexOf("."));

			String fileName = UUID.randomUUID().toString() + ext;
			String type = f.getContentType();

			File newFile = new File(path + "/" + fileName);
			f.transferTo(newFile);

			FreeBoardFileVO freeboardFileVO = new FreeBoardFileVO();
			freeboardFileVO.setBoardNum(vo.getBoardNum());
			freeboardFileVO.setType(type);
			freeboardFileVO.setRealFileName(realFileName);
			freeboardFileVO.setFileName(fileName);
			freeboardFileVO.setPath(path);

			list.add(freeboardFileVO);

		}
		if (!list.isEmpty()) {
			freeboardFileRepository.insertFiles(list);
		}

	}

	// 댓글 등록
	public boolean addComment(FreeBoardCommentVO vo) {
		return freeboardCommentRepository.insertComment(vo) > 0;
	}

	// 대댓글 조회
	public List<FreeBoardCommentVO> selectCComment(int board_num) {
		return freeboardCommentRepository.selectCComment(board_num);
	}

	// 신고기능
	public void insertReport(FreeBoardReportVO vo) {
		freeboardReportRepository.insertReport(vo);
	}
}
