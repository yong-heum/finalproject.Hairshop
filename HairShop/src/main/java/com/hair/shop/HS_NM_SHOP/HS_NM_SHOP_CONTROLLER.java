package com.hair.shop.HS_NM_SHOP;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hair.shop.HS_DN_USER.HS_DN_BEAN_User;

@Controller
public class HS_NM_SHOP_CONTROLLER {

	private ModelAndView mav;

	@Autowired
	private HS_NM_SHOP_SERVICE service;

// 매장이름 중복확인 처리(ajax) 
	@RequestMapping(value = "/shopName_Overlap")
	public @ResponseBody String shopName_Overlap(@RequestParam("shopName") String shopName) {

		String resultMsg = service.shopName_Overlap(shopName);

		return resultMsg;
	}

// 매장 등록하기
	@RequestMapping(value = "/shopInsert")
	public ModelAndView shopInsert(@ModelAttribute HS_NM_BEAN_Shop shop, HttpServletResponse response)
			throws IOException {

		mav = service.shopInsert(shop, response);
		return mav;
	}

// 매장 목록보기 페이징(기본, 고객 주소 주변)
	@RequestMapping(value = "/shopPaging")
	public ModelAndView BoardListPaging(@ModelAttribute HS_NM_BEAN_Paging page,
			@ModelAttribute HS_NM_BEAN_Shop shop) {

		mav = service.shopPaging(page, shop);
		return mav;
	}

// 매장 검색 페이징(매장이름,동네검색)
	@RequestMapping(value = "/search")
	public ModelAndView search(@ModelAttribute HS_NM_BEAN_Paging page,
			@ModelAttribute HS_NM_BEAN_Shop shop) {

		mav = service.search(page, shop);
		return mav;
	}

// 매장 상세조회
	@RequestMapping(value = "/shopSelect")
	public ModelAndView shopSelect(@RequestParam("pid_Shop") String pid_Shop,
			@RequestParam("page") String page) {

		mav = service.shopSelect(pid_Shop, page);
		return mav;
	}

// 시술 가격표 수정 (원래 정보가져오기)
	@RequestMapping(value = "/menuInsert1")
	public ModelAndView menuInsert1(@ModelAttribute HS_NM_BEAN_Shop shop,
			@RequestParam("page") String page) {

		mav = service.menuInsert1(shop, page);
		return mav;
	}

// 시술 가격표 수정,등록
	@RequestMapping(value = "/menuInsert2")
	public ModelAndView menuInsert2(@ModelAttribute HS_NM_BEAN_Shop shop,
			@RequestParam("page") String page, HttpServletResponse response) throws IOException {

		mav = service.menuInsert2(shop, page, response);
		return mav;
	}

// 시술 가격표 삭제
	@RequestMapping(value = "/menuDelete")
	public ModelAndView menuDelete(@RequestParam("pid_Shop") String pid_Shop,
			@RequestParam("page") String page, HttpServletResponse response) throws IOException {

		mav = service.menuDelete(pid_Shop, page, response);
		return mav;
	}

// 매장 수정(정보불러오기)
	@RequestMapping(value = "/shopUpdate1")
	public ModelAndView shopUpdate1(@ModelAttribute HS_NM_BEAN_Shop shop,
			@RequestParam("page") String page) {

		mav = service.shopUpdate1(shop, page);
		return mav;
	}

// 매장 수정(정보불러오기)
	@RequestMapping(value = "/shopUpdate2")
	public ModelAndView shopUpdate2(@ModelAttribute HS_NM_BEAN_Shop shop,
			@RequestParam("page") String page, HttpServletResponse response) throws IOException {

		mav = service.shopUpdate2(shop, page, response);
		return mav;
	}

// 매장 삭제
	@RequestMapping(value = "/shopDelete")
	public ModelAndView shopDelete(@ModelAttribute HS_NM_BEAN_Shop shop,
			@RequestParam("pid_user") String pid_user, @RequestParam("page") String page) {

		mav = service.shopDelete(shop, pid_user, page);
		return mav;
	}

// 매장 등록 신청 (목록 보기)
	@RequestMapping(value = "/shopApply1")
	public ModelAndView shopApply1() {

		mav = service.shopApply1();
		return mav;
	}

// 매장 등록 신청 목록 (승인하기)
	@RequestMapping(value = "/shopApply2")
	public void shopApply2(@RequestParam("pid_shop") String pid_shop,
			HttpServletResponse response) throws IOException {

		service.shopApply2(pid_shop, response);
	}

// 매장 등록 신청 목록 (삭제하기)
	@RequestMapping(value = "/shopApplyDelete")
	public void shopApplyDelete(@RequestParam("pid_shop") String pid_shop,
			HttpServletResponse response) throws IOException {

		service.shopApplyDelete(pid_shop, response);
	}

// 디자이너 소속매장 등록 신청 (목록 보기)
	@RequestMapping(value = "/shop_Disigner_ApplyJSP")
	public ModelAndView shop_Disigner_ApplyJSP() {

		mav = service.shop_Disigner_ApplyJSP();
		return mav;
	}

// 매장 등록 신청 목록 (승인하기)
	@RequestMapping(value = "/shop_Disigner_Apply")
	public void shop_Disigner_Apply(HS_DN_BEAN_User user,
			HttpServletResponse response) throws IOException {

		service.shop_Disigner_Apply(user, response);
	}
	
// // 매장 등록 신청 목록 (삭제하기)
	@RequestMapping(value = "/shop_Disigner_Apply_Delete")
	public void shop_Disigner_Apply_Delete(HS_DN_BEAN_User user, @RequestParam("page") String page,
			HttpServletResponse response) throws IOException {

		service.shop_Disigner_Apply_Delete(user,page, response);
	}
}
