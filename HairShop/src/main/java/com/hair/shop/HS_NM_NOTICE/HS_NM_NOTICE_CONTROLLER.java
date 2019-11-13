package com.hair.shop.HS_NM_NOTICE;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hair.shop.HS_NM_REVIEW.HS_NM_BEAN_Review;
import com.hair.shop.HS_NM_SHOP.HS_NM_BEAN_Paging;

@Controller
public class HS_NM_NOTICE_CONTROLLER {

	private ModelAndView mav;

	@Autowired
	private HS_NM_NOTICE_SERVICE service;

// noticeBoardJSP로 공지사항 정보가지고 이동
	@RequestMapping(value = "/noticeBoardJSP")
	public ModelAndView noticeBoardJSP(@ModelAttribute HS_NM_BEAN_Paging page) {

		mav = service.noticeBoardJSP(page);
		return mav;
	}

// noticInsertJSP로 이동
	@RequestMapping(value = "/noticeInsertJSP")
	public String noticeInsertJSP(@ModelAttribute HS_NM_BEAN_Paging page) {

		return "noticeInsert";
	}

// 공지사항 글 올리기
	@RequestMapping(value = "/noticeInsert")
	public void noticeInsert(@ModelAttribute HS_NM_BEAN_Notice notice, String page, HttpServletResponse response)
			throws IOException {

		service.noticeInsert(notice, page, response);
	}

// 조회수 올리기 (상세보기에 같이 넣어두면 새로고침 할 때 마다 조회수가 증가되는 것 방지)
	@RequestMapping(value = "/noticeHitUp")
	public ModelAndView noticeHitUp(@RequestParam("boardNum") int boardNum, @RequestParam("page") String page) {

		mav = service.noticeHitUp(boardNum, page);
		return mav;
	}

// 공지사항 게시판 상세정보 조회
	@RequestMapping(value = "/noticeSelectJSP")
	public ModelAndView noticeSelectJSP(@RequestParam("boardNum") int boardNum, @RequestParam("page") String page) {

		mav = service.noticeSelectJSP(boardNum, page);
		return mav;
	}

// 공지사항 삭제 
	@RequestMapping(value = "/noticeDelete")
	public void noticeDelete(int boardNum, HS_NM_BEAN_Paging page, HttpServletResponse response) throws IOException {

		service.noticeDelete(boardNum, page, response);
	}

// noticeUpdateJSP로 정보가지고 이동하기
	@RequestMapping(value = "/noticeUpdateJSP")
	public ModelAndView noticeUpdateJSP(int boardNum, int page){

		mav = service.noticeUpdateJSP(boardNum, page);
		return mav;
	}
	
// 공지사항 수정
	@RequestMapping(value = "/noticeUpdate")
	public void noticeUpdate(HS_NM_BEAN_Notice notice, int page, HttpServletResponse response) throws IOException {

		service.noticeUpdate(notice, page, response);
	}
}
