package com.pro.jacat.center.service;

import java.util.List;

import com.pro.jacat.licenses.vo.LicenseTestCenterVO;

public interface CenterService {

	List<LicenseTestCenterVO> selectLicenseTestCenterByKeyword(String keyword);

	LicenseTestCenterVO selectLicenseTestCenterOne(int addno);

}
