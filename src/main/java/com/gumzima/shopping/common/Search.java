package com.gumzima.shopping.common;

import lombok.Data;

@Data
public class Search extends Pager{
	private String searchType;
	private String keyword;
}
