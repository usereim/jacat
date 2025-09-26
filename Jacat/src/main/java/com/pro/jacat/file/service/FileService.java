package com.pro.jacat.file.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.file.repository.FileRepository;
import com.pro.jacat.file.vo.BoardsFileVO;
import com.pro.jacat.file.vo.UserFileVO;

@Service
public class FileService {
	private static final Logger logger = LoggerFactory.getLogger(FileService.class);
	private final ServletContext context;
	private final FileRepository fileRepository;

	@Autowired
	public FileService(ServletContext context, FileRepository fileRepository) {
		this.context = context;
		this.fileRepository = fileRepository;
	}

	// 게시판 이미지 업로드
	public void uploadFile(MultipartFile file, String subPath, int bno) throws IllegalStateException, IOException {
		if (file.isEmpty()) {
			throw new IllegalStateException();
		}

		String path = context.getRealPath("/uploads/" + subPath);

		File dir = new File(path);
		if (!dir.exists()) {
			dir.mkdirs();
		}

		BoardsFileVO _file = new BoardsFileVO();

		String originalName = file.getOriginalFilename();
		String ext = originalName.substring(originalName.lastIndexOf("."));

		String savedName = UUID.randomUUID().toString() + ext;
		// long fileSize = f.getSize();
		String contentType = file.getContentType();

		file.transferTo(new File(path + savedName));

		_file.setBoardsBoardNum(bno);
		_file.setRealFileName(originalName);
		_file.setFileName(savedName);
		_file.setType(contentType);
		_file.setPath(path);

		fileRepository.insertFileBoardList(_file);
	}

	// 회원 프로필 업로드
	public UserFileVO uploadFile(MultipartFile file, String subPath) throws IllegalStateException, IOException {

		if (file.isEmpty()) {
			throw new IllegalStateException();
		}

		String path = context.getRealPath("/uploads/" + subPath);
		// ~~~~~~~/webapp/uploads/
		File dir = new File(path);
		if (!dir.exists()) {
			dir.mkdirs();
		}

		String originalName = file.getOriginalFilename();
		String ext = originalName.substring(originalName.lastIndexOf("."));

		String savedName = UUID.randomUUID().toString() + ext;
		String contentType = file.getContentType();

		file.transferTo(new File(path + savedName));

		return new UserFileVO(originalName, savedName, path, contentType);

	}

	@Transactional
	public void deleteFile(MultipartFile file, String subPath, int boardNum) throws IllegalStateException, IOException {
		if (file.isEmpty()) {
			fileRepository.deleteFile(boardNum);
		} else {
			fileRepository.deleteFile(boardNum);
			
			String path = context.getRealPath("/uploads/" + subPath);

			File dir = new File(path);
			if (!dir.exists()) {
				dir.mkdirs();
			}

			BoardsFileVO _file = new BoardsFileVO();

			String originalName = file.getOriginalFilename();
			String ext = originalName.substring(originalName.lastIndexOf("."));

			String savedName = UUID.randomUUID().toString() + ext;
			// long fileSize = f.getSize();
			String contentType = file.getContentType();

			file.transferTo(new File(path + savedName));

			_file.setBoardsBoardNum(boardNum);
			_file.setRealFileName(originalName);
			_file.setFileName(savedName);
			_file.setType(contentType);
			_file.setPath(path);

			fileRepository.insertFileBoardList(_file);
		}
	}
}
