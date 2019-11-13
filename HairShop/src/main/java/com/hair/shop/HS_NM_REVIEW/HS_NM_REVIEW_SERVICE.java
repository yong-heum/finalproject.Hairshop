package com.hair.shop.HS_NM_REVIEW;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.hair.shop.HS_DN_USER.HS_DN_BEAN_User;
import com.hair.shop.HS_DN_USER.HS_DN_USER_DAO;
import com.hair.shop.HS_NM_SHOP.HS_NM_BEAN_Paging;
import com.hair.shop.HS_NM_SHOP.HS_NM_BEAN_Shop;
import com.hair.shop.HS_NM_TICETIGN.HS_NM_TCKETING_DAO;
import com.hair.shop.HS_NM_USER.HS_NM_BEAN_User;
import com.hair.shop.HS_NM_USER.HS_NM_USER_DAO;

@Service
public class HS_NM_REVIEW_SERVICE {

	ModelAndView mav;

	@Autowired
	private HS_NM_REVIEW_DAO DAO;
	@Autowired
	private HS_NM_USER_DAO NM_USER_DAO;
	@Autowired
	private HS_DN_USER_DAO DN_USER_DAO;
	@Autowired
	private HS_NM_TCKETING_DAO TCKETING_DAO;
	
	
// 회원 상세 정보 불러오기
	public ModelAndView reviewInsertJSP(String id, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		HS_NM_BEAN_User userSelect = NM_USER_DAO.NM_userSelect(id);

		if (userSelect != null) {
			mav.addObject("userSelect", userSelect);
			mav.setViewName("reviewInsert");

		} else {
			out.println("<script>");
			out.println("alert('회원정보 불러오기 실패.')");
			out.println("history.back();</script>");
			out.close();

		}
		return mav;
	}

// 리뷰 등록 할 때 매장 검색 (ajax) 불러오기
	public List<String> shopName_Call(String shopName) {

		shopName = "%" + shopName + "%";
		List<String> result = DAO.shopName_Call(shopName);
		return result;
	}

// 리뷰 등록 할 때 디자이너 검색 (ajax) 불러오기
	public List<HS_DN_BEAN_User> shopDisigner_Call(String shopName) {

		shopName = "%" + shopName + "%";
		List<HS_DN_BEAN_User> result = DAO.shopDisigner_Call(shopName);
		return result;
	}

// 리뷰게시판 게시글 올리기
	public ModelAndView reviewInsert(HS_NM_BEAN_Review reiview, String page, HttpServletResponse response)
			throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		int result = DAO.reviewInsert(reiview);
		HS_NM_BEAN_Review reviewSelect = DAO.reviewInsertSelect(reiview);

