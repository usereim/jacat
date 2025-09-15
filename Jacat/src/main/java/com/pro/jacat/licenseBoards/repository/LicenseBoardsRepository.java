package com.pro.jacat.licenseBoards.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.jacat.licenseBoards.vo.LicenseBoardsVO;
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
	
	//QnA �Խ��� �����ȸ
	public List<LicenseBoardsVO> selectQnABoards(){
		return template.selectList("licenseBoardMapper.selectQnABoards");
	}
	//QnA �Խ��� ����ȸ
	public LicenseBoardsVO selectQnABoardOne(int boardNum) {
		return template.selectOne("licenseBoardMapper.selectQnABoardOne",boardNum);
	}
	//QnA �Խ��� �� �ۼ�
	public int insertQnABoardOne(LicenseBoardsVO vo) {
		return template.insert("licenseBoardMapper.insertBoardOne",vo);
	}
	//QnA �Խ��� �� ����
	public int updateQnABoardOne(LicenseBoardsVO vo) {
		return template.update("licenseBoardMapper.updateBoardOne",vo);
	}
	//QnA �Խ��� �� ����
	public int deleteQnABoardOne(LicenseBoardsVO vo) {
		return template.update("licenseBoardMapper.deleteBoardOne",vo);
	}
	//�ڰ��� �ڷ�� �����ȸ
	public List<LicenseBoardsVO> selectDataroomBoards(){
		return template.selectList("licenseBoardMapper.selectDataroomBoards");
	}
	//�ڰ��� �ڷ�� ����ȸ
	public LicenseBoardsVO selectDataroomBoardOne(int boardNum) {
		return template.selectOne("licenseBoardMapper.selectDataroomBoardOne",boardNum);
	}
	//�ڰ��� �ڷ�� �� �ۼ�
	public int insertDataroomBoardOne(LicenseBoardsVO vo) {
		return template.insert("licenseBoardMapper.insertDataroomBoardOne",vo);
	}
	//�ڰ��� �ڷ�� �� ����
	public int updateDataroomBoardOne(LicenseBoardsVO vo) {
		return template.update("licenseBoardMapper.updateDataroomBoardOne",vo);
	}
	//�ڰ��� �ڷ�� �� ����
	public int deleteDataroomBoardOne(LicenseBoardsVO vo) {
		return template.update("licenseBoardMapper.deleteDataroomBoardOne",vo);
	}
}
