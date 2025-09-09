package com.pro.jacat.file.vo;

public class UserFileVO {
	private String realFileName;
	private String fileName;
	private String path;
	private String type;
	
	
	public UserFileVO() {
	}
	
	public UserFileVO(String realFileName, String fileName, String path, String type) {
		this.realFileName = realFileName;
		this.fileName = fileName;
		this.path = path;
		this.type = type;
	}
	public String getRealFileName() {
		return realFileName;
	}
	public void setRealFileName(String realFileName) {
		this.realFileName = realFileName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	
}
