package com.gumzima.shopping.model.domain;

import lombok.Data;

@Data
public class Member {
	private int member_id;	
	private String m_id;
	private String m_name;
	private String m_pass;
	private String m_email;
	private String m_email_server;
	private String m_phone;
	private String m_addr1;
	private String m_addr2;
	private String m_addr3;
	private String regdate;
	private int m_id_cnt;
}
