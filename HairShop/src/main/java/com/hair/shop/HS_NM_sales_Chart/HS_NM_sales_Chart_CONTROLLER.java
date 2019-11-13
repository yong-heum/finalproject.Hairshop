package com.hair.shop.HS_NM_sales_Chart;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hair.shop.HS_NM_TICETIGN.HS_NM_TCKETING_DAO;

@Controller
public class HS_NM_sales_Chart_CONTROLLER {

	@Autowired
	private HS_NM_sales_Chart_SERVICE service;
	@Autowired
	private HS_NM_TCKETING_DAO DAO;

// sales_Chart_DN JSP로 이동
	@RequestMapping(value = "/sales_Chart_DN")
	public String sales_Chart_DN() {
		return "sales_Chart_DN";
	}

// sales_Chart JSP로 이동
	@RequestMapping(value = "/sales_Chart_SHOP")
	public String sales_Chart_SHOP(String id, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		// 디자이너 pid불러오기
		String disigner_pid = DAO.disigner_pid(id);

		// 아이디로 매장 이름 불러오기
		String belong_Shop = DAO.shopNameResult(disigner_pid);

		if (belong_Shop == null) {
			out.println("<script>");
			out.println("alert('소속되어있는 매장이 없습니다.')");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}

		return "sales_Chart_SHOP";
	}

// 매출 불러오기(ajax) 
	@RequestMapping(value = "/sales_Chart_Select")
	public @ResponseBody HS_NM_BEAN_sales_Chart sales_Chart_Select(HS_NM_BEAN_sales_Chart sales) throws ParseException {

		HS_NM_BEAN_sales_Chart result = null;
		if (sales.getSales_Select() == 0) {
			// 본인 하루 매출
			result = service.sales_Chart_Select1(sales);
		} else if (sales.getSales_Select() == 1) {
			// 본인 일주일 매출
			result = service.sales_Chart_Select2(sales);
		} else if (sales.getSales_Select() == 2) {
			// 본인 한달 매출
			result = service.sales_Chart_Select3(sales);
		} else if (sales.getSales_Select() == 3) {
			// 매장 하루 매출
			result = service.sales_Chart_Select4(sales);
		} else if (sales.getSales_Select() == 4) {
			// 매장 일주일 매출
			result = service.sales_Chart_Select5(sales);
		} else if (sales.getSales_Select() == 5) {
			// 매장 한달 매출
			result = service.sales_Chart_Select6(sales);
		}
		return result;
	}
}