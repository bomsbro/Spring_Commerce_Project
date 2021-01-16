package com.gumzima.shopping.common;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.stereotype.Component;

/*
 	일단 암호화 된 이후엔, 복호화 시킬 수 없는 SHA256 알고리즘으로 회원의 비밀번호를 암호화시켜주는 객체
*/
@Component
public class SecureManager {
	
	public String getSecureData(String password) {		
		StringBuffer sb = new StringBuffer();		// 문자열을 누적시킬 객체
		
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");		// 일반화 -> 암호화로 바꿔주는 객체
			// password 한글자 한글자 마다 분해해서 암호화 시켜준다.
			byte[] data = password.getBytes("UTF-8");		// 일단 바이트배열로 분해 쪼개기
			byte[] hash = digest.digest(data);					// 소화시키는 과정 - 암호화 시작
			
			// 쪼개진 데이터를 대상으로 16진수값으로 변환하여 문자열로 반환
			for(int i=0;i<hash.length;i++) {
				String hex = Integer.toHexString(0xff& hash[i]);		// 정수를 16진수문자열로 변환..
				System.out.println(hex);		// 중간점검
				if(hex.length()==1) {
					sb.append("0");					
				}
				sb.append(hex);
			}
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return sb.toString();
	}
	
	public static void main(String[] args) {
		String result = new SecureManager().getSecureData("bananaking");
		System.out.println(result);
	}
}
