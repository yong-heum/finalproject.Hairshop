package com.hair.shop.HS_NM_REVIEW;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hair.shop.HS_DN_USER.HS_DN_BEAN_User;
import com.hair.shop.HS_NM_SHOP.HS_NM_BEAN_Paging;

@Controller
public class HS_NM_REVIEW_CONTROLLER {

	private ModelAndView mav;

	@Autowired
	private HS_NM_REVIEW_SERVICE service;

	@RequestMapping(value = "/reviewInsertJSP")
	public ModelAndView reviewInsertJSP(@RequestParam("id") String id, HttpServletResponse response)
			throws IOException {

		mav = service.reviewInsertJSP(id, response);
		return mav;

	}

// 리뷰 등록 할 때 매장 검색 (ajax) 불러오기
	@RequestMapping(value = "/shopName_Call")
	public @ResponseBody List<String> shopName_Call(@RequestParam("shopName") String shopName) {

		List<String> result = service.shopName_Call(shopName);
		return result;

	}

// 리뷰 등록 할 때 디자이너 검색 (ajax) 디자이너 이름, 매장 PID 불러오기
	@RequestMapping(value = "/shopDisigner_Call")
	public @ResponseBody List<HS_DN_BEAN_User> shopDisigner_Call(@RequestParam("shopName") String shopName) {

		List<HS_DN_BEAN_User> result = service.shopDisigner_Call(shopName);
		return result;

	}

// 리뷰게시판 게시글 올리기
	@RequestMapping(value = "/reviewInsert")
	public ModelAndView reviewInsert(@ModelAttribute HS_NM_BEAN_Review reiview, String page,
			HttpServletResponse response) throws IOException {

		mav = service.reviewInsert(reiview, page, response);
		return mav;

	}

// 리뷰게시판 정보불러오기 페이징
	@RequestMapping(value = "/reviewBoard")
	public ModelAndView reviewBoard(@ModelAttribute HS_NM_BEAN_Paging page) {

		mav = service.reviewBoard(page);
		return mav;

	}

// 리뷰게시판 상세정보 조회(댓글 불러오기, 답변 카운팅)
	@RequestMapping(value = "/reviewSelect")
	public ModelAndView reviewSelect(@RequestParam("boardNum") int boardNum, @RequestParam("page") String page) {

		mav = service.reviewSelect(boardNum, page);
		return mav;

	}

// 조회수 올리기 (상세보기에 같이 넣어두면 새로고침 할 때 마다 조회수가 증가되는 것 방지)
	@RequestMapping(value = "/reviewHitUp")
	public ModelAndView reviewHitUp(@RequestParam("boardNum") int boardNum, @RequestParam("page") String page) {

		mav = service.reviewHitUp(boardNum, page);
		return mav;
	}

// reviewUpdate.JSP로 이동 (수정하기 정보불러오기), 리뷰 삭제
	@RequestMapping(value = "/DU_Check")
	public ModelAndView DU_Check(HS_NM_BEAN_Review review, HS_NM_BEAN_Paging page, HttpServletResponse response)
			throws IOException {

		if (review.getCheck().equals("1")) {
			mav = service.reviewUpdate1(review, page, response);
		} else {
			mav = service.reviewDelete(review, page, response);

		}
		return mav;
	}

// 리뷰 수정하기
	@RequestMapping(value = "/reviewUpdate2")
	public ModelAndView reviewUpdate2(HS_NM_BEAN_Review reiview, @RequestParam("page") String page,
			HttpServletResponse response) throws IOException {

		mav = service.reviewUpdate2(reiview, page, response);
		return mav;
	}

// 리뷰 댓글 달기
	@RequestMapping(value = "/reviewComment")
	public void reviewComment(HS_NM_BEAN_Comment comment, @RequestParam("page") String page,
			HttpServletResponse response) throws IOException {

		service.reviewComment(comment, page, response);
	}

// 리뷰 댓글 삭제 
	@RequestMapping(value = "/commentDelete")
	public void commentDelete(@RequestParam("commentNum") int commentNum, @RequestParam("page") String page,
			@RequestParam("boardNum") int boardNum, HttpServletResponse response) throws IOException {
		service.commentDelete(commentNum, page, boardNum, response);
	}

// 리뷰 댓글의 답변 올리기 
	@RequestMapping(value = "/reviewComment_Second")
	public void reviewComment_Second(HS_NM_BEAN_Comment comment, @RequestParam("page") String page,
			HttpServletResponse response) throws IOException {
		service.reviewComment_Second(comment, page, response);
	}

// 리뷰 댓글 삭제 
	@RequestMapping(value = "/comment_SecondDelete")
	public void comment_SecondDelete(@RequestParam("commentNum_Second") int commentNum_Second,
			@RequestParam("page") String page, @RequestParam("boardNum") int boardNum, HttpServletResponse response)
			throws IOException {
		service.comment_SecondDelete(commentNum_Second, page, boardNum, response);
	}

// 로그인한 디자이너의 포인트 지급 가능한 리뷰정보를 가지고 review_PointJSP로 이동 
	@RequestMapping(value = "/review_PointJSP")
	public ModelAndView review_PointJSP(@RequestParam("id") String id, @RequestParam("name") String name , HttpServletResponse response) throws IOException {
		mav = service.review_PointJSP(id, name, response);
		return mav;
	}
	
// 리뷰 확인후 포인트 승인 할 때  상세보기 review_PointSelect
	@RequestMapping(value = "/review_PointSelect")
	public ModelAndView review_PointSelect(@RequestParam("boardNum") int boardNum) {
		
		mav = service.review_PointSelect(boardNum);
		return mav;
	}
	
//승인하기 클릭시 포인트 지급,포인트지급 횟수(실제 방문후 시술완료 했는지)가 잇는지확인,게시물 포인트 지급 완료로 바꾸기 
	@RequestMapping(value = "/pointApply")
	public void pointApply(@RequestParam("boardNum") int boardNum, @RequestParam("customer_id") String customer_id, 
			@RequestParam("disigner_id") String disigner_id, HttpServletResponse response)
			throws IOException  {
		
		service.pointApply(boardNum, customer_id, disigner_id, response );
	}
	
//포인트지급 목록에서 지우기 
	@RequestMapping(value = "/review_PointRS_UP")
	public void review_PointRS_UP(@RequestParam("boardNum") int boardNum, @RequestParam("disigner_id") String disigner_id, 
			HttpServletResponse response)
			throws IOException  {
		
		service.review_PointRS_UP(boardNum, disigner_id, response );
	}
}
