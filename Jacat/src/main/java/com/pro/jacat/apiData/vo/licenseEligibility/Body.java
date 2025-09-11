package com.pro.jacat.apiData.vo.licenseEligibility;

public class Body {
	private Items items;
	private int numOfRows;
	private int pageNo;
	private int totalCount;
	
	public Items getItems() {
		return items;
	}
	public void setItems(Items items) {
		this.items = items;
	}
	public int getNumOfRows() {
		return numOfRows;
	}
	public void setNumOfRows(int numOfRows) {
		this.numOfRows = numOfRows;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
}
