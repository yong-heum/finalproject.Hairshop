package com.hair.shop.HS_NM_SHOP;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hair.shop.HS_DN_USER.HS_DN_BEAN_User;

@Repository
public class HS_NM_SHOP_DAO {

	@Autowired
	private SqlSessionTemplate sql;

// 매장이름 중복확인
	public String shopName_Overlap(String shopName) {
		return sql.selectOne("shop.shopName_Overlap", shopName);
	}

// 매장등록
	public int shopInsert(HS_NM_BEAN_Shop shop) {
		return sql.insert("shop.shopInsert", shop);
	}

// 매장 목록보기 페이징 (기본, 회원주소)
	public List<HS_NM_BEAN_Shop> shopPaging(HS_NM_BEAN_Shop shop) {
		return sql.selectList("shop.shopPaging", shop);
	}

// 매장 목록보기 페이징 (카운트)
	public int shopListCount() {
		return sql.selectOne("shop.shopListCount");
	}

// 매장 검색 페이징(검색)
	public List<HS_NM_BEAN_Shop> shopSearchPaging(HS_NM_BEAN_Shop shop) {
		return sql.selectList("shop.shopSearchPaging", shop);
	}

// 매장 검색 페이징 (카운트)
	public int shopSearchCount(HS_NM_BEAN_Shop shop) {
		return sql.selectOne("shop.shopSearchCount", shop);
	}

// 매장목록 상세조회 (매장정보 불러오기)
	public HS_NM_BEAN_Shop shop_List(String pid_Shop) {
		return sql.selectOne("shop.shop_List", pid_Shop);
	}

// 매장목록 상세조회 (디자이너 정보 불러오기)
	public List<HS_DN_BEAN_User> shop_DN(String pid_Shop) {
		return sql.selectList("shop.shop_DN", pid_Shop);
	}

// 시술 가격표 수정 (기존 정보 가져오기)
	public HS_NM_BEAN_Shop shop_MenuList(HS_NM_BEAN_Shop shop) {
		return sql.selectOne("shop.shop_MenuList", shop);
	}

// 시술 가격표 수정, 등록
	public int shop_MenuInsert(HS_NM_BEAN_Shop shop) {
		return sql.update("shop.shop_MenuInsert", shop);
	}

// 시술가격표 삭제
	public int menuDelete(String pid_Shop) {
		return sql.update("shop.menuDelete", pid_Shop);
	}

// 매장 삭제,매장 등록 신청 목록 (삭제하기)
	public void shopDelete(HS_NM_BEAN_Shop shop) {
		sql.delete("shop.shopDelete", shop);
	}

// 매장 수정
	public int shopUpdate(HS_NM_BEAN_Shop shop) {
		return sql.update("shop.shopUpdate", shop);
	}

// 매장 등록 신청 목록보기
	public List<HS_NM_BEAN_Shop> shopApply1() {
		return sql.selectList("shop.shopApply1" );
	}

// 매장 등록 신청  목록 (디자이너 DB 등록하기)
	public int shopApply2(String pid_shop) {
		return sql.update("shop.shopApply2", pid_shop);
	}

// 매장 등록 신청 목록 (삭제하기)
	public int shopApplyDelete(String pid_shop) {
		return sql.delete("shop.shopApplyDelete", pid_shop);
	}

// 디자이너 직급 불러오기rank
	public List<String> rank(String pid_Shop) {
		return sql.selectList("shop.rank", pid_Shop);
	}

// 디자이너 소속매장 등록 신청 (목록 보기)
	public List<HS_DN_BEAN_User> shop_Disigner_ApplyJSP() {
		return sql.selectList("shop.shop_Disigner_ApplyJSP");
	}

// 매장 등록 신청 목록 (승인하기) 디자이너 DB
	public int shop_Disigner_Apply(HS_DN_BEAN_User user) {
		return sql.update("shop.shop_Disigner_Apply", user);
	}

// 매장 등록 신청 목록 (승인하기) PRICE DB
	public int price_Disigner_Apply(HS_DN_BEAN_User user) {
		return sql.update("shop.price_Disigner_Apply", user);
	}

//디자이너 DB price_rs값 바꾸기 
	public int shop_Disigner_Apply_Update(HS_DN_BEAN_User user) {
		return sql.update("shop.shop_Disigner_Apply_Update", user);
	}

//price DB정보 삭제 
	public int shop_Disigner_Apply_Delete(HS_DN_BEAN_User user) {
		return sql.delete("shop.shop_Disigner_Apply_Delete", user);
	}
	
//price DB에서 디자이너 아이디로 매장 pid가져오기 
	public String belong_Shop(String id) {
		return sql.selectOne("shop.belong_Shop", id);
	}

}
