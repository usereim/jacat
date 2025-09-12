package com.pro.jacat.licenses.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LicenseRepository {
	private final SqlSession template;
	
	//»ý¼ºÀÚ
	@Autowired
	public LicenseRepository(SqlSession template) {
		//super();
		this.template = template;
	}
	
	
	
}
