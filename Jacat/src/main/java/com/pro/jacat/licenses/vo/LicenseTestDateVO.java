package com.pro.jacat.licenses.vo;

//자격증 별 시험일정 테이블 VO
public class LicenseTestDateVO {
	private int ltdNum;				//관리번호
	private int implSeq;			//회차
	private String licenseListJmcd;	//종목 코드
	private String implYy;			//시행 년도
	private String description;		//설명
	private String docRegStartDt;	//필기 원서접수 시작일
	private String docRegEndDt;		//필기 원서접수 종료일
	private String docExamStartDt;	//필기 시험 시작일
	private String docExamEndDt;	//필기 시험 종료일
	private String docPassDt;		//필기 합격예정자 발표일
	private String pracRegStartDt;	//실기(작업) 원서접수 시작일
	private String pracRegEndDt;	//실기(작업) 원서접수 종료일
	private String pracExamStartDt;	//실기(작업) 시험 시작일
	private String pracExamEndDt;	//실기(작업) 시험 종료일
	private String pracPassDt;		//실기(작업) 합격자 발표일
	
}
