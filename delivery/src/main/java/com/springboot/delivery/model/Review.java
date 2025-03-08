package com.springboot.delivery.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Review {

	private Integer review_id;
	private Integer group_id;
	private Integer parent_id;
	private Integer order_no; //글 작성 순서?
	private String store_id;
	private String user_id;
	private String order_id;
	private String review_title;
	private String review_content;
	private String review_image_name;
	private MultipartFile image;
	private String write_date;
	private Integer rating;
	private String store_name;
	private String owner_id;
	
}
