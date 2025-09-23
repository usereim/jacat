package com.pro.jacat.center.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pro.jacat.licenses.vo.LicenseTestCenterVO;

@Repository
public class CenterRepository {
	private final SqlSession template;

	public CenterRepository(SqlSession template) {
		this.template = template;
	}

	public List<LicenseTestCenterVO> selectLicenseTestCenterByKeyword(String keyword) {
		return template.selectList("centerMapper.selectLicenseTestCenterByKeyword", keyword);
	}

	public LicenseTestCenterVO selectLicenseTestCenterOne(int addno) {
		return template.selectOne("centerMapper.selectLicenseTestCenterOne", addno);
	}
}
