package com.pro.jacat.user.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.user.response.UserResponse;
import com.pro.jacat.user.vo.UserVO;

@Repository
public class UserRepository {
	private final SqlSession template;

	@Autowired
	public UserRepository(SqlSession template) {
		this.template = template;
	}
	
	// 아이디 중복확인
	public int selectUsersCntById(String id) {
		return template.selectOne("userMapper.selectUsersCntById", id);
	}

	public int selectUsersCntByNick(String nick) {
		return template.selectOne("userMapper.selectUsersCntByNick", nick);
	}

	public int selectUsersCntByEmail(String email) {
		return template.selectOne("userMapper.selectUsersCntByEmail", email);
	}

	public int insertUsersOne(UserVO user) {
		return template.insert("userMapper.insertUsersOne", user);
	}

	public UserVO selectUsersOne(UserVO user) {
		return template.selectOne("userMapper.selectUsersOne", user);
	}

	public String selectUsersIdByEmail(String email) {
		return template.selectOne("userMapper.selectUsersIdByEmail", email);
	}

	public int selectUsersCntByIdEmail(UserVO user) {
		return template.selectOne("userMapper.selectUsersCntByIdEmail", user);
	}

	public int updateUsersPwByEmail(UserVO user) {
		return template.update("userMapper.updateUsersPwByEmail", user);
	}

	public int selectUsersSuspendById(String id) {
		return template.selectOne("userMapper.selectUsersSuspendById", id);
	}
}
