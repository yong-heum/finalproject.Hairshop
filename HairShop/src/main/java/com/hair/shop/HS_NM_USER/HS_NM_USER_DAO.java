package com.hair.shop.HS_NM_USER;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hair.shop.HS_NM_NOTICE.HS_NM_BEAN_Notice;
import com.hair.shop.HS_NM_REVIEW.HS_NM_BEAN_Review;
import com.hair.shop.HS_NM_SHOP.HS_NM_BEAN_Shop;
import com.hair.shop.HS_NM_USER.HS_NM_BEAN_User;

@Repository
public class HS_NM_USER_DAO {
	
	@Autowired
	private SqlSessionTemplate sql;

// 회원가입 처리
	public int userJoin(HS_NM_BEAN_User user) {
		return sql.insert("NM_user.NM_userJoin", user); 
	}

// 회원가입 하면서 유니크USER테이블에 같이 저장
	public int uniqueUserJoin(HS_NM_BEAN_User user) {
		return sql.insert("NM_user.NM_uniqueUserJoin", user);
	}
	
// 중복확인 처리
	public String idOverlap(String id) {
		return sql.selectOne("NM_user.NM_idOverlap", id);
	}

// 회원가입 후에  메일인증 눌렀을 때
	public int joinsenMail(String pid) {
		return sql.update("NM_user.NM_joinsenMail", pid);
	}

// 이메일 인증시에 인증이 되어있나 확인
	public HS_NM_BEAN_User userLoginCheck(String pid) {
		return sql.selectOne("NM_user.NM_userLoginCheck", pid);
	}
	
// 로그인 처리
	public HS_NM_BEAN_User userLogin(String id) {
		return sql.selectOne("NM_user.NM_userLogin", id);
	}

// 회원 상세 조회 불러오기(NM)
	public HS_NM_BEAN_User NM_userSelect(String id) {
		return sql.selectOne("NM_user.NM_userSelect",id);
	}

// 회원정보 수정(NM)
	public int  NM_userUpdate(HS_NM_BEAN_User user) {
		return sql.update("NM_user.NM_userUpdate",user);
	}
	
// 회원수정 고유정보 추가
	public int NM_uniqueUserInsert(HS_NM_BEAN_User user) {
		return sql.insert("NM_user.NM_uniqueUserInsert", user);
	}

//회원탈퇴(NM)
	public int NM_userDelete(String pid) {
		return sql.delete("NM_user.NM_userDelete",pid);
	}

//회원삭제 고유정보 추가
	public int NM_uniqueUserDelete(String pid) {
		return sql.insert("NM_user.NM_uniqueUserDelete",pid);
	}
	
//비밀번호 변경(NM)
	public int NM_userPasswordUpdate(HS_NM_BEAN_User user) {
		return sql.update("NM_user.NM_userPasswordUpdate",user);
	}

//아이디찾기(NM)
	public HS_NM_BEAN_User NM_idFind(HS_NM_BEAN_User user) {
		return sql.selectOne("NM_user.NM_idFind", user);
	}

//고객 이메일정보 가져오기
	public String user_Email(String id) {
		return sql.selectOne("NM_user.user_Email", id);
	}

//공지사항 최근정보 5개만가져오기
	public List<HS_NM_BEAN_Notice> noticeList() {
		return sql.selectList("NM_user.noticeList");
	}

//리뷰게시판 최근정보 5개만 가져오기
	public List<HS_NM_BEAN_Review> reviewList() {
		return sql.selectList("NM_user.reviewList");
	}
	
//매장 최근정보 3개만 가져오기
	public List<HS_NM_BEAN_Shop> shopList() {
		return sql.selectList("NM_user.shopList");
	}


	


}
