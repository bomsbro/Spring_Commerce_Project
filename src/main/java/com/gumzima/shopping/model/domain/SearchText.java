package com.gumzima.shopping.model.domain;

import java.util.List;

import lombok.Data;

@Data
public class SearchText {
	private List<Integer> subId;
	private String text;
}
