package com.hair.shop.HS_NM_TICETIGN;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.hair.shop.HS_NM_USER.HS_NM_BEAN_User;
import com.hair.shop.HS_NM_USER.HS_NM_USER_DAO;

@Service
public class HS_NM_TCKETING_SERVICE {

	ModelAndView mav;

	@Autowired
	private HS_NM_TCKETING_DAO DAO;
	@Autowired
	private HS_NM_USER_DAO NM_USER_DAO;

// 소속 매장, 시술 금액 등록
	public void priceInsert(HS_NM_BEAN_PRICE price, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		mav = new ModelAndView();

		// 시간중간에 01시,02시,03시 같은 두자리중 0없애기
		if (price.getWork_Open().substring(0, 1).equals("0")) {
			price.setWork_Open(price.getAmpm_Work_Open() + price.getWork_Open().substring(1, 7));
		} else {
			price.setWork_Open(price.getAmpm_Work_Open() + price.getWork_Open());
		}

		if (price.getWork_Open().substring(0, 1).equals("0")) {
			price.setWork_Closeds(price.getAmpm_Work_Closeds() + price.getWork_Closeds().substring(1, 7));
		} else {
			price.setWork_Closeds(price.getAmpm_Work_Closeds() + price.getWork_Closeds());
		}

		// 오픈시간 마감시간값으로 TICKETING_TIME테이블에서 RN값 찾아오기
		int rn_Open = DAO.rs_Time(price.getWork_Open());
		price.setRn_Open(rn_Open);
		int rn_Closeds = DAO.rs_Time(price.getWork_Closeds());
		price.setRn_Closeds(rn_Closeds);

		// 디자이너 아이디로 pid가져오기
		String disigner_pid = DAO.disigner_pid(price.getDisigner_id());
		price.setDisigner_pid(disigner_pid);

		// 샵 이름으로 샵pid가져오기
		String shop_pid = DAO.shop_pid(price.getShopName());
		price.setShop_pid(shop_pid);

		int result1 = DAO.priceInsert_DNuser(price);
		int result2 = DAO.priceInsert(price);

		if (result1 == 1 && result2 == 1) {
			out.println("<script>");
			out.println("alert('시술 금액이 등록 되었습니다. 소속 매장은 매장에서 승인 후 등록 됩니다.')");
			out.println("location.href='userSelect?id=" + price.getDisigner_id() + "';</script>");
			out.close();

		} else {
			out.println("<script>");
			out.println("alert('알수없는 에러가 나타났습니다. 등록 되지 않았습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

// 개인 시술 금액 정보 불러오기
	public ModelAndView priceSelect(String disigner_id, int check, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		// 디자이너 pid불러오기
		String disigner_pid = DAO.disigner_pid(disigner_id);

		// 아이디로 매장 이름 불러오기
		String belong_Shop = DAO.shopNameResult(disigner_pid);

		if (belong_Shop == null) {
			out.println("<script>");
			out.println("alert('소속되어있는 매장이 없습니다.')");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		List<String> time_num = new ArrayList<String>();

		HS_NM_BEAN_PRICE price = DAO.priceSelect(disigner_id);

		String mm = "00";

		time_num.add("12:00");
		time_num.add("12:30");

		for (int i = 1; i < 12; i++) {

			mm = "00";
			time_num.add(i + ":" + mm);

			mm = "30";
			time_num.add(i + ":" + mm);

		}

		if (check == 1) {

			mav.addObject("price", price);
			mav.setViewName("priceSelect");
		} else {
			mav.addObject("time_num", time_num);
			mav.addObject("price", price);
			mav.setViewName("priceUpdate");
		}
		return mav;
	}

// 개인 시술금액 , 직급, 근무시간 수정
	public void priceUpdate(HS_NM_BEAN_PRICE price, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		mav = new ModelAndView();

		HS_NM_BEAN_PRICE price_rs = DAO.priceSelect(price.getDisigner_id());
		int result = DAO.priceUpdate(price);

		if (result == 1) {
			out.println("<script>");
			out.println("alert('수정 되었습니다.')");
			out.println("location.href='priceSelect?disigner_id=" + price.getDisigner_id() + "&check=1';</script>");
			out.close();

		} else if (price_rs == null) {
			out.println("<script>");
			out.println("alert('시술금액을 등록하지 않으셧습니다.')");
			out.println("history.back();</script>");
			out.close();
		} else {
			out.println("<script>");
			out.println("alert('알수없는 에러가 나타나 수정에 실패하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

// 휴무등록 
	public void ClosedsInsert(HS_NM_BEAN_CLOSEDS closeds, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		// 디자이너 PID불러오기
		String disigner_pid = DAO.disigner_pid(closeds.getDisigner_id());
		closeds.setDisigner_pid(disigner_pid);

		// 디자이너의 이름 불러오기, 디자이너의 소속매장 이름 불러오기
		String shopNameResult = DAO.shopNameResult(closeds.getDisigner_pid());
		String shopName = DAO.shopName(shopNameResult);
		closeds.setShopName(shopName);

		String num0 = closeds.getCloseds_Date().substring(5, 6); // 10월 전인것 01월,02월,03월으로 표시되는것 없애기위함

		if (num0.equals("0")) {
			// 0을 잘라내기위함
			String closeds_Date = closeds.getCloseds_Date().substring(0, 5)
					+ closeds.getCloseds_Date().substring(6, 10);
			closeds.setCloseds_Date("\"" + closeds_Date + "\"");
		} else {
			String closeds_Date = closeds.getCloseds_Date();
			closeds.setCloseds_Date("\"" + closeds_Date + "\"");
		}

		List<String> ticketingCheck = DAO.ticketingCheck(closeds.getCloseds_Date());

		if (ticketingCheck.size() == 0) {
			int result = DAO.ClosedsInsert(closeds);

			if (result == 1) {
				out.println("<script>");
				out.println("alert('등록 되었습니다')");
				out.println("location.href='closedInsertJSP?id=" + closeds.getDisigner_id() + "';</script>");
				out.close();

			} else {
				out.println("<script>");
				out.println("alert('알수없는 에러가 나타나 등록 실패하였습니다.')");
				out.println("history.back();</script>");
				out.close();
			}
		} else {
			out.println("<script>");
			out.println("alert('예약된 고객이 있어 휴무등록을 할 수 없습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

// 휴무삭제
	public void ClosedsDelete(HS_NM_BEAN_CLOSEDS closeds, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		String num0 = closeds.getCloseds_Date().substring(5, 6); // 10월 전인것 01월,02월,03월으로 표시되는것 없애기위함

		if (num0.equals("0")) {
			// 0을 잘라내기위함
			String closeds_Date = closeds.getCloseds_Date().substring(0, 5)
					+ closeds.getCloseds_Date().substring(6, 10);
			closeds.setCloseds_Date("\"" + closeds_Date + "\"");
		} else {
			String closeds_Date = closeds.getCloseds_Date();
			closeds.setCloseds_Date("\"" + closeds_Date + "\"");
		}

		int result = DAO.ClosedsDelete(closeds);

		if (result == 1) {
			out.println("<script>");
			out.println("alert('삭제 되었습니다')");
			out.println("location.href='closedDeleteJSP?id=" + closeds.getDisigner_id() + "';</script>");
			out.close();

		} else {
			out.println("<script>");
			out.println("alert('알수없는 에러가 나타나 삭제를 실패하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

// ticketingJSP로 휴무 날짜 리스트 정보 가지고 이동(Ajax)
	public List<String> closeds_List(HS_NM_BEAN_CLOSEDS closeds) {

		mav = new ModelAndView();
		
		if(closeds.getDisigner_id()!=null) {
			String disigner_pid = DAO.disigner_pid(closeds.getDisigner_id());
			String shop_pid = DAO.shopNameResult(disigner_pid);
			String disigner = DAO.disigner_Name(closeds.getDisigner_id());
			String shop_Name = DAO.shopName(shop_pid);
			
			closeds.setDisigner(disigner);
			closeds.setShopName(shop_Name);
		}
		
		List<String> closeds_Date = DAO.closeds_closedsList(closeds);

		for (int i = 0; i < closeds_Date.size(); i++) {

			String date_get = closeds_Date.get(i).substring(1, closeds_Date.get(i).length() - 1);

			closeds_Date.set(i, date_get);
		}

		return closeds_Date;
	}

// 휴무등록JSP로 휴무 날짜 리스트 정보 가지고 이동 페이지로 이동
	public ModelAndView closedInsertJSP(String id, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		// 아이디로 pid가져오기
		String disigner_pid = DAO.disigner_pid(id);
		// 아이디로 소속매장 pid불러오기
		String belong_Shop = DAO.shopNameResult(disigner_pid);

		if (belong_Shop == null) {
			out.println("<script>");
			out.println("alert('소속되어있는 매장이 없습니다.')");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}

		List<String> closeds_Date = DAO.closeds_InsertList(disigner_pid);
		String disigner = DAO.disigner_Name(id);

		mav.addObject("disigner", disigner);
		mav.addObject("closeds_Date", closeds_Date);
		mav.setViewName("closedInsert");
		return mav;
	}

// 휴무취소 JSP로 휴무 날짜 리스트 정보 가지고 이동 페이지로 이동 closedDeleteJSP
	public ModelAndView closedDeleteJSP(String id, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		// 아이디로 pid가져오기
		String disigner_pid = DAO.disigner_pid(id);
		// 아이디로 소속매장 pid불러오기
		String belong_Shop = DAO.shopNameResult(disigner_pid);

		if (belong_Shop == null) {
			out.println("<script>");
			out.println("alert('소속되어있는 매장이 없습니다.')");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}

		List<String> closeds_Date = DAO.closeds_InsertList(disigner_pid);
		String disigner = DAO.disigner_Name(id);

		mav.addObject("disigner", disigner);
		mav.addObject("closeds_Date", closeds_Date);
		mav.setViewName("closedDelete");
		return mav;
	}

// ticketing_2 JSP로 예약 되어있는 시간 정보 가져가기 (ticketing_1에서 가져온 정보 가져가기)
	public ModelAndView ticketingJSP_2(HS_NM_BEAN_TICKETING ticketing) {

		mav = new ModelAndView();

		int point = 0;

		// 매장 pid가져오기
		String shop_pid = DAO.shop_pid(ticketing.getShopName());
		ticketing.setShop_pid(shop_pid);

		// 두개 변수 합치기
		if (ticketing.getWork_Date().substring(5, 6).equals("0")) {
			String work_Date = ticketing.getWork_Date().substring(0, 5) + ticketing.getWork_Date().substring(6, 10);
			ticketing.setWork_Date(work_Date);
		}
		// 디자이너 아이디 불러오기
		String disigner_id = DAO.disigner_id(ticketing);

		// 예약자 PID불러오기
		String customer_pid = DAO.customer_pid(ticketing.getCustomer_id());

		// 예약 되어있는 시간 정보 불러오기
		List<HS_NM_BEAN_TICKETING> ticketing_List = DAO.ticketing_List(ticketing);
		HS_NM_BEAN_PRICE price = DAO.priceSelect(disigner_id);

		// 고객의 잔여 포인트 불러오기
		if (customer_pid.substring(0, 10).equals("HS_NM_USER")) {

			point = DAO.NM_User_point(customer_pid);

		} else if (customer_pid.substring(0, 10).equals("HS_DN_USER")) {

			point = DAO.DN_User_point(customer_pid);

		}

		// 현제 시간의 시만 불러오기
		int sysDate_HH = DAO.sysDate_HH();

		// 현제 날짜 불러오기
		String sysDate = DAO.sysDate();
		String num0 = sysDate.substring(5, 6); // 10월 전인것 01월,02월,03월으로 표시되는것 없애기위함
		// 0을 잘라내기위함
		String sysDate_result = sysDate.substring(0, 5) + sysDate.substring(6, 10);

		if (num0.equals("0")) {
			sysDate = sysDate_result;
		}

		mav.addObject("sysDate", sysDate);// 현제 날짜와 예약 날짜를 비교해 예약날짜만 현제 시간이전의 예약은 보이지 않게 함.
		mav.addObject("sysDate_HH", sysDate_HH * 2 + 2);// 곱하기*2를 해서 rn값과 비교해 이전 시간은 예약 할 수 없게 하고 당장 한시간 앞까지는 예약하지 못하게함.
		mav.addObject("point", point);
		mav.addObject("ticketing", ticketing);
		mav.addObject("price", price);
		mav.addObject("ticketing_List", ticketing_List);
		mav.setViewName("ticketing_2");

		return mav;
	}

// 예약정보 저장하기 
	public void ticketing(HS_NM_BEAN_TICKETING ticketing, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		ticketing.setPrice_Sale(ticketing.getPoint_Use());

		// 매장 pid 불러오기
		String shop_pid = DAO.shop_pid(ticketing.getShopName());
		ticketing.setShop_pid(shop_pid);

		// 디자이너 pid 불러오기
		String disigner_pid = DAO.ticketing_disigner_pid(ticketing);
		ticketing.setDisigner_pid(disigner_pid);

		// 예약자 PID,NAME 불러오기
		List<HS_NM_BEAN_User> customer_pid_name = DAO.customer_pid_Name(ticketing.getCustomer_id());
		ticketing.setCustomer_pid(customer_pid_name.get(0).getPid());
		ticketing.setCustomer_name(customer_pid_name.get(0).getName());

		// 하나의 이름값으로 받아온 시술이름,시술 가격 나누기
		int index = ticketing.getWork().indexOf(".");

		String work = ticketing.getWork().substring(0, index);
		int price_Original = Integer.parseInt(ticketing.getWork().substring(index + 1, ticketing.getWork().length()));

		ticketing.setWork(work);
		ticketing.setPrice_Original(price_Original);

		// 포인트 사용 계산하기
		int price_After = price_Original - ticketing.getPoint_Use();// 결제금액
		ticketing.setPrice_After(price_After);

		int point = ticketing.getPoint() - ticketing.getPoint_Use();
		ticketing.setPoint(point);

		if (price_After >= 0) {

		} else {
			out.println("<script>");
			out.println("alert('포인트는 시술금액보다 많이 사용하실수 없습니다.')");
			out.println("history.back();</script>");
			out.close();
		}

		// 예약정보 저장
		int result1 = DAO.ticketing_Insert(ticketing);
		// 포인트 사용 후 잔여 포인트 저장
		int result2 = 0;

		if (ticketing.getCustomer_pid().substring(0, 10).equals("HS_NM_USER")) {

			result2 = DAO.NM_User_pointUpdate(ticketing);

		} else if (ticketing.getCustomer_pid().substring(0, 10).equals("HS_DN_USER")) {

			result2 = DAO.DN_User_pointUpdate(ticketing);

		}

		if (result1 == 1 && result2 == 1) {
			out.println("<script>");
			out.println("alert('예약이 완료 되었습니다')");
			out.println("location.href='ticketHistoryJSP?id=" + ticketing.getCustomer_id() + "';</script>");
			out.close();
		} else {
			out.println("<script>");
			out.println("alert('알수없는 오류로 인해 예약을 실패하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

// ticketHistoryJSP로 이도하면서 예매 내역 정보 불러오기
	public ModelAndView ticketHistoryJSP(String id) {

		mav = new ModelAndView();

		List<HS_NM_BEAN_TICKETING> ticketing = DAO.ticketHistoryJSP(id);

		String[] Complete = { "시술 전", "시술 완료", "예약 취소", "강제취소" };

		for (int i = 0; i < ticketing.size(); i++) {
			int complete = Integer.parseInt(ticketing.get(i).getComplete());
			String result = Complete[complete];
			ticketing.get(i).setComplete(result);
		}

		mav.addObject("ticketing", ticketing);
		mav.setViewName("ticketHistory");

		return mav;
	}

// ticketing_DN_List 모달에 고객이 디자이너에게 예매했던 내역 정보 불러오기(Ajax)
	public List<HS_NM_BEAN_TICKETING> ticketHistory_DN(HS_NM_BEAN_TICKETING ticketing) {

		List<HS_NM_BEAN_TICKETING> ticketing1 = DAO.ticketHistory_DN(ticketing);

		String[] Complete = { "시술 전", "시술 완료", "예약 취소", "강제취소" };

		for (int i = 0; i < ticketing1.size(); i++) {
			int complete = Integer.parseInt(ticketing1.get(i).getComplete());
			String result = Complete[complete];
			ticketing1.get(i).setComplete(result);
		}

		for (int i = 0; i < ticketing1.size(); i++) {
			if (ticketing1.get(i).getWork_Contents() == null) {
				ticketing1.get(i).setWork_Contents(".");
			}
		}

		return ticketing1;
	}

// ticketing_ListJSP 페이지로 이동
	public ModelAndView ticketing_DN_ListJSP(String id, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

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
		// 디자이너의 휴무날짜 가져옴.
		List<String> closeds_Date = DAO.closeds_InsertList(disigner_pid);

		mav.addObject("closeds_Date", closeds_Date);
		mav.setViewName("ticketing_DN_List");
		return mav;
	}

// ticketing_DN_ListJSP에서 값을 가지고 예약리스트 불러오기 (Ajax)
	public List<HS_NM_BEAN_TICKETING> ticketing_DN_List(HS_NM_BEAN_TICKETING ticketing) {

		ticketing.setDisigner_pid(DAO.disigner_pid(ticketing.getDisigner_id()));

		String num0 = ticketing.getWork_Date().substring(5, 6); // 10월 전인것 01월,02월,03월으로 표시되는것 없애기위함
		// 0을 잘라내기위함
		String Date_result = ticketing.getWork_Date().substring(0, 5) + ticketing.getWork_Date().substring(6, 10);

		if (num0.equals("0")) {
			ticketing.setWork_Date(Date_result);
		}

		List<HS_NM_BEAN_TICKETING> result = DAO.ticketing_DN_List(ticketing);

		for (int i = 0; i < result.size(); i++) {
			if (result.get(i).getComplete().equals("1")) {
				result.get(i).setComplete("시술 완료");
			} else {
				result.get(i).setComplete("시술 전");
			}
		}
		return result;
	}

// ticketing_ListJSP에서 값을 가지고 모달창르오 고객정보 불러오기 (Ajax)
	public HS_NM_BEAN_User user_info(String customer_id) {
		return NM_USER_DAO.NM_userSelect(customer_id);
	}

// 디자이너가 시술 완료시  시술 완료로 바꾸고 포인트 지급이 가능 하게 함.
	public void work_completed(HS_NM_BEAN_TICKETING ticketing, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		String pid = DAO.disigner_pid(ticketing.getCustomer_id());
		ticketing.setDisigner_pid(pid);

		int result = DAO.work_completed(ticketing);

		if (result == 1) {
			if (pid.substring(0, 10).equals("HS_DN_USER")) {
				DAO.DN_user_Point_Count_Up(pid);
				out.println("<script>");
				out.println("alert('완료 되었습니다')");
				out.println("location.href='ticketing_DN_ListJSP?id=" + ticketing.getDisigner_id() + "';</script>");
				out.close();
			} else if (pid.substring(0, 10).equals("HS_NM_USER")) {
				DAO.NM_user_Point_Count_Up(pid);
				out.println("<script>");
				out.println("alert('완료 되었습니다')");
				out.println("location.href='ticketing_DN_ListJSP?id=" + ticketing.getDisigner_id() + "';</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('알수없는 오류로 인해 예약을 실패하였습니다.')");
				out.println("history.back();</script>");
				out.close();
			}
		} else {
			out.println("<script>");
			out.println("alert('알수없는 오류로 인해 예약을 실패하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

// 예약 취소
	public void ticketing_cancel(HS_NM_BEAN_TICKETING ticketing, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		// 예약 취소 complete 2으로 변경
		int result = DAO.ticketing_cancel(ticketing);

		if (result == 1) {
			out.println("<script>");
			out.println("alert('예약이 취소 되었습니다')");
			out.println("location.href='ticketing_DN_ListJSP?id=" + ticketing.getDisigner_id() + "';</script>");
			out.close();
		} else {
			out.println("<script>");
			out.println("alert('알수없는 오류로 인해 예약취소를 실패하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

// ticketing_Block_1 JSP로 디자이너 id, 매장이름정보 가지고 이동
	public ModelAndView ticketing_Block_1(String id, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		// 디자이너 pid가져오기
		String disigner_pid = DAO.disigner_pid(id);

		// 소속매장 pid가져오기
		String shop_pid = DAO.shopNameResult(disigner_pid);

		// 아이디로 매장 이름 불러오기
		String belong_Shop = DAO.shopName(shop_pid);

		if (belong_Shop == null) {
			out.println("<script>");
			out.println("alert('소속되어있는 매장이 없습니다.')");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}

		mav.addObject("disigner_id", id);
		mav.addObject("shop_pid", shop_pid);
		mav.setViewName("ticketing_Block_1");
		return mav;
	}

// ticketing_Block_2 JSP로 예약 정보가지고 이동
	public ModelAndView ticketing_Block_2(HS_NM_BEAN_TICKETING ticketing) {

		mav = new ModelAndView();

		// 매장 이름가져오기
		String shopName = DAO.shopName(ticketing.getShop_pid());
		ticketing.setShopName(shopName);

		// 날짜정보 10월 밑으로 0삭제
		if (ticketing.getWork_Date().substring(5, 6).equals("0")) {
			ticketing
					.setWork_Date(ticketing.getWork_Date().substring(0, 5) + ticketing.getWork_Date().substring(6, 10));
		}
		// 디자이너 이름 불러오기
		String disigner = DAO.disigner_Name(ticketing.getDisigner_id());
		ticketing.setDisigner(disigner);

		// 예약 되어있는 시간 정보 불러오기
		List<HS_NM_BEAN_TICKETING> ticketing_List = DAO.ticketing_List(ticketing);

		// 디자이너의 프라이스 테이블 정보 가져오기
		HS_NM_BEAN_PRICE price = DAO.priceSelect(ticketing.getDisigner_id());

		// 현제 시간의 시만 불러오기
		int sysDate_HH = DAO.sysDate_HH();

		// 현제 날짜 불러오기
		String sysDate = DAO.sysDate();
		String num0 = sysDate.substring(5, 6); // 10월 전인것 01월,02월,03월으로 표시되는것 없애기위함
		// 0을 잘라내기위함
		String sysDate_result = sysDate.substring(0, 5) + sysDate.substring(6, 10);

		if (num0.equals("0")) {
			sysDate = sysDate_result;
		}

		mav.addObject("sysDate", sysDate);// 현제 날짜와 예약 날짜를 비교해 예약날짜만 현제 시간이전의 예약은 보이지 않게 함.
		mav.addObject("sysDate_HH", sysDate_HH * 2 + 4);// 곱하기*2를 해서 rn값과 비교해 이전 시간은 예약 할 수 없게 하고 당장 한시간 앞까지는 예약하지 못하게함.
		mav.addObject("ticketing", ticketing);
		mav.addObject("price", price);
		mav.addObject("ticketing_List", ticketing_List);
		mav.setViewName("ticketing_Block_2");

		return mav;
	}

// 예약 강제 막기
	public void ticketing_Block_Insert(HS_NM_BEAN_TICKETING ticketing, HttpServletResponse response)
			throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		// 매장 pid불러오기
		String shop_pid = DAO.shop_pid(ticketing.getShopName());
		ticketing.setShop_pid(shop_pid);
		// 디자이너 id불러오기
		String disigner_id = DAO.disigner_id(ticketing);
		ticketing.setDisigner_id(disigner_id);
		// 디자이너 pid 불러오기
		String disigner_pid = DAO.disigner_pid(ticketing.getDisigner_id());
		ticketing.setDisigner_pid(disigner_pid);

		int result = DAO.ticketing_Block_Insert(ticketing);

		if (result == 1) {
			out.println("<script>");
			out.println("alert('지정하신 시간을 예약불가로 바꿨습니다')");
			out.println("location.href='ticketing_Block_1?id=" + ticketing.getDisigner_id() + "';</script>");
			out.close();
		} else {
			out.println("<script>");
			out.println("alert('알수없는 오류로 인해 실패하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

}
