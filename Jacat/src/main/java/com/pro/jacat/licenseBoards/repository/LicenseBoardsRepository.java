package com.pro.jacat.licenseBoards.repository;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Repository;

import com.pro.jacat.licenseBoards.vo.FileLicenseBoardVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardReportVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsCommentVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsVO;
import com.pro.jacat.licenseBoards.vo.UsersFavoritesLicenseVO;
import com.pro.jacat.licenseBoards.vo.VisitLicenseBoardVO;
import com.pro.jacat.licenses.vo.LicenseListVO;

@Repository
public class LicenseBoardsRepository {
	private final SqlSession template;

	//������
	@Autowired
	public LicenseBoardsRepository(SqlSession template) {
		//super();
		this.template = template;
	}
	
	//�ڰ��� �����ȸ
	public List<LicenseListVO> selectLicenseLists() {
		return template.selectList("licenseBoardMapper.selectLicenseLists");
	}
	//�ڰ��� ����ȸ
	public LicenseListVO selectLicenseOne(String jmcd) {
		return template.selectOne("licenseBoardMapper.selectLicenseOne",jmcd);
	}
	//�����ڰ��� �߰�
	public int insertFavoriteLicenseOne(UsersFavoritesLicenseVO vo) {
		return template.insert("licenseBoardMapper.insertFavoriteLicenseOne",vo);
	}
	//�����ڰ��� ����
	public int deleteFavoriteLicenseOne(UsersFavoritesLicenseVO vo) {
		return template.delete("licenseBoardMapper.deleteFavoriteLicenseOne", vo);
	}
	//�����ڰ��� ���� ��ȸ
	public int selectFavoriteLicenseYN(UsersFavoritesLicenseVO vo) {
		return template.selectOne("licenseBoardMapper.selectFavoriteLicenseYN",vo);
	}
	
	//QnA �Խ��� �����ȸ
	public List<LicenseBoardsVO> selectQnABoards(String jmcd){
		return template.selectList("licenseBoardMapper.selectQnABoards", jmcd);
	}
	//QnA �Խ��� ����ȸ
	public LicenseBoardsVO selectLicenseBoardOne(int boardNum) {
		return template.selectOne("licenseBoardMapper.selectLicenseBoardOne",boardNum);
	}
	//QnA �Խ��� �� �ۼ�
	public int insertLicenseBoardOne(LicenseBoardsVO vo) {
		return template.insert("licenseBoardMapper.insertLicenseBoardOne",vo);
	}
	//QnA �Խ��� �� ����
	public int updateLicenseBoardOne(LicenseBoardsVO vo) {
		return template.update("licenseBoardMapper.updateLicenseBoardOne",vo);
	}
	//�Խ��� �� ����
	public int deleteLicenseBoardOne(int boardNum) {
		return template.update("licenseBoardMapper.deleteLicenseBoardOne",boardNum);
	}
	//QnA �Խ��� �Խñ� �Ű�
	public int insertLicenseBoardReportOne(LicenseBoardReportVO vo) {
		return template.insert("licenseBoardMapper.insertLicenseBoardReportOne",vo);
	}
	//�ڰ��� �ڷ�� �����ȸ
	public List<LicenseBoardsVO> selectDataroomBoards(String jmcd){
		return template.selectList("licenseBoardMapper.selectDataroomBoards", jmcd);
	}
	
	//�����ڵ�� �ڰ��� �̸� ��ȸ�ϴ� �޼��� 
	public String selectLicenseNameOne(String jmcd) {
		return template.selectOne("licenseBoardMapper.selectLicenseNameOne",jmcd);
	}
	
	//QnA �Խ��� ��� �ۼ�
	public int insertLicenseCommentOne(LicenseBoardsCommentVO vo){
		return template.insert("licenseBoardMapper.insertLicenseCommentOne",vo);
	}
	
	//QnA �Խ��� ��� �ܰ� ��ȸ
	public LicenseBoardsCommentVO selectLicenseCommentOne(int commentNum) {
		return template.selectOne("licenseBoardMapper.selectLicenseCommentOne",commentNum);
	}
	
	//QnA �Խ��� ��� ����
	public int updateLicenseCommentOne(LicenseBoardsCommentVO vo) {
		return template.update("licenseBoardMapper.updateLicenseCommentOne",vo);
	}
	//QnA �Խ��� ��� ����
	public int deleteLicenseCommentOne(int commentNum) {
		return template.update("licenseBoardMapper.deleteLicenseCommentOne",commentNum);
	}
	
	public int insertlBoardFiles(FileLicenseBoardVO vo) {
		return template.insert("licenseBoardsFilesMapper.insertlBoardFiles",vo);
	}
	
	public int deletelBoardFileOne(int fileNum) {
		return template.delete("licenseBoardsFilesMapper.deletelBoardFileOne", fileNum);
	}
	
	//�Խñ� ��ȸ�� 
	public int insertLicenseBoardVisit(VisitLicenseBoardVO vvo) {
		try {
			return template.insert("licenseBoardMapper.insertLicenseBoardVisit", vvo);
		}catch(DuplicateKeyException e) {
			//e.printStackTrace();
			return 0;
		}
		
	}
}
