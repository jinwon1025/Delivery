package com.springboot.delivery.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;
import com.springboot.delivery.model.OptionCategory;
import com.springboot.delivery.model.OptionSet;
import com.springboot.delivery.model.Rating;
import com.springboot.delivery.model.Store;
import com.springboot.delivery.model.SubOption;
@Mapper
public interface StoreMapper {
	Integer idcheck(String store_id);
	void storeRegister(Store store);
	
	List<Store> storeList(String owner_id);
	void deleteOptionsByStoreId(String store_id);
	void deleteOptionGroupsByStoreId(String store_id);
	void deleteMenuItemByStoreId(String store_id);
	void deleteMenuCategoryByStoreId(String store_id);
	void deleteReviewsByStoreId(String store_id);
	void deleteOrderDetailsByStoreId(String store_id);
	void deleteUsedCouponsByStoreId(String store_id);
	void deleteUserCouponsByStoreId(String store_id);
	void deleteOwnerCouponsByStoreId(String store_id);
	void deleteBookmarksByStoreId(String store_id);
	void deleteStoreByStoreId(Store store);
	Store getStore(String store_id);
	void updateStore(Store store);
	List<MenuCategory> getAllMenu(String store_id);
	Integer getMaxMenuCount();
	void insertMenu(MenuCategory mc);
	void menuRegister(MenuItem mi);
	Integer getMenuCount();
	List<MenuItem> getMenuList(String store_id);
	void deleteMenu(MenuItem mi);
	MenuItem menuDetail(MenuItem mi); 
	void menuModify(MenuItem mi);
	void categoryDelete(Integer menu_category_id);
	void categoryMenuDelete(Integer menu_category_id);
	void categoryNameUpdate(MenuCategory mc);
	List<String> getCategory(String store_id);
	List<String> getMenuName(String store_id);
	void addOption(OptionCategory oc);
	Integer getOptionGroupMax();
	List<OptionCategory> getMenuItemOptionList(OptionCategory oc);
	void addSubOption(SubOption so);
	Integer getSubOptionMax();
	List<OptionSet> getSubOptionList();
	void deleteSubOption(OptionSet os);
	OptionSet getUpdateSubOptionTarget(OptionSet os);
	void updateSubOption(OptionSet os);
	void updateOptionCategory(OptionCategory oc);
	void deleteSubOptionByGroupId(OptionCategory oc);
	void deleteOptionCategory(OptionCategory oc);

	void updateStoreStatus(@Param("storeId") String storeId, @Param("status") Integer status);
	
	Integer getCountMenuFromStore(String storeId);
	Rating getRatingFromStore(String store_id);
	
	Integer getTodayOrderCountByStore(String store_id);
	Integer getTodayOrderTotalByStore(String store_id);
}