		if (result == 1) {
			mav.addObject("paging", page);
			mav.addObject("reviewSelect", reviewSelect);
			mav.setViewName("reviewSelect");
		} else {
			out.println("<script>");
			out.println("alert('알수 없는 오류가 나타나 글등록에 실패 하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}

		return mav;
	}

// 리뷰게시판 정보 불러오기 페이징
	public ModelAndView reviewBoard(HS_NM_BEAN_Paging page) {

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
		List<HS_NM_BEAN_Review> reviewList = DAO.reviewList(page);
		// 댓글 카운트
		List<Integer> commentCount = DAO.commentCount(page);
		
		for(int i=0; i<commentCount.size();i++) {
			reviewList.get(i).setCommentCount(commentCount.get(i));
		}
		for(int i=0; i<reviewList.size();i++) {
			if(reviewList.get(i).getTitle().length()>29) {
				reviewList.get(i).setTitle(reviewList.get(i).getTitle().substring(0, 28)+"............");
			}
		}
		// 전체 글 갯수 DB에서 가져오기
		int listCount = DAO.reviewBoardCount();

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

		mav.addObject("reviewList", reviewList);
		mav.addObject("paging", page);
		mav.setViewName("reviewBoard");

		return mav;
	}

// 리뷰 상세정보 조회,댓글 불러오기, 답변 카운팅
	public ModelAndView reviewSelect(int boardNum, String page) {

		mav = new ModelAndView();

		HS_NM_BEAN_Review reviewSelect = DAO.reviewSelect(boardNum);
		List<HS_NM_BEAN_Comment> commentList = DAO.CommentList(boardNum);
		List<HS_NM_BEAN_Comment> comment_ScondList = DAO.comment_ScondList(boardNum);
		List<HS_NM_BEAN_Comment> comment_ScondCount = DAO.comment_ScondCount(boardNum);

		for (int i = 0; i < commentList.size(); i++) {

			String id = commentList.get(i).getId();
			String result = id.substring(0, id.length() - 4);
			commentList.get(i).setHideId(result + "****");
		}

		for (int i = 0; i < comment_ScondList.size(); i++) {

			String id = comment_ScondList.get(i).getId();
			String result = id.substring(0, id.length() - 4);
			comment_ScondList.get(i).setHideId(result + "****");
		}

		mav.addObject("comment_ScondCount", comment_ScondCount);
		mav.addObject("comment_ScondList", comment_ScondList);
		mav.addObject("commentList", commentList);
		mav.addObject("reviewSelect", reviewSelect);
		mav.addObject("paging", page);
		mav.setViewName("reviewSelect");

		return mav;
	}

// 조회수 올리기 (상세보기에 같이 넣어두면 새로고침 할 때 마다 조회수가 증가되는 것 방지)
	public ModelAndView reviewHitUp(int boardNum, String page) {

		mav = new ModelAndView();

		DAO.reviewHitUp(boardNum);
		mav.setViewName("redirect:/reviewSelect?boardNum=" + boardNum + "&page=" + page);

		return mav;
	}

// reviewUpdate.JSP로 이동 (수정하기 정보불러오기)
	public ModelAndView reviewUpdate1(HS_NM_BEAN_Review review, HS_NM_BEAN_Paging page, HttpServletResponse response)
			throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();
		HS_NM_BEAN_User NM_loginResult = NM_USER_DAO.userLogin(review.getId());
		HS_DN_BEAN_User DN_loginResult = DN_USER_DAO.DN_userLogin(review.getId());
		BCryptPasswordEncoder passEncoder = new BCryptPasswordEncoder();

		if (DN_loginResult != null) {

			boolean passMatch1 = passEncoder.matches(review.getPasswordCheck(), DN_loginResult.getPassword());

			if (passMatch1 == true) {

				HS_NM_BEAN_Review reviewSelect = DAO.reviewSelect(review.getBoardNum());

				mav.addObject("pageing", page.getPage());
				mav.addObject("reviewSelect", reviewSelect);
				mav.setViewName("reviewUpdate");

			} else {
				out.println("<script>");
				out.println("alert('아이디 또는 비밀번호를 확인하세요.')");
				out.println("history.back();</script>");
				out.close();
			}
		} else if (NM_loginResult != null) {

			boolean passMatch1 = passEncoder.matches(review.getPasswordCheck(), NM_loginResult.getPassword());

			if (passMatch1 == true) {

				HS_NM_BEAN_Review reviewSelect = DAO.reviewSelect(review.getBoardNum());

				mav.addObject("pageing", page.getPage());
				mav.addObject("reviewSelect", reviewSelect);
				mav.setViewName("reviewUpdate");

			} else {
				out.println("<script>");
				out.println("alert('아이디 또는 비밀번호를 확인하세요.')");
				out.println("history.back();</script>");
				out.close();
			}
		}
		return mav;
	}

// 리뷰 수정
	public ModelAndView reviewUpdate2(HS_NM_BEAN_Review reiview, String page, HttpServletResponse response)
			throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		int result = DAO.reviewUpdate(reiview);
		HS_NM_BEAN_Review reviewSelect = DAO.reviewSelect(reiview.getBoardNum());

