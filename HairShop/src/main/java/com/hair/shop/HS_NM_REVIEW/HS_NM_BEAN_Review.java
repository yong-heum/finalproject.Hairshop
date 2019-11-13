package com.hair.shop.HS_NM_REVIEW;


public class HS_NM_BEAN_Review {

	private int boardNum;
	private String id;
	private String name;
	private String title;
	private String contents;
	private String grade;//평점
	private String shopName;
	private String pid_Shop;
	private String disigner;
	private int hit;
	private String review_Date;
	private String passwordCheck;
	private String check; //수정,삭제 할때 수정인지 삭제인지 알려주는 값
	private int commentCount;
	
	


	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	public String getCheck() {
		return check;
	}
	public void setCheck(String check) {
		this.check = check;
	}
	public String getPasswordCheck() {
		return passwordCheck;
	}
	public void setPasswordCheck(String passwordCheck) {
		this.passwordCheck = passwordCheck;
	}
	public String getReview_Date() {
		return review_Date;
	}
	public void setReview_Date(String review_Date) {
		this.review_Date = review_Date;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getPid_Shop() {
		return pid_Shop;
	}
	public void setPid_Shop(String pid_Shop) {
		this.pid_Shop = pid_Shop;
	}
	
	public String getDisigner() {
		return disigner;
	}
	public void setDisigner(String disigner) {
		this.disigner = disigner;
	}
	
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}

	
	
	
}
