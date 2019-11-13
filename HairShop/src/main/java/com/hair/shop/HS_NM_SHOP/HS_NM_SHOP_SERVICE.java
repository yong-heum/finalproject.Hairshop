package com.hair.shop.HS_NM_SHOP;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hair.shop.HS_DN_USER.HS_DN_BEAN_User;
import com.hair.shop.HS_DN_USER.HS_DN_USER_DAO;
import com.hair.shop.HS_NM_USER.HS_NM_BEAN_User;
import com.hair.shop.HS_NM_USER.HS_NM_USER_DAO;

@Service
public class HS_NM_SHOP_SERVICE {

	ModelAndView mav;

	@Autowired
	private HS_NM_SHOP_DAO DAO;
	@Autowired
	private HS_NM_USER_DAO NM_USER_DAO;
	@Autowired
	private HS_DN_USER_DAO DN_USER_DAO;

// 매장이름 중복확인
	public String shopName_Overlap(String shopName) {

		String overlapId = DAO.shopName_Overlap(shopName);
		String resultMsg;

		if (overlapId == null) {
			resultMsg = "OK";
		} else {
			resultMsg = "NO";
		}
		return resultMsg;
	}

//매장 등록하기
	public ModelAndView shopInsert(HS_NM_BEAN_Shop shop, HttpServletResponse response) throws IOException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		Random ran = new Random();
		mav = new ModelAndView();

		// db저장시 엔터 가능처리
		shop.setIntroduce(shop.getIntroduce().replace("\r\n", "<br>"));
		shop.setMenu_Contents(shop.getMenu_Contents().replace("\r\n", "<br>"));

		// 고유번호 생성
		shop.setPid("HS_NM_SHOP_" + shop.getShopName() + "_" + ran.nextInt(99));

		// 메뉴 사진 파일 첨부
		MultipartFile menu_Photo_File = shop.getMenu_Photo_File();
		String menu_Photo_Name = menu_Photo_File.getOriginalFilename();
		String savePath1 = "C:\\Users\\gg\\Desktop\\용흠\\HairShop\\src\\main\\webapp\\resources\\menu_photo\\"
				+ menu_Photo_Name;

		if (!menu_Photo_File.isEmpty()) {
			menu_Photo_File.transferTo(new File(savePath1));
		}
		shop.setMenu_Photo_Name(menu_Photo_Name);

		// 매장사진 첨부
		MultipartFile Shop_Photo_add[] = new MultipartFile[5];
		String Shop_Photo_Name_add[] = new String[5];

		for (int i = 0; i <= 4; i++) {
			if (i == 0) {
				Shop_Photo_add[i] = shop.getShop_Photo_add1();
			} else if (i == 1) {
				Shop_Photo_add[i] = shop.getShop_Photo_add2();
			} else if (i == 2) {
				Shop_Photo_add[i] = shop.getShop_Photo_add3();
			} else if (i == 3) {
				Shop_Photo_add[i] = shop.getShop_Photo_add4();
			} else if (i == 4) {
				Shop_Photo_add[i] = shop.getShop_Photo_add5();
			}

			Shop_Photo_Name_add[i] = Shop_Photo_add[i].getOriginalFilename();
			String savePath2 = "C:\\Users\\gg\\Desktop\\용흠\\HairShop\\src\\main\\webapp\\resources\\shop_photo\\"
					+ Shop_Photo_Name_add[i];

			if (!Shop_Photo_add[i].isEmpty()) {
				Shop_Photo_add[i].transferTo(new File(savePath2));
			}

			if (i == 0) {
				shop.setShop_Photo_Name_add1(Shop_Photo_Name_add[i]);
			} else if (i == 1) {
				shop.setShop_Photo_Name_add2(Shop_Photo_Name_add[i]);
			} else if (i == 2) {
				shop.setShop_Photo_Name_add3(Shop_Photo_Name_add[i]);
			} else if (i == 3) {
				shop.setShop_Photo_Name_add4(Shop_Photo_Name_add[i]);
			} else if (i == 4) {
				shop.setShop_Photo_Name_add5(Shop_Photo_Name_add[i]);
			}
		}
		int result = DAO.shopInsert(shop);

