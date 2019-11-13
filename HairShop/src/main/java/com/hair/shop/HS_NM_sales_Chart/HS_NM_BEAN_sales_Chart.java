package com.hair.shop.HS_NM_sales_Chart;

public class HS_NM_BEAN_sales_Chart {

	private int sales_Select;
	private String date;
	private String id;
	private String shop_pid;
	private int sales;
	private String[] dateArray = new String[6];
	private int[] salesArray = new int[6];
	private String MM_Date;
	
	
	
	
	
	
	
	public String getShop_pid() {
		return shop_pid;
	}
	public void setShop_pid(String shop_pid) {
		this.shop_pid = shop_pid;
	}
	public String getMM_Date() {
		return MM_Date;
	}
	public void setMM_Date(String mM_Date) {
		MM_Date = mM_Date;
	}
	public int[] getSalesArray() {
		return salesArray;
	}
	public void setSalesArray(int[] salesArray) {
		this.salesArray = salesArray;
	}
	public String[] getDateArray() {
		return dateArray;
	}
	public void setDateArray(String[] dateArray) {
		this.dateArray = dateArray;
	}
	public int getSales_Select() {
		return sales_Select;
	}
	public void setSales_Select(int sales_Select) {
		this.sales_Select = sales_Select;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getSales() {
		return sales;
	}
	public void setSales(int sales) {
		this.sales = sales;
	}
	
	
	
	
}
