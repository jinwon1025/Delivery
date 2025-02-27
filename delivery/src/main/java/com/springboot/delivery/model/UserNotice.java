package com.springboot.delivery.model;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserNotice {
    private Integer notice_id;
    private String title;
    private String content;
    private String writer;
    private Date reg_date;
    private Integer view_count;
    private String important;
}