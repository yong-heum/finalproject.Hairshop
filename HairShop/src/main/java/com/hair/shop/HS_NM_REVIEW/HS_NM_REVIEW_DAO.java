package com.hair.shop.HS_NM_REVIEW;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hair.shop.HS_DN_USER.HS_DN_BEAN_User;
import com.hair.shop.HS_NM_SHOP.HS_NM_BEAN_Paging;
import com.hair.shop.HS_NM_SHOP.HS_NM_BEAN_Shop;

@Repository
public class HS_NM_REVIEW_DAO {

	@Autowired
	private SqlSessionTemplate sql;

//리뷰 등록 할 때 매장 검색 (ajax) 불러오기
	public List<String> shopName_Call(String shopName) {
		return sql.selectList("review.shopName_Call", shopName);
	}

//리뷰 등록 할 때 디자이너 검색 (ajax) 불러오기
	public List<HS_DN_BEAN_User> shopDisigner_Call(String shopName) {
		return sql.selectList("review.shopDisigner_Call", shopName);
	}

// 리뷰게시판 게시글 올리기
	public int reviewInsert(HS_NM_BEAN_Review reiview) {
		return sql.insert("review.reviewInsert", reiview);
	}

// 리뷰게시판 게시글 상세정보 불러오기(글 올렸을 때)
	public HS_NM_BEAN_Review reviewInsertSelect(HS_NM_BEAN_Review reiview) {
		return sql.selectOne("review.reviewInsertSelect", reiview);
	}

// 리뷰 게시판 정보 불러오기 (페이징)
	public List<HS_NM_BEAN_Review> reviewList(HS_NM_BEAN_Paging page) {
		return sql.selectList("review.reviewList", page);
	}

// 리뷰 게시판 정보 갯수 불러오기 (페이징)
	public int reviewBoardCount() {
		return sql.selectOne("review.reviewBoardCount");
	}

// 리뷰게시판 상세정보 조회
	public HS_NM_BEAN_Review reviewSelect(int boardNum) {
		return sql.selectOne("review.reviewSelect", boardNum);
	}

// 조회수 증가
	public void reviewHitUp(int boardNum) {
		sql.update("review.reviewHitUp", boardNum);
	}

// 리뷰 게시글 수정
	public int reviewUpdate(HS_NM_BEAN_Review reiview) {
		return sql.update("review.reviewUpdate", reiview);
	}

// 리뷰 게시글 삭제
	public int reviewDelete(int boardNum) {
		return sql.delete("review.reviewDelete", boardNum);
	}

// 리뷰 댓글 달기
	public int reviewComment(HS_NM_BEAN_Comment comment) {
		return sql.insert("review.reviewComment", comment);
	}

// 리뷰 댓글 불러오기
	public List<HS_NM_BEAN_Comment> CommentList(int boardNum) {
		return sql.selectList("review.CommentList", boardNum);
	}

// 리뷰 댓글 삭제
	public int commentDelete(int commentNum) {
		return sql.delete("review.commentDelete", commentNum);
	}

// 리뷰 댓글의 답변 올리기 
	public int reviewComment_Second(HS_NM_BEAN_Comment comment) {
		return sql.insert("review.reviewComment_Second", comment);
	}

// 리뷰 댓글의 답변 불러오기 
	public List<HS_NM_BEAN_Comment> comment_ScondList(int boardNum) {
		return sql.selectList("review.comment_ScondList", boardNum);
	}

// 리뷰 댓글의  답글 삭제
	public int comment_SecondDelete(int commentNum_Second) {
		return sql.delete("review.comment_SecondDelete", commentNum_Second);
	}

// 리뷰 댓글 카운트
	public List<HS_NM_BEAN_Comment> comment_ScondCount(int boardNum) {
		return sql.selectList("review.comment_ScondCount", boardNum);
	}

// 아이디로 매장 이름 불러오기 
	public String shopName(String id) {
		return sql.selectOne("review.shopName", id);
	}

// 로그인한 디자이너의 포인트 지급 가능한 리뷰정보 불러오기 
	public List<HS_NM_BEAN_Review> review_PointJSP(HS_DN_BEAN_User DN_User) {
		return sql.selectList("review.review_PointJSP", DN_User);
	}

// DN_user 포인트지급 횟수(실제 방문후 시술완료 했는지)가 잇는지확인 
	public int DN_POINT_COUNT(String pid) {
		return sql.selectOne("review.DN_POINT_COUNT", pid);
	}

// NM_user 포인트지급 횟수(실제 방문후 시술완료 했는지)가 잇는지확인
	public int NM_POINT_COUNT(String pid) {
		return sql.selectOne("review.NM_POINT_COUNT", pid);
	}

// DN_user 승인하기 클릭시 포인트 지급 
	public void DN_POINT_Pay(String pid) {
		sql.update("review.DN_POINT_Pay", pid);
	}

// NM_user 승인하기 클릭시 포인트 지급
	public void NM_POINT_Pay(String pid) {
		sql.update("review.NM_POINT_Pay", pid);
	}

//게시물 포인트 지급완료로 바꾸기
	public int review_Point_Pay(int boardNum) {
		return sql.update("review.review_Point_Pay", boardNum);
	}

//댓글 카운트
	public List<Integer> commentCount(HS_NM_BEAN_Paging page) {
		return sql.selectList("review.commentCount", page);
	}

}
