package com.pro.jacat.file.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.file.vo.UserFileVO;
import com.pro.jacat.user.controller.UserController;

@Service
public class FileService {
	private static final Logger logger = LoggerFactory.getLogger(FileService.class);
	private final ServletContext context;
	
	@Autowired
	public FileService(ServletContext context) {
		this.context = context;
	}

	public void uploadFile(List<MultipartFile> file, String subPath) throws IllegalStateException, IOException {
		String path = context.getRealPath("/uploads/" + subPath);
		//~~~~~~~/webapp/uploads/
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		//첨부파일 업로드
		for(MultipartFile f : file) {
			if(f.isEmpty()) {
				continue;
			}
			//파일 업로드
			
			String originalName = f.getOriginalFilename();
			String ext 
				= originalName.substring(originalName.lastIndexOf("."));
			//image - 복사본.jpg
			//indexOf(".") -> 11
			//lastIndexOf(".") -> 11
			//subString(11)
			
			String savedName = UUID.randomUUID().toString() + ext;
			//long fileSize = f.getSize();
			String contentType = f.getContentType();
			
			f.transferTo(new File(path+savedName));
			//~~~~~/webapp/uploads/04afb2af-c19c8e4c.jpg
		}
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
