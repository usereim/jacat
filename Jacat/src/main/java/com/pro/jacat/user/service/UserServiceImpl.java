package com.pro.jacat.user.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.file.service.FileService;
import com.pro.jacat.file.vo.UserFileVO;
import com.pro.jacat.user.repository.UserRepository;
import com.pro.jacat.user.response.UserResponse;
import com.pro.jacat.user.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {
	private static final Logger logger = LoggerFactory.getLogger(UserService.class);
	
	
	private final UserRepository userRepository;
	private final FileService fileService;
	
	@Autowired
	public UserServiceImpl(UserRepository userRepository, FileService fileService) {
		this.userRepository = userRepository;
		this.fileService = fileService;
	}

	@Override
	public UserResponse selectUsersCntById(String id) {
		UserResponse response = new UserResponse();
		int cnt = userRepository.selectUsersCntById(id);
		
		response.setCode(cnt);
		return response;
	}

	@Override
	public UserResponse selectUsersCntByNick(String nick) {
		UserResponse response = new UserResponse();
		int cnt = userRepository.selectUsersCntByNick(nick);
		
		response.setCode(cnt);
		return response;
	}

	@Override
	public UserResponse selectUsersCntByEmail(String email) {
		UserResponse response = new UserResponse();
		int cnt = userRepository.selectUsersCntByEmail(email);
		
		response.setCode(cnt);
		return response;
	}
	
	@Override
	public UserResponse selectUsersCntByIdEmail(UserVO user) {
		UserResponse response = new UserResponse();
		int cnt = userRepository.selectUsersCntByIdEmail(user);
		
		response.setCode(cnt);
		return response;
	}

	@Override
	public int insertUsersOne(UserVO user, MultipartFile profile) {
		
		UserFileVO file = null;
		
		try {
			file = fileService.uploadFile(profile, "profile/" + user.getId() + "/");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (file == null) {
			logger.info("file null");
		} else {
			logger.info("file not null");
		}
		
		user.transferFileToUser(file);
		
		return userRepository.insertUsersOne(user);
	}

	@Override
	public UserVO selectUsersOne(UserVO user) {
		return userRepository.selectUsersOne(user);
		
	}

	@Override
	public String selectUsersIdByEmail(String email) {
		return userRepository.selectUsersIdByEmail(email);
	}

	public UserResponse updateUsersPwByEmail(UserVO user) {
		UserResponse response = new UserResponse();
		int cnt = userRepository.updateUsersPwByEmail(user);
		
		response.setCode(cnt);
		return response;
	}

	@Override
	public UserResponse selectUsersSuspendById(String id) {
		UserResponse response = new UserResponse();
		int cnt = userRepository.selectUsersSuspendById(id);
		
		response.setCode(cnt);
		return response;
	}

	
}
















