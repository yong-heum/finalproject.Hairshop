package com.hair.shop.HS_DN_USER;

import org.springframework.web.multipart.MultipartFile;

import com.hair.shop.HS_DN_USER.HS_DN_BEAN_User;

public class HS_DN_BEAN_User {

	private String pid;
	private String id;
	private String password;
	private String name;
	private String gender;
	private String birthDay;
	private String tel;
	private String adrs_post_code;
	private String adrs_street_1;
	private String adrs_street_2;
	private String email;
	private int email_rs;
	private String join_date;
	private String update_date;
	private String point;
	private String introduce;
	private String closed;
	private String belong_Shop;
	private int price_rs;
	
	
	// 매장사진파일 첨부하기위한 필드 2개
	private MultipartFile profile_Photo;
	private String profile_Photo_Name;
	





	public int getPrice_rs() {
		return price_rs;
	}

	public void setPrice_rs(int price_rs) {
		this.price_rs = price_rs;
	}

	public String getBelong_Shop() {
		return belong_Shop;
	}

	public void setBelong_Shop(String belong_Shop) {
		this.belong_Shop = belong_Shop;
	}

	public String getProfile_Photo_Name() {
		return profile_Photo_Name;
	}

	public void setProfile_Photo_Name(String profile_Photo_Name) {
		this.profile_Photo_Name = profile_Photo_Name;
	}

	public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
		this.point = point;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public String getClosed() {
		return closed;
	}

	public void setClosed(String closed) {
		this.closed = closed;
	}

	public MultipartFile getProfile_Photo() {
		return profile_Photo;
	}

	public void setProfile_Photo(MultipartFile profile_Photo) {
		this.profile_Photo = profile_Photo;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirthDay() {
		return birthDay;
	}

	public void setBirthDay(String birthDay) {
		this.birthDay = birthDay;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getAdrs_post_code() {
		return adrs_post_code;
	}

	public void setAdrs_post_code(String adrs_post_code) {
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getEmail_rs() {
		return email_rs;
	}

	public void setEmail_rs(int email_rs) {
		this.email_rs = email_rs;
	}

	public String getJoin_date() {
		return join_date;
	}

	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	public String getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}

}
