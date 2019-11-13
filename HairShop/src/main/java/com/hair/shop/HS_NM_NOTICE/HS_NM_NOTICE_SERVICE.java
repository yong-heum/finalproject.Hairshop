package com.hair.shop.HS_NM_NOTICE;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.hair.shop.HS_NM_REVIEW.HS_NM_BEAN_Comment;
import com.hair.shop.HS_NM_REVIEW.HS_NM_BEAN_Review;
import com.hair.shop.HS_NM_SHOP.HS_NM_BEAN_Paging;

@Service
public class HS_NM_NOTICE_SERVICE {


	ModelAndView mav;

	@Autowired
	private HS_NM_NOTICE_DAO DAO;
	
	
// noticeBoardJSP로 공지사항 정보가지고 이동
	public ModelAndView noticeBoardJSP(HS_NM_BEAN_Paging page) {

		mav = new ModelAndView();

		if (page.getPage() == 0) {
			page.setPage(1);
		}

		int limit = 10;
		page.setPage(page.getPage());
		page.setLimit(limit);

		int startRow = (page.getPage() - 1) * limit + 1;
		int endRow = page.getPage() * limit;
		page.setStartRow(startRow);
		page.setEndRow(endRow);

		// 현재 페이지에 보여줘야 하는 글만 DB에서 가져오기
		List<HS_NM_BEAN_Notice> noticeList = DAO.noticeList(page);
		
		for(int i=0; i<noticeList.size();i++) {
			if(noticeList.get(i).getTitle().length()>35) {
				noticeList.get(i).setTitle(noticeList.get(i).getTitle().substring(0, 33)+"............");
			}
		}

		// 전체 글 갯수 DB에서 가져오기
		int listCount = DAO.noticeBoardCount();

		// 페이지 계산
		int maxPage = (int) ((double) listCount / limit + 0.9);
		// 전체갯수를 구해서 페이지수를 구함.

		// 1~10까지 나오고 다음이 나오게함.
		int startPage = (((int) ((double) page.getPage() / 10 + 0.9)) - 1) * 10 + 1;
		int endPage = startPage + 10 - 1;

		if (endPage > maxPage) { // max페이지가 10개가 되지않을떄 10개를 굳이 만들필요가 없어서 만들어줌.
			endPage = maxPage;
		}
		
		
		page.setStartPage(startPage);
		page.setEndPage(endPage);
		page.setMaxPage(maxPage);

		mav.addObject("noticeList", noticeList);
		mav.addObject("paging", page);
		mav.setViewName("noticeBoard");

		return mav;
	
	}

// 공지사항 글 올리기
	public void noticeInsert(HS_NM_BEAN_Notice notice, String page, HttpServletResponse response) throws IOException {


		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		int result = DAO.noticeInsert(notice);

		if (result == 1) {
			out.println("<script>");
			out.println("alert('등록 되었습니다.')");
			out.println("location.href='noticeBoardJSP?page=0';</script>");
			out.close();
		} else {
			out.println("<script>");
			out.println("alert('알수 없는 오류가 나타나 글 등록에 실패 하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}		
	}

	
// 조회수 올리기 (상세보기에 같이 넣어두면 새로고침 할 때 마다 조회수가 증가되는 것 방지)
	public ModelAndView noticeHitUp(int boardNum, String page) {

		mav = new ModelAndView();

		DAO.noticeHitUp(boardNum);
		mav.setViewName("redirect:/noticeSelectJSP?boardNum=" + boardNum + "&page=" + page);

		return mav;
	}

// 공지사항 게시판 상세정보 조회
	public ModelAndView noticeSelectJSP(int boardNum, String page) {
		
		mav = new ModelAndView();
		
		HS_NM_BEAN_Notice noticeSelect = DAO.noticeSelect(boardNum);

		mav.addObject("noticeSelect", noticeSelect);
		mav.addObject("paging", page);
		mav.setViewName("noticeSelect");

		return mav;
	}

// 공지사항 삭제
	public void noticeDelete(int boardNum, HS_NM_BEAN_Paging page, HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		
		int result = DAO.noticeDelete(boardNum);
		
		if(result==1) {
			out.println("<script>");
			out.println("alert('삭제 되었습니다.')");
			out.println("location.href='noticeBoardJSP?page=0';</script>");
			out.close();
		} else {
			out.println("<script>");
			out.println("alert('알수 없는 오류가 나타나 글 삭제에 실패 하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}	
		
	}

// noticeUpdateJSP로 정보가지고 이동하기
	public ModelAndView noticeUpdateJSP(int boardNum, int page) {

		mav = new ModelAndView();
		
		HS_NM_BEAN_Notice noticeSelect = DAO.noticeSelect(boardNum);
		
		mav.addObject("noticeSelect", noticeSelect);
		mav.addObject("boardNum", boardNum);
		mav.addObject("paging", page);
		mav.setViewName("noticeUpdate");

		return mav;
	}

// 공지사항 수정
	public void noticeUpdate(HS_NM_BEAN_Notice notice, int page, HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		int result = DAO.noticeUpdate(notice);
		
		if(result==1) {
			out.println("<script>");
			out.println("alert('수정 되었습니다.')");
			out.println("location.href='noticeSelectJSP?boardNum="+notice.getBoardNum()+"&page="+page+"';</script>");
			out.close();
		}else {
			out.println("<script>");
			out.println("alert('알수 없는 오류가 나타나 글 수정에 실패 하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

}
