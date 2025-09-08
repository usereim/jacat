package com.pro.jacat.user.service;

import com.pro.jacat.user.response.UserResponse;
import com.pro.jacat.user.vo.UserVO;

public interface UserService {
	public UserResponse selectUsersCntById(String id);
	public UserResponse selectUsersCntByNick(String nick);
	public UserResponse selectUsersCntByEmail(String email);
	public int insertUsersOne(UserVO user);
}
