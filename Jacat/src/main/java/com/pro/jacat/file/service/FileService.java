package com.pro.jacat.file.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.file.repository.FileRepository;
import com.pro.jacat.file.vo.BoardsFileVO;
import com.pro.jacat.file.vo.UserFileVO;
import com.pro.jacat.user.controller.UserController;

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

	public void uploadFile(List<MultipartFile> file, String subPath, int bno) throws IllegalStateException, IOException {
		String path = context.getRealPath("/uploads/" + subPath);

		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		List<BoardsFileVO> fileList = new ArrayList<>();
		
		for(MultipartFile f : file) {
			BoardsFileVO _file = new BoardsFileVO();
			
			if(f.isEmpty()) {
				continue;
			}
			
			String originalName = f.getOriginalFilename();
			String ext 
				= originalName.substring(originalName.lastIndexOf("."));
			
			String savedName = UUID.randomUUID().toString() + ext;
			//long fileSize = f.getSize();
			String contentType = f.getContentType();
			
			f.transferTo(new File(path+savedName));
			
			_file.setBoardsBoardNum(bno);
			_file.setRealFileName(originalName);
			_file.setFileName(savedName);
			_file.setType(contentType);
			_file.setPath(path);
			
			fileList.add(_file);
		}
		
		fileRepository.insertFileBoardList(fileList);
	}

	public UserFileVO uploadFile(MultipartFile file, String subPath) throws IllegalStateException, IOException {
		
		if(file.isEmpty()) {
			throw new IllegalStateException();
		}
		
		String path = context.getRealPath("/uploads/" + subPath);
		//~~~~~~~/webapp/uploads/
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdirs();
		}

		String originalName = file.getOriginalFilename();
		String ext 
			= originalName.substring(originalName.lastIndexOf("."));
		
		String savedName = UUID.randomUUID().toString() + ext;
		String contentType = file.getContentType();
		
		logger.info(originalName);
		logger.info(savedName);
		logger.info(path);
		logger.info(contentType);
		
		file.transferTo(new File(path+savedName));
		
		return new UserFileVO(originalName, savedName, path, contentType);
			
	}
}
