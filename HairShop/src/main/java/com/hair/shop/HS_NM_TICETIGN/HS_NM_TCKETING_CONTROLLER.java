package com.hair.shop.HS_NM_TICETIGN;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hair.shop.HS_DN_USER.HS_DN_BEAN_User;
import com.hair.shop.HS_NM_TICETIGN.HS_NM_BEAN_CLOSEDS;
import com.hair.shop.HS_NM_USER.HS_NM_BEAN_User;

@Controller
public class HS_NM_TCKETING_CONTROLLER {

	private ModelAndView mav;

	@Autowired
	private HS_NM_TCKETING_SERVICE service;

//로그인JPS로 이동
	@RequestMapping(value = "/priceJSP")
	public ModelAndView priceJSP(@ModelAttribute("user") HS_DN_BEAN_User user) {

		mav = new ModelAndView();
		
		List<String> time_num = new ArrayList<String>();
		String mm = "00";
		

		time_num.add("12:00");
		time_num.add("12:30");
		for (int i = 1; i < 12; i++) {

			mm = "00";
			time_num.add(i + ":" + mm);

			mm = "30";
			time_num.add(i + ":" + mm);

		}
		mav.addObject("time_num", time_num);
		mav.setViewName("priceInsert");
		return mav;
	}

// ticketingJSP로  이동
	@RequestMapping(value = "/ticketingJSP_1")
	public ModelAndView ticketingJSP_1(@RequestParam(value="shopName",  required = false) String shopName) {
		mav = new ModelAndView();
		mav.addObject("shopName",shopName);
		mav.setViewName("ticketing_1");
		return mav;
	}

// 휴무등록JSP로 휴무 날짜 리스트 정보 가지고 이동 페이지로 이동
	@RequestMapping(value = "/closedInsertJSP")
	public ModelAndView closedInsertJSP(@RequestParam("id") String id, HttpServletResponse response) throws IOException {

		mav = service.closedInsertJSP(id,response);
		return mav;
	}

// 휴무취소 JSP로 휴무 날짜 리스트 정보 가지고 이동 페이지로 이동 
	@RequestMapping(value = "/closedDeleteJSP")
	public ModelAndView closedDeleteJSP(@RequestParam("id") String id, HttpServletResponse response) throws IOException {

		mav = service.closedDeleteJSP(id,response);
		return mav;
	}

// ticketingJSP로 휴무 날짜 리스트 정보 가지고 이동(Ajax)
	@RequestMapping(value = "/closeds_List")
	public @ResponseBody List<String> closeds_List(HS_NM_BEAN_CLOSEDS closeds) {

		List<String> closeds_List = service.closeds_List(closeds);

		return closeds_List;
	}

// 소속 매장, 시술 금액 등록
	@RequestMapping(value = "/priceInsert")
	public void priceInsert(HS_NM_BEAN_PRICE price, HttpServletResponse response) throws IOException {

		service.priceInsert(price, response);
	}

// 개인 시술 금액 정보 불러오기
	@RequestMapping(value = "/priceSelect")
	public ModelAndView priceSelect(@RequestParam("disigner_id") String disigner_id, @RequestParam("check") int check, HttpServletResponse response) throws IOException {

		mav = service.priceSelect(disigner_id, check, response);
		return mav;
	}

// 개인 시술금액 , 직급, 근무시간 수정
	@RequestMapping(value = "/priceUpdate")
	public void priceUpdate(HS_NM_BEAN_PRICE price, HttpServletResponse response) throws IOException {

		service.priceUpdate(price, response);
	}

// 휴무등록 
	@RequestMapping(value = "/ClosedInsert")
	public void ClosedInsert(HS_NM_BEAN_CLOSEDS closeds, HttpServletResponse response) throws IOException {

		service.ClosedsInsert(closeds, response);
	}

// 휴무삭제
	@RequestMapping(value = "/ClosedsDelete")
	public void ClosedsDelete(HS_NM_BEAN_CLOSEDS closeds, HttpServletResponse response) throws IOException {

		service.ClosedsDelete(closeds, response);
	}

// ticketing_2 JSP로 예약 되어있는 날짜 정보 가져가기 (ticketing_1에서 가져온 정보 가져가기)
	@RequestMapping(value = "/ticketingJSP_2")
	public ModelAndView ticketingJSP_2(HS_NM_BEAN_TICKETING ticketing) {

		mav = service.ticketingJSP_2(ticketing);
		return mav;
	}

// 예약정보 저장하기 
	@RequestMapping(value = "/ticketing")
	public void ticketing(HS_NM_BEAN_TICKETING ticketing, HttpServletResponse response) throws IOException {

		service.ticketing(ticketing, response);
	}

// ticketHistoryJSP로 이동하면서 예매 내역 정보 불러오기
	@RequestMapping(value = "/ticketHistoryJSP")
	public ModelAndView ticketHistoryJSP(@RequestParam("id") String id) {

		mav = service.ticketHistoryJSP(id);
		return mav;
	}

// ticketing_DN_List 모달에 고객이 디자이너에게 예매했던 내역 정보 불러오기(Ajax)
	@RequestMapping(value = "/ticketHistory_DN")
	public @ResponseBody List<HS_NM_BEAN_TICKETING> ticketHistory_DN(HS_NM_BEAN_TICKETING ticketing) {
		List<HS_NM_BEAN_TICKETING> result = service.ticketHistory_DN(ticketing);
		return result;
	}

// ticketing_ListJSP 페이지로 이동
	@RequestMapping(value = "/ticketing_DN_ListJSP")
	public ModelAndView ticketing_DN_ListJSP(@RequestParam("id") String id, HttpServletResponse response) throws IOException {

		mav = service.ticketing_DN_ListJSP(id,response);
		return mav;
	}

// ticketing_ListJSP에서 값을 가지고 예약리스트 불러오기 (Ajax)
	@RequestMapping(value = "/ticketing_DN_List")
	public @ResponseBody List<HS_NM_BEAN_TICKETING> ticketing_DN_List(HS_NM_BEAN_TICKETING ticketing) {

		return service.ticketing_DN_List(ticketing);
	}

// ticketing_ListJSP에서 값을 가지고 모달창르오 고객정보 불러오기 (Ajax)
	@RequestMapping(value = "/user_info")
	public @ResponseBody HS_NM_BEAN_User user_info(@RequestParam("customer_id") String customer_id) {

		return service.user_info(customer_id);
	}

// 디자이너가 시술 완료시  시술 완료로 바꾸고 포인트 지급이 가능 하게 함.
	@RequestMapping(value = "/work_completed")
	public void work_completed(HS_NM_BEAN_TICKETING ticketing, HttpServletResponse response) throws IOException {

		service.work_completed(ticketing, response);
	}

// 예약 취소 
	@RequestMapping(value = "/ticketing_cancel")
	public void ticketing_cancel(HS_NM_BEAN_TICKETING ticketing, HttpServletResponse response) throws IOException {

		service.ticketing_cancel(ticketing, response);
	}

// ticketing_Block_1 JSP로 디자이너 id, 매장이름정보 가지고 이동
	@RequestMapping(value = "/ticketing_Block_1")
	public ModelAndView ticketing_Block_1(@RequestParam("id") String id, HttpServletResponse response) throws IOException {

		mav = service.ticketing_Block_1(id,response);
		return mav;
	}

// ticketing_Block_2 JSP로 예약 정보가지고 이동
	@RequestMapping(value = "/ticketing_Block_2")
	public ModelAndView ticketing_Block_2(HS_NM_BEAN_TICKETING ticketing) {

		mav = service.ticketing_Block_2(ticketing);
		return mav;
	}

// 예약 강제 막기
	@RequestMapping(value = "/ticketing_Block_Insert")
	public void ticketing_Block_Insert(HS_NM_BEAN_TICKETING ticketing, HttpServletResponse response)
			throws IOException {

		service.ticketing_Block_Insert(ticketing, response);
	}

}