		// 매장등록 성공 여부, 이동 경로
		if (result == 1) {
			mav.setViewName("redirect:/shopPaging?adrs_street_1=" + shop.getAdrs_street_1() + "&page=0");

		} else {
			out.println("<script>");
			out.println("alert('매장등록에 실패하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
		return mav;
	}

// 매장 목록보기 페이징(회원 주소에 가까운거부터)
	public ModelAndView shopPaging(HS_NM_BEAN_Paging page, HS_NM_BEAN_Shop shop) {

		mav = new ModelAndView();

		if (page.getPage() == 0) {
			page.setPage(1);
		}

		int limit = 9;
		page.setPage(page.getPage());
		page.setLimit(limit);

		int startRow = (page.getPage() - 1) * limit + 1; // ㅇㅋ?
		int endRow = page.getPage() * limit;
		shop.setStartRow(startRow);
		shop.setEndRow(endRow);

		shop.setAdrs_street_1(shop.getAdrs_street_1().substring(0, 10) + "%");
		shop.setAdrs_street_1_2(shop.getAdrs_street_1().substring(0, 2) + "%");

		// 현재 페이지에 보여줘야 하는 글만 DB에서 가져오기
		List<HS_NM_BEAN_Shop> shopList = DAO.shopPaging(shop);

		// 전체 글 갯수 DB에서 가져오기
		int listCount = DAO.shopListCount();

		// 페이지 계산
		int maxPage = (int) ((double) listCount / limit + 0.9);
		// 전체갯수를 구해서 페이지수를 구함.

		// 1~10까지 나오고 다음이 나오게함.
		int startPage = (((int) ((double) page.getPage() / 10 + 0.9)) - 1) * 10 + 1;
		int endPage = startPage + 10 - 1;

		if (endPage > maxPage) { // max페이지가 10개가 되지않을떄 10개를 굳이 만들필요가 없어서 만들어줌.
			endPage = maxPage;
		}

		page.setNPorSP_Page(0);
		page.setStartPage(startPage);
		page.setEndPage(endPage);
		page.setMaxPage(maxPage);

		mav.addObject("shopList", shopList);
		mav.addObject("paging", page);
		mav.setViewName("shopPaging");

		return mav;
	}

//매장 검색 페이징
	public ModelAndView search(HS_NM_BEAN_Paging page, HS_NM_BEAN_Shop shop) {

		mav = new ModelAndView();

		if (page.getPage() == 0) {
			page.setPage(1);
		}
		int limit = 9;
		page.setPage(page.getPage());
		page.setLimit(limit);

		int startRow = (page.getPage() - 1) * limit + 1;
		int endRow = page.getPage() * limit;
		shop.setStartRow(startRow);
		shop.setEndRow(endRow);

		
		shop.setSearchContents("%" + shop.getSearchContents() + "%");

		// 현재 페이지에 보여줘야 하는 글만 DB에서 가져오기
		List<HS_NM_BEAN_Shop> shopList = DAO.shopSearchPaging(shop);

		// 전체 글 갯수 DB에서 가져오기
		int listCount = DAO.shopSearchCount(shop);

		// 페이지 계산
		int maxPage = (int) ((double) listCount / limit + 0.9);
		// 전체갯수를 구해서 페이지수를 구함.

		// 1~10까지 나오고 다음이 나오게함.
		int startPage = (((int) ((double) page.getPage() / 10 + 0.9)) - 1) * 10 + 1;
		int endPage = startPage + 10 - 1;

		if (endPage > maxPage) { // max페이지가 10개가 되지않을떄 10개를 굳이 만들필요가 없어서 만들어줌.
			endPage = maxPage;
		}

		page.setNPorSP_Page(1);
		page.setStartPage(startPage);
		page.setEndPage(endPage);
		page.setMaxPage(maxPage);

		mav.addObject("shopList", shopList);
		mav.addObject("paging", page);
		mav.setViewName("shopPaging");

		return mav;
	}

//매장 상세 조회
	public ModelAndView shopSelect(String pid_Shop, String page) {

		mav = new ModelAndView();

		HS_NM_BEAN_Shop shop_List = DAO.shop_List(pid_Shop);
		List<HS_DN_BEAN_User> shop_DN = DAO.shop_DN(pid_Shop);
		List<String> rank = DAO.rank(pid_Shop);

		mav.addObject("rank", rank);
		mav.addObject("shop_List", shop_List);
		mav.addObject("shop_DN", shop_DN);
		mav.addObject("paging", page);
		mav.setViewName("shopSelect");

		return mav;
	}

// 시술 가격표 수정 (기존 정보 가져오기)
	public ModelAndView menuInsert1(HS_NM_BEAN_Shop shop, String page) {

		mav = new ModelAndView();

		HS_NM_BEAN_Shop shop_List = DAO.shop_MenuList(shop);

		mav.addObject("shop_List", shop_List);
		mav.addObject("paging", page);
		mav.setViewName("menuInsert");

		return mav;
	}

// 시술 가격표 수정,등록
	public ModelAndView menuInsert2(HS_NM_BEAN_Shop shop, String page, HttpServletResponse response)
			throws IOException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		mav = new ModelAndView();
		
		// db저장시 엔터 가능처리
		shop.setMenu_Contents(shop.getMenu_Contents().replace("\r\n", "<br>"));

		// 메뉴 사진 파일 첨부
		MultipartFile menu_Photo_File = shop.getMenu_Photo_File();
		String menu_Photo_Name = menu_Photo_File.getOriginalFilename();
		String savePath1 = "C:\\Users\\gg\\Desktop\\용흠\\HairShop\\src\\main\\webapp\\resources\\menu_photo\\"
				+ menu_Photo_Name;
		if (!menu_Photo_File.isEmpty()) {
			menu_Photo_File.transferTo(new File(savePath1));
		}
		shop.setMenu_Photo_Name(menu_Photo_Name);

		int shop_MenuInsert = DAO.shop_MenuInsert(shop);

		if (shop_MenuInsert == 1) {
			mav.addObject("paging", page);
			mav.setViewName("redirect:/shopSelect?pid_Shop=" + shop.getPid());

		} else {
			out.println("<script>");
			out.println("alert('알수없는 에러가 나타났습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
		return mav;
	}

//시술 가격표 삭제
	public ModelAndView menuDelete(String pid_Shop, String page, HttpServletResponse response) throws IOException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		int menuDelete = DAO.menuDelete(pid_Shop);

		if (menuDelete == 1) {

			mav.setViewName("redirect:/shopSelect?pid_Shop=" + pid_Shop + "&page=" + page);
		} else {
			out.println("<script>");
			out.println("alert('알수없는 에러가 나타났습니다.')");
			out.println("history.back();</script>");
			out.close();
		}

		return mav;
	}

// 매장 수정 (정보가져오기)
	public ModelAndView shopUpdate1(HS_NM_BEAN_Shop shop, String page) {
		mav = new ModelAndView();

		HS_NM_BEAN_Shop shop_List = DAO.shop_List(shop.getPid());

		mav.addObject("shop_List", shop_List);
		mav.addObject("paging", page);
		mav.setViewName("shopUpdate");

		return mav;

	}

// 매장 수정
	public ModelAndView shopUpdate2(HS_NM_BEAN_Shop shop, String page, HttpServletResponse response)
			throws IOException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		
		// db저장시 엔터 가능처리
		shop.setIntroduce(shop.getIntroduce().replace("\r\n", "<br>"));
		shop.setMenu_Contents(shop.getMenu_Contents().replace("\r\n", "<br>"));
		
		// 매장사진 첨부
		MultipartFile Shop_Photo_add[] = new MultipartFile[5];
		String Shop_Photo_Name_add[] = new String[5];

		// 메뉴 사진 파일 첨부
		MultipartFile menu_Photo_File = shop.getMenu_Photo_File();
		String menu_Photo_Name = menu_Photo_File.getOriginalFilename();
		String savePath1 = "C:\\Users\\gg\\Desktop\\용흠\\HairShop\\src\\main\\webapp\\resources\\menu_photo\\"
				+ menu_Photo_Name;

		if (!menu_Photo_File.isEmpty()) {
			menu_Photo_File.transferTo(new File(savePath1));
		}
		shop.setMenu_Photo_Name(menu_Photo_Name);

		// 매장사진 첨부
		for (int i = 0; i <= 4; i++) {
			if (i == 0) {
				Shop_Photo_add[i] = shop.getShop_Photo_add1();
			} else if (i == 1) {
				Shop_Photo_add[i] = shop.getShop_Photo_add2();
			} else if (i == 2) {
				Shop_Photo_add[i] = shop.getShop_Photo_add3();
			} else if (i == 3) {
				Shop_Photo_add[i] = shop.getShop_Photo_add4();
			} else if (i == 4) {
				Shop_Photo_add[i] = shop.getShop_Photo_add5();
			}

			Shop_Photo_Name_add[i] = Shop_Photo_add[i].getOriginalFilename();
			String savePath2 = "C:\\Users\\gg\\Desktop\\용흠\\HairShop\\src\\main\\webapp\\resources\\shop_photo\\"
					+ Shop_Photo_Name_add[i];

			if (!Shop_Photo_add[i].isEmpty()) {
				Shop_Photo_add[i].transferTo(new File(savePath2));
			}

			if (i == 0) {
				shop.setShop_Photo_Name_add1(Shop_Photo_Name_add[i]);
			} else if (i == 1) {
				shop.setShop_Photo_Name_add2(Shop_Photo_Name_add[i]);
			} else if (i == 2) {
				shop.setShop_Photo_Name_add3(Shop_Photo_Name_add[i]);
			} else if (i == 3) {
				shop.setShop_Photo_Name_add4(Shop_Photo_Name_add[i]);
			} else if (i == 4) {
				shop.setShop_Photo_Name_add5(Shop_Photo_Name_add[i]);
			}
		}

		int shopUpdate = DAO.shopUpdate(shop);

		if (shopUpdate == 1) {
			HS_NM_BEAN_Shop shop_List = DAO.shop_List(shop.getPid());
			List<HS_DN_BEAN_User> shop_DN = DAO.shop_DN(shop.getPid());

			mav.addObject("shop_List", shop_List);
			mav.addObject("shop_DN", shop_DN);
			mav.addObject("paging", page);
			mav.setViewName("shopSelect");
		} else {
			out.println("<script>");
			out.println("alert('알수없는 에러가 나타났습니다.')");
			out.println("history.back();</script>");
			out.close();
		}

		return mav;

	}

// 매장 삭제
	public ModelAndView shopDelete(HS_NM_BEAN_Shop shop, String pid_user, String page) {

		mav = new ModelAndView();

		if (pid_user.substring(0, 10).equals("HS_NM_USER")) {

			HS_NM_BEAN_User adrs_street_1 = NM_USER_DAO.NM_userSelect(pid_user);
			DAO.shopDelete(shop);

			mav.setViewName("redirect:/shopPaging?page=" + page + "&adrs_street_1=" + adrs_street_1);

		} else if (pid_user.substring(0, 10).equals("HS_DN_USER")) {

			HS_DN_BEAN_User adrs_street_1 = DN_USER_DAO.DN_userSelect(pid_user);
			DAO.shopDelete(shop);

			mav.setViewName("redirect:/shopPaging?page=" + page + "&adrs_street_1=" + adrs_street_1);
		}
		return mav;
	}

// 매장 등록 신청 목록보기
	public ModelAndView shopApply1() {

		mav = new ModelAndView();

		List<HS_NM_BEAN_Shop> shopApply = DAO.shopApply1();

		mav.addObject("shopApply", shopApply);
		mav.setViewName("shopApply");

		return mav;
	}

// 매장 등록 신청 목록 (승인하기)
	public void shopApply2(String pid_shop, HttpServletResponse response) throws IOException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		mav = new ModelAndView();

