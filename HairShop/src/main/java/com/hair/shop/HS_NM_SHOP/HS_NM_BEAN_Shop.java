package com.hair.shop.HS_NM_SHOP;

import org.springframework.web.multipart.MultipartFile;

public class HS_NM_BEAN_Shop {

	private String pid;
	private String pid_Shop;
	private String shopName;
	private String introduce;
	private String openTime;
	private String closeTime;
	private String tel;
	private String openDate;
	private int adrs_post_code;
	private String adrs_street_1;
	private String adrs_street_2;
	private String shop_Manager;
	private String pid_User;
	private String adrs_street_1_2;
	private int startRow;
	private int endRow;
	private String searchContents;
	private String menu_Contents;
	private String percent="%%"; //맵퍼에서 사용하기 위함
	
	// 매장 시술 가격표 파일 첨부하기위한 필드 2개
	private MultipartFile menu_Photo_File;
	private String menu_Photo_Name;

	
	private String shop_Photo_Name_add1;
	private String shop_Photo_Name_add2;
	private String shop_Photo_Name_add3;
	private String shop_Photo_Name_add4;
	private String shop_Photo_Name_add5;

	private MultipartFile shop_Photo_add1;
	private MultipartFile shop_Photo_add2;
	private MultipartFile shop_Photo_add3;
	private MultipartFile shop_Photo_add4;
	private MultipartFile shop_Photo_add5;

	
	
	
	public String getPercent() {
		return percent;
	}

	public void setPercent(String percent) {
		this.percent = percent;
	}

	public String getPid_Shop() {
		return pid_Shop;
	}

	public void setPid_Shop(String pid_Shop) {
		this.pid_Shop = pid_Shop;
	}

	public String getMenu_Contents() {
		return menu_Contents;
	}

	public void setMenu_Contents(String menu_Contents) {
		this.menu_Contents = menu_Contents;
	}

	public MultipartFile getMenu_Photo_File() {
		return menu_Photo_File;
	}

	public void setMenu_Photo_File(MultipartFile menu_Photo_File) {
		this.menu_Photo_File = menu_Photo_File;
	}

	public String getMenu_Photo_Name() {
		return menu_Photo_Name;
	}

	public void setMenu_Photo_Name(String menu_Photo_Name) {
		this.menu_Photo_Name = menu_Photo_Name;
	}

	public String getSearchContents() {
		return searchContents;
	}

	public void setSearchContents(String searchContents) {
		this.searchContents = searchContents;
	}

	public String getAdrs_street_1_2() {
		return adrs_street_1_2;
	}

	public void setAdrs_street_1_2(String adrs_street_1_2) {
		this.adrs_street_1_2 = adrs_street_1_2;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public String getPid_User() {
		return pid_User;
	}

	public void setPid_User(String pid_User) {
		this.pid_User = pid_User;
	}

	public String getShop_Photo_Name_add1() {
		return shop_Photo_Name_add1;
	}

	public void setShop_Photo_Name_add1(String shop_Photo_Name_add1) {
		this.shop_Photo_Name_add1 = shop_Photo_Name_add1;
	}

	public String getShop_Photo_Name_add2() {
		return shop_Photo_Name_add2;
	}

	public void setShop_Photo_Name_add2(String shop_Photo_Name_add2) {
		this.shop_Photo_Name_add2 = shop_Photo_Name_add2;
	}

	public String getShop_Photo_Name_add3() {
		return shop_Photo_Name_add3;
	}

	public void setShop_Photo_Name_add3(String shop_Photo_Name_add3) {
		this.shop_Photo_Name_add3 = shop_Photo_Name_add3;
	}

	public String getShop_Photo_Name_add4() {
		return shop_Photo_Name_add4;
	}

	public void setShop_Photo_Name_add4(String shop_Photo_Name_add4) {
		this.shop_Photo_Name_add4 = shop_Photo_Name_add4;
	}

	public String getShop_Photo_Name_add5() {
		return shop_Photo_Name_add5;
	}

	public void setShop_Photo_Name_add5(String shop_Photo_Name_add5) {
		this.shop_Photo_Name_add5 = shop_Photo_Name_add5;
	}

	public MultipartFile getShop_Photo_add1() {
		return shop_Photo_add1;
	}

	public void setShop_Photo_add1(MultipartFile shop_Photo_add1) {
		this.shop_Photo_add1 = shop_Photo_add1;
	}

	public MultipartFile getShop_Photo_add2() {
		return shop_Photo_add2;
	}

	public void setShop_Photo_add2(MultipartFile shop_Photo_add2) {
		this.shop_Photo_add2 = shop_Photo_add2;
	}

	public MultipartFile getShop_Photo_add3() {
		return shop_Photo_add3;
	}

	public void setShop_Photo_add3(MultipartFile shop_Photo_add3) {
		this.shop_Photo_add3 = shop_Photo_add3;
	}

	public MultipartFile getShop_Photo_add4() {
		return shop_Photo_add4;
	}

	public void setShop_Photo_add4(MultipartFile shop_Photo_add4) {
		this.shop_Photo_add4 = shop_Photo_add4;
	}

	public MultipartFile getShop_Photo_add5() {
		return shop_Photo_add5;
	}

	public void setShop_Photo_add5(MultipartFile shop_Photo_add5) {
		this.shop_Photo_add5 = shop_Photo_add5;
	}

	public String getCloseTime() {
		return closeTime;
	}

	public void setCloseTime(String closeTime) {
		this.closeTime = closeTime;
	}

	public String getShop_Manager() {
		return shop_Manager;
	}

	public void setShop_Manager(String shop_Manager) {
		this.shop_Manager = shop_Manager;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public String getOpenTime() {
		return openTime;
	}

	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getOpenDate() {
		return openDate;
	}

	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}

	public int getAdrs_post_code() {
		return adrs_post_code;
	}

	public void setAdrs_post_code(int adrs_post_code) {
		this.adrs_post_code = adrs_post_code;
	}

	public String getAdrs_street_1() {
		return adrs_street_1;
	}

	public void setAdrs_street_1(String adrs_street_1) {
		this.adrs_street_1 = adrs_street_1;
	}

	public String getAdrs_street_2() {
		return adrs_street_2;
	}

	public void setAdrs_street_2(String adrs_street_2) {
		this.adrs_street_2 = adrs_street_2;
	}

}
