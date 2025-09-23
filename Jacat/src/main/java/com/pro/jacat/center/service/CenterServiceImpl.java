package com.pro.jacat.center.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pro.jacat.center.repository.CenterRepository;
import com.pro.jacat.licenses.vo.LicenseTestCenterVO;

@Service
public class CenterServiceImpl implements CenterService {
	private final CenterRepository centerRepository;

	public CenterServiceImpl(CenterRepository centerRepository) {
		this.centerRepository = centerRepository;
	}
	
	@Override
	public List<LicenseTestCenterVO> selectLicenseTestCenterByKeyword(String keyword) {
		return centerRepository.selectLicenseTestCenterByKeyword(keyword);
	}

	@Override
	public LicenseTestCenterVO selectLicenseTestCenterOne(int addno) {
		return centerRepository.selectLicenseTestCenterOne(addno);
	}
	
	
}
