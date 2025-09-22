package com.pro.jacat.search.service;

import java.util.List;

import com.pro.jacat.search.vo.SearchResultVO;

public interface SearchService {
	List<SearchResultVO> searchAll(String keyword);
}


