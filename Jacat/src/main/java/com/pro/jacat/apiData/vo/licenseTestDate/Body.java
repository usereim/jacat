package com.pro.jacat.apiData.vo.licenseTestDate;

import java.util.ArrayList;

public class Body {
	private ArrayList<Item> items;
	private String numOfRows;
	private String pageNo;
	private String totalCount;

	public ArrayList<Item> getItems() {
		return items;
	}

	public void setItems(ArrayList<Item> items) {
		this.items = items;
	}

	public String getNumOfRows() {
		return numOfRows;
	}

	public void setNumOfRows(String numOfRows) {
		this.numOfRows = numOfRows;
	}

	public String getPageNo() {
		return pageNo;
	}

	public void setPageNo(String pageNo) {
		this.pageNo = pageNo;
	}

	public String getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}

	@Override
	public String toString() {
		return "Body [items=" + items + ", numOfRows=" + numOfRows + ", pageNo=" + pageNo + ", totalCount=" + totalCount
				+ "]";
	}
	
}
