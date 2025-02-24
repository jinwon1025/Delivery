package com.springboot.delivery.model;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Maincategory {
    @NotBlank(message="제목을입력하세요")
    private Integer main_category_id;
    
    @NotBlank(message="제목을입력하세요")
    private String main_category_name;
}