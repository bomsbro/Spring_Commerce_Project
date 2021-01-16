package com.gumzima.shopping.model.product.service;

import java.io.File;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gumzima.shopping.common.FileManager;
import com.gumzima.shopping.exception.ImageDeleteException;
import com.gumzima.shopping.exception.ImageRegistException;
import com.gumzima.shopping.exception.ProductDeleteException;
import com.gumzima.shopping.exception.ProductRegistException;
import com.gumzima.shopping.exception.ProductUpdateException;
import com.gumzima.shopping.model.domain.Image;
import com.gumzima.shopping.model.domain.Product;
import com.gumzima.shopping.model.domain.SearchText;
import com.gumzima.shopping.model.product.repository.ImageDAO;
import com.gumzima.shopping.model.product.repository.ProductDAO;

@Service
public class ProductServiceImpl implements ProductService{
	public static final Logger logger=LoggerFactory.getLogger(ProductServiceImpl.class);
	@Autowired
	private ProductDAO productDAO;
	
	@Autowired
	private ImageDAO imageDAO;
		
	public List selectAll() {
		return productDAO.selectAll();
	}

	public List searchProduct(SearchText searchText) {
		if(searchText.getSubId().get(0)==0) {
			return productDAO.searchProduct(searchText);
		}else {
			return productDAO.searchProductByCategory(searchText);
		}
	}
	
	@Override
	public Product select(int product_id) {
		return productDAO.select(product_id);
	}
	
	public void regist(FileManager fileManager, Product product) throws ProductRegistException, ImageRegistException{
		String ext=fileManager.getExtend(product.getRepImg().getOriginalFilename());
		product.setFilename(ext);
		productDAO.insert(product);
				
		//파일 업로드는 FileManager에게 시킨다.
		//상품의 product_id를 이용하여, 대표이미지명을 결정
		String basicImg=product.getProduct_id()+"."+ext;
		fileManager.saveFile(fileManager.getSaveBasicDir()+File.separator+basicImg, product.getRepImg());
		
		//추가 이미지 업로드 (FileManager에게 추가이미지 갯수만큼 업무를 시키면 된다.
		if(product.getAddImg()!=null) {
			for(int i=0; i<product.getAddImg().length;i++) {
				MultipartFile file=product.getAddImg()[i];
				ext=fileManager.getExtend(file.getOriginalFilename());
				//image table에 db에 넣기
				Image image=new Image();
				image.setProduct_id(product.getProduct_id());
				image.setFilename(ext);
				imageDAO.insert(image);
				
				//매니저의 파일 저장 메서드 호출
				String addonImg=image.getImage_id()+"."+ext;
				fileManager.saveFile(fileManager.getSaveAddonDir()+File.separator+addonImg, file);
			}
		}
	}

	public void update(FileManager fileManager, Product product, String basicRepImg, String[] delBasicRepImg, String[] delBasicAddImg) 
	throws ProductUpdateException, ImageRegistException, ImageDeleteException{
		String ext=null;
		int image_id=0;
		
		//추가 이미지 수정시 삭제된 추가 이미지 파일 / 데이터 삭제
		if(delBasicAddImg.length>0) {
			for(int i=0;i<delBasicAddImg.length;i++) {
				boolean fileDelete=fileManager.deleteFile(fileManager.getSaveAddonDir()+File.separator+delBasicAddImg[i]);
				if(fileDelete==false) {
					throw new ImageDeleteException("추가 이미지 파일 삭제 실패");
				}
				image_id=Integer.parseInt(fileManager.getFilenameByExtend(delBasicAddImg[i]));
				imageDAO.delete(image_id);
			}
		}
		
		//대표 이미지가 수정되었다면
		if(product.getRepImg()!=null) {
			boolean fileDelete=fileManager.deleteFile(fileManager.getSaveBasicDir()+File.separator+delBasicRepImg[0]);//기존 대표 이미지 파일 삭제
			if(fileDelete==false) {
				throw new ImageDeleteException("대표 이미지 파일 삭제 실패");
			}
			
			//새로운 대표 이미지 파일 생성 및 데이터 입력값 적용
			ext=fileManager.getExtend(product.getRepImg().getOriginalFilename());
			product.setFilename(ext);

			String basicImg=product.getProduct_id()+"."+ext;
			fileManager.saveFile(fileManager.getSaveBasicDir()+File.separator+basicImg, product.getRepImg());
		}else {//대표이미지가 수정되지 않았다면
			ext=fileManager.getExtend(basicRepImg);
			product.setFilename(ext);
		}
		
		//추가된 추가 이미지가 있다면 생성
		if(product.getAddImg()!=null) {
			for(int i=0; i<product.getAddImg().length;i++) {
				MultipartFile file=product.getAddImg()[i];
				ext=fileManager.getExtend(file.getOriginalFilename());
				//image table에 db에 넣기
				Image image=new Image();
				image.setProduct_id(product.getProduct_id());
				image.setFilename(ext);
				imageDAO.insert(image);
				
				//매니저의 파일 저장 메서드 호출
				String addonImg=image.getImage_id()+"."+ext;
				fileManager.saveFile(fileManager.getSaveAddonDir()+File.separator+addonImg, file);
			}
		}
		productDAO.update(product);
	}

	@Override
	public void delete(FileManager fileManager, int product_id) throws ProductDeleteException, ImageDeleteException{
		//보유하고 있는 추가 이미지 파일 삭제
		String fileName=null;
		List<Image> imageList=imageDAO.selectById(product_id);
		if(imageList.size()>0) {
			for(int i=0; i<imageList.size();i++) {
				Image image=imageList.get(i);
				fileName=image.getImage_id()+"."+image.getFilename();
				boolean fileDelete=fileManager.deleteFile(fileManager.getSaveAddonDir()+File.separator+fileName);
				if(fileDelete==false) {
					throw new ImageDeleteException("추가 이미지 파일 삭제 실패");
				}
			}
			//추가 이미지 데이터 삭제
			imageDAO.deleteByProductId(product_id);
		}
		
		//대표 이미지 파일 삭제
		Product product=productDAO.select(product_id);
		fileName=product.getProduct_id()+"."+product.getFilename();
		fileManager.deleteFile(fileManager.getSaveBasicDir()+File.separator+fileName);
		
		productDAO.delete(product_id);
	}

}
