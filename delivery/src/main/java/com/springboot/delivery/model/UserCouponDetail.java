package com.springboot.delivery.model;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
public class UserCouponDetail {
    // b_user_coupon_tbl 컬럼
    private Integer userCpId;
    private String userId;
    private Integer ownerCouponId;
    private Date downloadDate;
    private Integer status;
    private Integer storeCouponId;
    private Date expireDate;

    // b_store_coupon_tbl 추가 컬럼
    private String storeId;
    private Integer quantity;
    private String ownerId;
    private String cpName;
    private Integer minimumPurchase;
    private Integer usedQuantity;
}