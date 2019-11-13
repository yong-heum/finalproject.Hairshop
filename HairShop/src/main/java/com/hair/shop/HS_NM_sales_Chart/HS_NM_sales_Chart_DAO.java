package com.hair.shop.HS_NM_sales_Chart;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HS_NM_sales_Chart_DAO {

	@Autowired
	private SqlSessionTemplate sql;

// 본인 하루 매출  가져오기
	public String sales_List1(HS_NM_BEAN_sales_Chart sales) {
		return sql.selectOne("sales.sales_List1", sales);
	}

// 하나씩 더해줄 본인 일주일 매출 가져오기 
	public List<String> sales_List2(HS_NM_BEAN_sales_Chart sales) {
		return sql.selectList("sales.sales_List2", sales);
	}

// 본인 월 매출 가져오기 
	public String sales_List3(HS_NM_BEAN_sales_Chart sales) {
		return sql.selectOne("sales.sales_List3", sales);
	}

// 매장 하루 매출 가져오기
	public String sales_List4(HS_NM_BEAN_sales_Chart sales) {
		return sql.selectOne("sales.sales_List4", sales);
	}

// 하나씩 더해줄 매장 일주일 매출 가져오기
	public List<String> sales_List5(HS_NM_BEAN_sales_Chart sales) {
		return sql.selectList("sales.sales_List5", sales);
	}

// 매장 월 매출 가져오기 
	public String sales_List6(HS_NM_BEAN_sales_Chart sales) {
		return sql.selectOne("sales.sales_List6", sales);
	}
}