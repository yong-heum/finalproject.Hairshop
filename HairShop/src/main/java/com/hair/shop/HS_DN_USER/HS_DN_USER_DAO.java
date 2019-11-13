package com.hair.shop.HS_DN_USER;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hair.shop.HS_DN_USER.HS_DN_BEAN_User;
import com.hair.shop.HS_NM_USER.HS_NM_BEAN_User;

@Repository
public class HS_DN_USER_DAO {

	@Autowired
	private SqlSessionTemplate sql;

// 회원가입 처리
	public int DN_userJoin(HS_DN_BEAN_User user) {
		return sql.insert("DN_user.DN_userJoin", user);
	}

// 회원가입 하면서 유니크USER테이블에 같이 저장
	public int DN_uniqueUserJoin(HS_DN_BEAN_User user) {
		return sql.insert("DN_user.DN_uniqueUserJoin", user);
	}

// 중복확인 처리
	public String DN_idOverlap(String id) {
		return sql.selectOne("DN_user.DN_idOverlap", id);
	}

// 회원가입 후에  메일인증 눌렀을 때
	public int DN_joinsenMail(String pid) {
		return sql.update("DN_user.DN_joinsenMail", pid);
	}

// 이메일 인증시에 인증이 되어있나 확인
	public HS_DN_BEAN_User DN_userLoginCheck(String pid) {
		return sql.selectOne("DN_user.DN_userLoginCheck", pid);
	}

// 로그인 처리
	public HS_DN_BEAN_User DN_userLogin(String id) {
		return sql.selectOne("DN_user.DN_userLogin", id);
	}

// 회원 상세 조회 불러오기(DN)
	public HS_DN_BEAN_User DN_userSelect(String id) {
		return sql.selectOne("DN_user.DN_userSelect", id);
	}

// 회원정보 수정(DN)
	public int DN_userUpdate(HS_NM_BEAN_User user) {
		return sql.update("DN_user.DN_userUpdate", user);
	}

// 회원 탈퇴(DN)
	public int DN_userDelete(String pid) {
		return sql.delete("DN_user.DN_userDelete", pid);
	}

// 비밀번호 변경(DN)
	public int DN_userPasswordUpdate(HS_NM_BEAN_User user) {
		return sql.update("DN_user.DN_userPasswordUpdate", user);
	}

//아이디찾기(DM)
	public HS_DN_BEAN_User DN_idFind(HS_NM_BEAN_User user) {
		return sql.selectOne("DN_user.DN_idFind", user);
	}

}