		if (result == 1) {
			mav.addObject("paging", page);
			mav.addObject("reviewSelect", reviewSelect);
			mav.setViewName("reviewSelect");
		} else {
			out.println("<script>");
			out.println("alert('알수 없는 오류가 나타나 글수정에 실패 하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}

		return mav;

	}

// 리뷰 삭제
	public ModelAndView reviewDelete(HS_NM_BEAN_Review review, HS_NM_BEAN_Paging page, HttpServletResponse response)
			throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		if (page.getPage() == 0) {
			page.setPage(1);
		}

		int limit = 3;
		page.setPage(page.getPage());
		page.setLimit(limit);

		int startRow = (page.getPage() - 1) * limit + 1;
		int endRow = page.getPage() * limit;
		page.setStartRow(startRow);
		page.setEndRow(endRow);

		// 현재 페이지에 보여줘야 하는 글만 DB에서 가져오기
		List<HS_NM_BEAN_Review> reviewList = DAO.reviewList(page);

		// 전체 글 갯수 DB에서 가져오기
		int listCount = DAO.reviewBoardCount();

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

		int result = DAO.reviewDelete(review.getBoardNum());

		HS_NM_BEAN_User NM_loginResult = NM_USER_DAO.userLogin(review.getId());
		HS_DN_BEAN_User DN_loginResult = DN_USER_DAO.DN_userLogin(review.getId());
		BCryptPasswordEncoder passEncoder = new BCryptPasswordEncoder();

		if (DN_loginResult != null) {

			boolean passMatch1 = passEncoder.matches(review.getPasswordCheck(), DN_loginResult.getPassword());

			if (passMatch1 == true && result == 1) {

				mav.addObject("reviewList", reviewList);
				mav.addObject("paging", page);
				mav.setViewName("reviewBoard");

			} else if (passMatch1 == false) {
				out.println("<script>");
				out.println("alert('아이디 또는 비밀번호를 확인하세요.')");
				out.println("history.back();</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('알수 없는 오류가 나타나 글 삭제를 실패 하였습니다.')");
				out.println("history.back();</script>");
				out.close();
			}
		} else if (NM_loginResult != null) {

			boolean passMatch1 = passEncoder.matches(review.getPasswordCheck(), NM_loginResult.getPassword());

			if (passMatch1 == true && result == 1) {

				mav.addObject("reviewList", reviewList);
				mav.addObject("paging", page);
				mav.setViewName("reviewBoard");

			} else if (passMatch1 == false) {
				out.println("<script>");
				out.println("alert('아이디 또는 비밀번호를 확인하세요.')");
				out.println("history.back();</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('알수 없는 오류가 나타나 글삭제에 실패 하였습니다.')");
				out.println("history.back();</script>");
				out.close();
			}

		}
		return mav;
	}

// 리뷰 댓글 달기
	public void reviewComment(HS_NM_BEAN_Comment comment, String page, HttpServletResponse response)
			throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		comment.setContents(comment.getContents().replace("\r\n", "<br>"));

		int result = DAO.reviewComment(comment);

