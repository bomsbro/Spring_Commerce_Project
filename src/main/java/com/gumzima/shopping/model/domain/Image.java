package com.gumzima.shopping.model.domain;

import lombok.Data;

@Data
public class Image {
	private int image_id;
	private int product_id;
	private String filename;
}
