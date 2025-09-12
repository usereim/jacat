package com.pro.jacat.licenseBoards.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.licenseBoards.repository.LicenseBoardsFileRepository;
import com.pro.jacat.licenseBoards.repository.LicenseBoardsRepository;
import com.pro.jacat.licenseBoards.vo.FileLicenseBoardVO;
import com.pro.jacat.licenseBoards.vo.LicenseBoardsVO;

@Service
public class licenseBoardsServiceImpl implements licenseBoardsService {
	
	private final LicenseBoardsRepository lBoardRepo;
	private final ServletContext context;
	private final LicenseBoardsFileRepository lFileRepo;
	
	//������
	@Autowired
	public licenseBoardsServiceImpl(
			LicenseBoardsRepository lBoardRepo, 
			ServletContext context,
			LicenseBoardsFileRepository lFileRepo
			) {
		//super();
		this.lBoardRepo = lBoardRepo;
		this.context = context;
		this.lFileRepo = lFileRepo;
	}
	
	//�ڰ��� ��� ��ȸ
	@Override
	public List<LicenseBoardsVO> selectLicenseLists(){
		return lBoardRepo.selectLicenseLists();
	}
	//�ڰ��� ����ȸ
	@Override
	public LicenseBoardsVO selectLicenseOne(String jmcd) {
		return lBoardRepo.selectLicenseOne(jmcd);
	}
	
	//QnA �Խ��� �����ȸ
	@Override
	public List<LicenseBoardsVO> selectQnABoards(){
		return lBoardRepo.selectQnABoards();
	}
	//QnA �Խ��� ����ȸ
	@Override
	public LicenseBoardsVO selectQnABoardOne(int boardNum) {
		return lBoardRepo.selectQnABoardOne(boardNum);
	}
	
	@Transactional
	//QnA �Խ��� �� �ۼ�
	@Override
	public void insertQnABoardOne(LicenseBoardsVO vo, List<MultipartFile> file)
	throws IllegalStateException, IOException
	{	
		String path = context.getRealPath("/uploads/licenses/boards/files"); 
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdir();
		}
		
		//�Խñ� insert
		lBoardRepo.insertQnABoardOne(vo);
		
		//÷������ ���ε�
		List<FileLicenseBoardVO> list = new ArrayList<>();
		
		for(MultipartFile f : file) {
			if(f.isEmpty()) {
				continue;
			}
			
			String realFileName = f.getOriginalFilename();
			String ext = realFileName.substring(realFileName.lastIndexOf("."));
			
			String fileName = UUID.randomUUID().toString() + ext;
			//long fileSize = f.getSize();
			String fileType = f.getContentType();
			
			f.transferTo(new File(path+fileName));
			
			FileLicenseBoardVO flbVO = new FileLicenseBoardVO();
			flbVO.setLicenseBoardsBoardNum(vo.getBoardNum());
			flbVO.setRealFileName(realFileName);
			flbVO.setFileName(fileName);
			flbVO.setPath(path);
			flbVO.setType(fileType);
			
			list.add(flbVO);
			
		}
		
		if(!list.isEmpty()) {
			lFileRepo.insertFiles(list);
		}
		
	}
	
	//QnA �Խ��� �� ����
	@Override
	public int updateQnABoardOne(LicenseBoardsVO vo) {
		return lBoardRepo.updateQnABoardOne(vo);
	}
	//QnA �Խ��� �� ����
	@Override
	public int deleteQnABoardOne(LicenseBoardsVO vo) {
		return lBoardRepo.deleteQnABoardOne(vo);
	}
	
	//�ڰ��� �ڷ�� �����ȸ
	@Override
	public List<LicenseBoardsVO> selectDataroomBoards(){
		return lBoardRepo.selectDataroomBoards();
	}
	//�ڰ��� �ڷ�� ����ȸ
	@Override
	public LicenseBoardsVO selectDataroomBoardOne(int boardNum) {
		return lBoardRepo.selectDataroomBoardOne(boardNum);
	}
	//�ڰ��� �ڷ�� �� �ۼ�
	@Override
	public int insertDataroomBoardOne(LicenseBoardsVO vo) {
		return lBoardRepo.insertDataroomBoardOne(vo);
	}
	//�ڰ��� �ڷ�� �� ����
	@Override
	public int updateDataroomBoardOne(LicenseBoardsVO vo) {
		return lBoardRepo.updateDataroomBoardOne(vo);
	}
	//�ڰ��� �ڷ�� �� ����
	@Override
	public int deleteDataroomBoardOne(LicenseBoardsVO vo) {
		return lBoardRepo.deleteDataroomBoardOne(vo);
	}

	
}