		int shopApply = DAO.shopApply2(pid_shop);
		
		if (shopApply == 1) {
			out.println("<script>");
			out.println("alert('승인 되었습니다.')");
			out.println("location.href='shopApply1';</script>");
			out.close();

		} else {
			out.println("<script>");
			out.println("alert('알수없는 에러가 나타났습니다. 승인 되지 않았습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

// 매장 등록 신청 목록 (삭제하기)
	public void shopApplyDelete(String pid_shop, HttpServletResponse response) throws IOException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		mav = new ModelAndView();

		int shopApply = DAO.shopApplyDelete(pid_shop);
		if (shopApply == 1) {
			out.println("<script>");
			out.println("alert('삭제 되었습니다.')");
			out.println("location.href='shopApply1?id=${sessionScope.sessionId}';</script>");
			out.close();

		} else {
			out.println("<script>");
			out.println("alert('알수없는 에러가 나타났습니다. 삭제 되지 않았습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

// 디자이너 소속매장 등록 신청 (목록 보기)
	public ModelAndView shop_Disigner_ApplyJSP() {

		mav = new ModelAndView();

		List<HS_DN_BEAN_User> shop_Disigner_Apply = DAO.shop_Disigner_ApplyJSP();

		mav.addObject("shop_Disigner_Apply", shop_Disigner_Apply);
		mav.setViewName("shop_Disigner_Apply");

		return mav;
	}
	
// 소속매장 등록 신청 목록 (승인하기)
	public void shop_Disigner_Apply(HS_DN_BEAN_User user, HttpServletResponse response) throws IOException {
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		mav = new ModelAndView();
		
		//price DB에서 디자이너 아이디로 매장 pid가져오기
		String belong_Shop = DAO.belong_Shop(user.getId());
		user.setBelong_Shop(belong_Shop);
		//디자이너 DB 승인
		int result = DAO.shop_Disigner_Apply(user);
		//price DB 승인
		int price_Result = DAO.price_Disigner_Apply(user);
		
		if (result == 1 && price_Result == 1) {
			out.println("<script>");
			out.println("alert('승인 되었습니다.')");
			out.println("location.href='shop_Disigner_ApplyJSP?id="+user.getPid()+"';</script>");//세션 id를 pid에 담아왔을 뿐 pid가아님.
			out.close();

		} else {
			out.println("<script>");
			out.println("alert('알수없는 에러가 나타났습니다. 승인 되지 않았습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

// 소속매장 등록 신청 목록 (삭제하기)
	public void shop_Disigner_Apply_Delete(HS_DN_BEAN_User user, String page, HttpServletResponse response) throws IOException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		mav = new ModelAndView();

		//디자이너 DB price_rs값 바꾸기
		int result = DAO.shop_Disigner_Apply_Update(user);
		//price DB정보 삭제
		int result2 = DAO.shop_Disigner_Apply_Delete(user);
		System.out.println(result);
		System.out.println(result2);
		if (result == 1 && result2 == 1) {
			if(page=="page") {
			out.println("<script>");
			out.println("alert('삭제 되었습니다.')");
			out.println("location.href='shopApply1?id="+user.getPid()+"';</script>");//세션 id를 pid에 담아왔을 뿐 pid가아님.
			out.close();
			}
			else {
				out.println("<script>");
				out.println("alert('삭제 되었습니다.')");
				out.println("location.href='mainJSP?id="+user.getPid()+"';</script>");//세션 id를 pid에 담아왔을 뿐 pid가아님.
				out.close();
			}
		} else {
			out.println("<script>");
			out.println("alert('알수없는 에러가 나타났습니다. 삭제 되지 않았습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}
}
