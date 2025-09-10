package com.pro.jacat.user.service;

import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.user.response.UserResponse;
import com.pro.jacat.user.vo.UserVO;

public interface UserService {
	public UserResponse selectUsersCntById(String id);
	public UserResponse selectUsersCntByNick(String nick);
	public UserResponse selectUsersCntByEmail(String email);
	public int insertUsersOne(UserVO user, MultipartFile profile);
	public UserVO selectUsersOne(UserVO user);
	public String selectUsersIdByEmail(String email);
	public UserResponse selectUsersCntByIdEmail(UserVO user);
	public UserResponse updateUsersPwByEmail(UserVO user);
}
