package com.gumzima.shopping.common;

import java.io.File;
import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.gumzima.shopping.exception.ImageRegistException;

import lombok.Data;

@Data
@Component
public class FileManager {
	private static final Logger logger=LoggerFactory.getLogger(FileManager.class);
	private String saveBasicDir="/resources/data/basic";
	private String saveAddonDir="/resources/data/addon";
	private String saveFoodDir="/resources/data/food";
	
	public static String getFilename(String path) {
		int lastIndex = path.lastIndexOf("/");
		return path.substring(lastIndex+1, path.length());
	}
	
	public static String getFilenameByExtend(String filename) {
		int index = filename.lastIndexOf(".");
		return filename.substring(0, index);
	}
	
	public static String getExtend(String filename) {
		int lastIndex = filename.lastIndexOf(".");
		return filename.substring(lastIndex+1, filename.length());
	}
	
	public static boolean deleteFile(String path) {
		File file = new File(path);
		return file.delete();
	}
	
	public void saveFile(String realDir, MultipartFile multi) throws ImageRegistException{
		try {
			multi.transferTo(new File(realDir));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
			throw new ImageRegistException("이미지 파일 등록 실패");
		}
	}
}
