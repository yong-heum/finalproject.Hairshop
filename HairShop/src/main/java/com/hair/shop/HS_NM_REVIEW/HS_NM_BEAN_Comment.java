package com.hair.shop.HS_NM_REVIEW;

public class HS_NM_BEAN_Comment {

	private int commentNum;
	private int commentNum_Second;
	private int boardNum;
	private String id;
	private String pid;
	private String contents;
	private String comment_Date;
	private String hideId;
	private int rn;
	private int count;
	
	
	

	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getRn() {
		return rn;
	}
	public void setRn(int rn) {
		this.rn = rn;
	}
	public int getCommentNum() {
		return commentNum;
	}
	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}
	public int getCommentNum_Second() {
		return commentNum_Second;
	}
	public void setCommentNum_Second(int commentNum_Second) {
		this.commentNum_Second = commentNum_Second;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public String getHideId() {
		return hideId;
	}
	public void setHideId(String hideId) {
		this.hideId = hideId;
	}
	public String getComment_Date() {
		return comment_Date;
	}
	public void setComment_Date(String comment_Date) {
		this.comment_Date = comment_Date;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}

}
