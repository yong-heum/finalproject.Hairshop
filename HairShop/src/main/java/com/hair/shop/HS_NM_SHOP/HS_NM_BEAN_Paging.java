package com.hair.shop.HS_NM_SHOP;

public class HS_NM_BEAN_Paging {

	
	private int page; // 페이지 번호
	private int maxPage; // 15페이지까지 있어도 10페이지까지만 보여주고 다음을만들어 넘어가게 하는 값
	private int startPage; //ex) 1번시작, 11번시작, 21번시작
	private int endPage; //ex) 10번끝, 20번끝, 30번끝
	private int listCountPage; //전체 카운트 갯수
	private int limit; // 페이지당 몇개의 글을 보여줄지 정해주는 값
	private int startRow; // 1번째글부터 10번글까지 보여줘야할때 1번
	private int endRow; // 1번째글부터 10번글까지 보여줘야할때 10번
	private int NPorSP_Page;
	private String searchContents;
	private String adrs_street_1;
	private String pid; // DB에 pid값을 저장해 가져오기위함.
	
	
	
	
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getAdrs_street_1() {
		return adrs_street_1;
	}
	public void setAdrs_street_1(String adrs_street_1) {
		this.adrs_street_1 = adrs_street_1;
	}

	public String getSearchContents() {
		return searchContents;
	}
	public void setSearchContents(String searchContents) {
		this.searchContents = searchContents;
	}
	public int getNPorSP_Page() {
		return NPorSP_Page;
	}
	public void setNPorSP_Page(int nPorSP_Page) {
		NPorSP_Page = nPorSP_Page;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getListCountPage() {
		return listCountPage;
	}
	public void setListCountPage(int listCountPage) {
		this.listCountPage = listCountPage;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
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
	
	
	
}
