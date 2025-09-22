package com.pro.jacat.search.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.jacat.search.repository.SearchRepository;
import com.pro.jacat.search.vo.SearchResultVO;

	@Service
	public class SearchServiceImpl implements SearchService{
	
	@Autowired
	private SearchRepository searchRepository;
	
	@Override
	public List<SearchResultVO> searchAll(String keyword){
		return searchRepository.searchAll(keyword);
	}

}