		if (result == 1) {
			out.println("<script>");
			out.println("alert('댓글 작성이 완료 되었습니다.')");
			out.println("location.href='reviewSelect?boardNum=" + comment.getBoardNum() + "&page=" + page + "'");
			out.println("</script>");
			out.close();

		} else {
			out.println("<script>");
			out.println("alert('알수 없는 오류가 나타나 댓글쓰기에 실패 하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

// 리뷰 댓글 삭제
	public void commentDelete(int commentNum, String page, int boardNum, HttpServletResponse response)
			throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		int result = DAO.commentDelete(commentNum);

		if (result == 1) {
			out.println("<script>");
			out.println("alert('댓글 삭제가 완료 되었습니다.')");
			out.println("location.href='reviewSelect?boardNum=" + boardNum + "&page=" + page + "'");
			out.println("</script>");
			out.close();

		} else {
			out.println("<script>");
			out.println("alert('알수 없는 오류가 나타나 댓글삭제에 실패 하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

// 리뷰 댓글의 답변 올리기 
	public void reviewComment_Second(HS_NM_BEAN_Comment comment, String page, HttpServletResponse response)
			throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		comment.setContents(comment.getContents().replace("\r\n", "<br>"));

		int result = DAO.reviewComment_Second(comment);

		if (result == 1) {
			out.println("<script>");
			out.println("alert('댓글 작성이 완료 되었습니다.')");
			out.println("location.href='reviewSelect?boardNum=" + comment.getBoardNum() + "&page=" + page + "'");
			out.println("</script>");
			out.close();

		} else {
			out.println("<script>");
			out.println("alert('알수 없는 오류가 나타나 댓글쓰기에 실패 하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

// 리뷰 댓글의 답변 삭제
	public void comment_SecondDelete(int commentNum_Second, String page, int boardNum, HttpServletResponse response)
			throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		int result = DAO.comment_SecondDelete(commentNum_Second);

		if (result == 1) {
			out.println("<script>");
			out.println("alert('답글 삭제가 완료 되었습니다.')");
			out.println("location.href='reviewSelect?boardNum=" + boardNum + "&page=" + page + "'");
			out.println("</script>");
			out.close();

		} else {
			out.println("<script>");
			out.println("alert('알수 없는 오류가 나타나 댓글삭제에 실패 하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}

// 로그인한 디자이너의 포인트 지급 가능한 리뷰정보를 가지고 review_PointJSP로 이동 
	public ModelAndView review_PointJSP(String id, String name, HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();
		
		//아이디로 매장 이름 불러오기
		String belong_Shop = DAO.shopName(id);
		
		if (belong_Shop == null) {
			out.println("<script>");
			out.println("alert('소속되어있는 매장이 없습니다.')");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		HS_DN_BEAN_User DN_User = new HS_DN_BEAN_User();
		
		DN_User.setBelong_Shop(belong_Shop);
		DN_User.setName(name);
		//로그인한 디자이너의 포인트 지급 가능한 리뷰정보 불러오기
		List<HS_NM_BEAN_Review> result = DAO.review_PointJSP(DN_User);
		
		mav.addObject("reviewList",result);
		mav.setViewName("review_Point");
		return mav;
	}

// 리뷰 확인후 포인트 승인 할 때  상세보기 review_PointSelect
	public ModelAndView review_PointSelect(int boardNum) {
	
		mav = new ModelAndView();
		HS_NM_BEAN_Review reviewSelect = DAO.reviewSelect(boardNum);
		
		mav.addObject("reviewSelect", reviewSelect);
		mav.setViewName("review_PointSelect");

		return mav;
	}

//승인하기 클릭시 포인트 지급,포인트지급 횟수(실제 방문후 시술완료 했는지)가 잇는지확인,게시물 포인트 지급 완료로 바꾸기 
	public void pointApply(int boardNum, String customer_id, 
			String disigner_id, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		HS_DN_BEAN_User DN_User = new HS_DN_BEAN_User();
		
		//디자이너 정보 가져오기
		DN_User=DN_USER_DAO.DN_userLogin(disigner_id);
		
		//고객의 pid가져오기
		String pid = TCKETING_DAO.disigner_pid(customer_id);
		
		if (pid.substring(0, 10).equals("HS_DN_USER")) {
		
			int point_Count=DAO.DN_POINT_COUNT(pid);
			
			if(point_Count>0) {
				//포인트 지급,포인트 지급 횟수 down
				DAO.DN_POINT_Pay(pid);
				//게시물 포인트 지급완료로 바꾸기
				DAO.review_Point_Pay(boardNum);
				
				out.println("<script>");
				out.println("alert('승인이 완료되어 포인트가 지급 되었습니다.')");
				out.println("location.href='review_PointJSP?id="+DN_User.getId()+"&name="+DN_User.getName()+"';</script>");
				out.close();
				
			}else {
				out.println("<script>");
				out.println("alert('시술 완료가 되어있지 않은 고객입니다.')");
				out.println("history.back();</script>");
				out.close();
			}
		}
		else if(pid.substring(0, 10).equals("HS_NM_USER")){
			
			int point_Count=DAO.NM_POINT_COUNT(pid);
			
			if(point_Count>0) {
				//포인트 지급,포인트 지급 횟수 down
				DAO.NM_POINT_Pay(pid);
				//게시물 포인트 지급완료로 바꾸기
				int result = DAO.review_Point_Pay(boardNum);
			}else {
				out.println("<script>");
				out.println("alert('시술 완료가 되어있지 않은 고객입니다.')");
				out.println("history.back();</script>");
				out.close();
			}
		}else {
			out.println("<script>");
			out.println("alert('알수 없는 오류가 나타나 승인에 실패 하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
		
	}

//포인트지급 목록에서 지우기 
	public void review_PointRS_UP(int boardNum, String disigner_id, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		HS_DN_BEAN_User DN_User = new HS_DN_BEAN_User();
		
		//디자이너 정보 가져오기
		DN_User=DN_USER_DAO.DN_userLogin(disigner_id);
		
		int result = DAO.review_Point_Pay(boardNum);
		
		if(result==1) {
			out.println("<script>");
			out.println("alert('완료 했습니다.')");
			out.println("location.href='review_PointJSP?id="+DN_User.getId()+"&name="+DN_User.getName()+"';</script>");
			out.close();
		}
		else {
			out.println("<script>");
			out.println("alert('알수 없는 오류가 나타나 실패 하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
	}
}
