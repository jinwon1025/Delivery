package com.springboot.delivery.model;
import org.springframework.web.multipart.MultipartFile;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Review {
    private Integer review_id;  //글번호
    private Integer group_id;  //그룹번호
    private Integer parent_id; //부모글 번호
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
    
    // 새로 추가할 필드
    private String user_name;        // 리뷰 작성자 이름
    private String owner_image_name; // 가게 주인 이미지
}