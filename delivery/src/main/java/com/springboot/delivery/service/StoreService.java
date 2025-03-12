package com.springboot.delivery.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.delivery.mapper.StoreMapper;
import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;
import com.springboot.delivery.model.OptionCategory;
import com.springboot.delivery.model.OptionSet;
import com.springboot.delivery.model.Rating;
import com.springboot.delivery.model.Store;
import com.springboot.delivery.model.SubOption;

import jakarta.transaction.Transactional;

@Service
public class StoreService {

	
	@Autowired
	private StoreMapper storeMapper;
	
	public Integer idcheck(String store_id) {
		return this.storeMapper.idcheck(store_id);
	}
	
	public void storeRegister(Store store) {
		this.storeMapper.storeRegister(store);
	}
	public void deleteOptionsByStoreId(String store_id) { // 가게 삭제할 때 옵션 삭제
		this.storeMapper.deleteOptionsByStoreId(store_id);
	}
	
	public void deleteOptionGroupsByStoreId(String store_id) {
		this.storeMapper.deleteOptionGroupsByStoreId(store_id);
	}
	
	public void deleteMenuItemByStoreId(String store_id) {
		this.storeMapper.deleteMenuItemByStoreId(store_id);
	}
	
	public void deleteMenuCategoryByStoreId(String store_id) {
		this.storeMapper.deleteMenuCategoryByStoreId(store_id);
	}
	
	public void deleteReviewsByStoreId(String store_id) {
		this.storeMapper.deleteReviewsByStoreId(store_id);
	}
	
	public void deleteOrderDetailsByStoreId(String store_id) {
		this.storeMapper.deleteOrderDetailsByStoreId(store_id);
	}
	
	public void deleteUsedCouponsByStoreId(String store_id) {
		this.storeMapper.deleteUsedCouponsByStoreId(store_id);
	}
	
	public void deleteUserCouponsByStoreId(String store_id) {
		this.storeMapper.deleteUserCouponsByStoreId(store_id);
	}
	
	public void deleteOwnerCouponsByStoreId(String store_id) {
		this.storeMapper.deleteOwnerCouponsByStoreId(store_id);
	}
	
	public void deleteBookmarksByStoreId(String store_id) {
		this.storeMapper.deleteBookmarksByStoreId(store_id);
	}
	
	public void deleteStoreByStoreId(Store store) {
		this.storeMapper.deleteStoreByStoreId(store);
	}
	
	public List<Store> storeList(String owner_id) {
		return this.storeMapper.storeList(owner_id);
	}
	
	
	public Store getStore(String store_id) {
		return this.storeMapper.getStore(store_id);
	}
	
	public void updateStore(Store store) {
		this.storeMapper.updateStore(store);
	}
	
	public 	List<MenuCategory> getAllMenu(String store_id){
		return this.storeMapper.getAllMenu(store_id);
	}
	
	public Integer getMaxMenuCount() {
		return this.storeMapper.getMaxMenuCount();
	}
	
	public void insertMenu(MenuCategory mc) {
		this.storeMapper.insertMenu(mc);
	}
	
	public void menuRegister(MenuItem mi) {
		this.storeMapper.menuRegister(mi);
	}
	public Integer getMenuCount() {
		return this.storeMapper.getMenuCount();
	}
	
	public List<MenuItem> getMenuList(String store_id){
		return this.storeMapper.getMenuList(store_id);
	}
	
	public void deleteMenu(MenuItem mi) {
		this.storeMapper.deleteMenu(mi);
	}
	
	public MenuItem menuDetail(MenuItem mi) {
		return this.storeMapper.menuDetail(mi);
	}
	
	public void menuModify(MenuItem mi) {
		this.storeMapper.menuModify(mi);
	}
	@Transactional
	public void categoryDelete(Integer menu_category_id) {
		this.storeMapper.categoryMenuDelete(menu_category_id);
		this.storeMapper.categoryDelete(menu_category_id);
	}
	
	public void categoryNameUpdate(MenuCategory mc) {
		this.storeMapper.categoryNameUpdate(mc);
	}
	
	public List<String> getCategory(String store_id){
		return this.storeMapper.getCategory(store_id);
	}
	
	public List<String> getMenuName(String store_id){
		return this.storeMapper.getMenuName(store_id);
	}
	
	public void addOption(OptionCategory oc) {
		this.storeMapper.addOption(oc);
	}
	
	public Integer getOptionGroupMax() {
		return this.storeMapper.getOptionGroupMax();
	}
	
	public List<OptionCategory> getMenuItemOptionList(OptionCategory oc) {
		return this.storeMapper.getMenuItemOptionList(oc);
	}
	
	public void addSubOption(SubOption so) {
		this.storeMapper.addSubOption(so);
	}
	
	public Integer getSubOptionMax() {
		return this.storeMapper.getSubOptionMax();
	}
	
	public List<OptionSet> getSubOptionList(){
		return this.storeMapper.getSubOptionList();
	}
	
	public void deleteSubOption(OptionSet os) {
		this.storeMapper.deleteSubOption(os);
	}
	
	public OptionSet getUpdateSubOptionTarget(OptionSet os) {
		return this.storeMapper.getUpdateSubOptionTarget(os);
	}
	
	public void updateSubOption(OptionSet os) {
		this.storeMapper.updateSubOption(os);
	}
	
	public void updateOptionCategory(OptionCategory oc) {
		this.storeMapper.updateOptionCategory(oc);
	}
	
	public void deleteSubOptionByGroupId(OptionCategory oc) {
		this.storeMapper.deleteSubOptionByGroupId(oc);
	}
	
	public void deleteOptionCategory(OptionCategory oc) {
		this.storeMapper.deleteOptionCategory(oc);
	}
	
	public void updateStoreStatus(String storeId, Integer status) {
	    this.storeMapper.updateStoreStatus(storeId, status);
	}
	
	public Integer getCountMenuFromStore(String storeId) {
		return this.storeMapper.getCountMenuFromStore(storeId);
	}
	
	public Rating getRatingFromStore(String store_id) {
		return this.storeMapper.getRatingFromStore(store_id);
	}
}
