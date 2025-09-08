package com.pro.jacat.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.jacat.user.repository.UserRepository;
import com.pro.jacat.user.response.UserResponse;
import com.pro.jacat.user.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {
	
	private final UserRepository userRepository;
	
	
	@Autowired
	public UserServiceImpl(UserRepository userRepository) {
		this.userRepository = userRepository;
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
	public int insertUsersOne(UserVO user) {
		return userRepository.insertUsersOne(user);
	}

}
