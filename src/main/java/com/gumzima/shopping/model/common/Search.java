package com.gumzima.shopping.model.common;

import lombok.Data;

@Data
public class Search extends Pager{
	private String searchType;
	private String keyword;
}
