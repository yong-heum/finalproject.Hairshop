package com.hair.shop.HS_NM_TICETIGN;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hair.shop.HS_DN_USER.HS_DN_BEAN_User;
import com.hair.shop.HS_NM_USER.HS_NM_BEAN_User;

@Repository
public class HS_NM_TCKETING_DAO {

	@Autowired
	private SqlSessionTemplate sql;

// 디자이너 PID 불러오기 
	public String disigner_pid(String disigner_id) {
		return sql.selectOne("ticketing.disigner_pid", disigner_id);
	}

// 디자이너 NAME불러오기
	public String disigner_Name(String id) {
		return sql.selectOne("ticketing.disigner_Name", id);
	}

// 디자이너 아이디 불러오기
	public String disigner_id(HS_NM_BEAN_TICKETING ticketing) {
		return sql.selectOne("ticketing.disigner_id", ticketing);
	}

// 매장 PID 불러오기  
	public String shop_pid(String shopName) {
		return sql.selectOne("ticketing.shop_pid", shopName);
	}

// 시술 가격표 저장 
	public int priceInsert(HS_NM_BEAN_PRICE price) {
		return sql.insert("ticketing.priceInsert", price);
	}

// 개인 시술 금액 정보 불러오기 
	public HS_NM_BEAN_PRICE priceSelect(String disigner_id) {
		return sql.selectOne("ticketing.priceSelect", disigner_id);
	}

// 휴무등록 (Ajax), 예약자 확인 
	public List<String> ticketingCheck(String ticketing_Date) {
		return sql.selectList("ticketing.ticketingCheck", ticketing_Date);
	}

// 휴무등록 
	public int ClosedsInsert(HS_NM_BEAN_CLOSEDS closeds) {
		return sql.insert("ticketing.ClosedsInsert", closeds);
	}

// 휴무삭제
	public int ClosedsDelete(HS_NM_BEAN_CLOSEDS closeds) {
		return sql.delete("ticketing.ClosedsDelete", closeds);
	}

// 디자이너 pid로 소속 매장 불러오기
	public String shopNameResult(String disigner_pid) {
		return sql.selectOne("ticketing.shopNameResult", disigner_pid);
	}

// 소속매장pid로 소속매장 이름 불러오기
	public String shopName(String shopNameResult) {
		return sql.selectOne("ticketing.shopName", shopNameResult);
	}

// ticketingJSP로 휴무 날짜 리스트 정보 가지고 이동(Ajax)
	public List<String> closeds_closedsList(HS_NM_BEAN_CLOSEDS closeds) {
		return sql.selectList("ticketing.closedsList", closeds);
	}

// ticketingJSP로 휴무 날짜 리스트 정보 가지고 이동
	public List<String> closeds_InsertList(String disigner_pid) {
		return sql.selectList("ticketing.closeds_InsertList", disigner_pid);
	}

// ticketing_2 JSP로 예약 되어있는 시간 정보 불러오기(ticketing_1에서 가져온 정보 가져가기)
	public List<HS_NM_BEAN_TICKETING> ticketing_List(HS_NM_BEAN_TICKETING ticketing) {
		return sql.selectList("ticketing.ticketing_List", ticketing);
	}

// 오픈시간 마감시간값으로 TICKETING_TIME테이블에서 RS값 찾아오기 
	public int rs_Time(String rs_Open) {
		return sql.selectOne("ticketing.rs_Time", rs_Open);
	}

// 예약자 PID,NAME불러오기 
	public List<HS_NM_BEAN_User> customer_pid_Name(String customer_id) {
		return sql.selectList("ticketing.customer_pid_Name", customer_id);
	}

// 예약자 pid가져오기 
	public String customer_pid(String customer_id) {
		return sql.selectOne("ticketing.customer_pid", customer_id);
	}

// 일반 고객의 잔여 포인트 정보 불러오기 
	public int NM_User_point(String customer_id) {
		return sql.selectOne("ticketing.NM_User_point", customer_id);
	}

// 디자이너 고객 잔여 포인트 정보 불러오기 
	public int DN_User_point(String customer_id) {
		return sql.selectOne("ticketing.DN_User_point", customer_id);
	}

// 예약시 디자이너 pid가져오기
	public String ticketing_disigner_pid(HS_NM_BEAN_TICKETING ticketing) {
		return sql.selectOne("ticketing.ticketing_disigner_pid", ticketing);
	}

// 시술 예약하기 
	public int ticketing_Insert(HS_NM_BEAN_TICKETING ticketing) {
		return sql.insert("ticketing.ticketing_Insert", ticketing);
	}

// ticketHistoryJSP로 이도하면서 예매 내역 정보 불러오기 
	public List<HS_NM_BEAN_TICKETING> ticketHistoryJSP(String id) {
		return sql.selectList("ticketing.ticketHistoryJSP", id);
	}

// 인반 고객 포인트 사용 후 잔여 포인트 저장 
	public int NM_User_pointUpdate(HS_NM_BEAN_TICKETING ticketing) {
		return sql.update("ticketing.NM_User_pointUpdate", ticketing);
	}

// 디자이너 고객 포인트 사용 후 잔여 포인트 저장 
	public int DN_User_pointUpdate(HS_NM_BEAN_TICKETING ticketing) {
		return sql.update("ticketing.DN_User_pointUpdate", ticketing);
	}

// 현제시간 불러오기 
	public int sysDate_HH() {
		return sql.selectOne("ticketing.sysDate_HH");
	}

// 현제 날짜만 가져와 예약 날짜와비교해 예약날짜만 보이지 않게 함. 
	public String sysDate() {
		return sql.selectOne("ticketing.sysDate");
	}

// price등록시 디자이너 정보 price_rs바꾸기 
	public int priceInsert_DNuser(HS_NM_BEAN_PRICE price) {
		return sql.update("ticketing.priceInsert_DNuser", price);
	}

// 개인 시술금액 , 직급, 근무시간 수정 
	public int priceUpdate(HS_NM_BEAN_PRICE price) {
		return sql.update("ticketing.priceUpdate", price);
	}

// ticketHistoryJSP에서 값을 가지고 예약리스트 불러오기 
	public List<HS_NM_BEAN_TICKETING> ticketing_DN_List(HS_NM_BEAN_TICKETING ticketing) {
		return sql.selectList("ticketing.ticketing_DN_List", ticketing);
	}

// ticketing_DN_List 모달에 고객이 디자이너에게 예매했던 내역 정보 불러오기(Ajax)
	public List<HS_NM_BEAN_TICKETING> ticketHistory_DN(HS_NM_BEAN_TICKETING ticketing) {
		
		return sql.selectList("ticketing.ticketHistory_DN", ticketing);
	}

// DN_user포인트 지급 할 수 있는 횟수  증가
	public int DN_user_Point_Count_Up(String pid) {
		return sql.update("ticketing.DN_user_Point_Count_Up", pid);
	}

// NM_user포인트 지급 할 수 있는 횟수 증가 
	public int NM_user_Point_Count_Up(String pid) {
		return sql.update("ticketing.NM_user_Point_Count_Up", pid);
	}

// 디자이너가 시술 완료시  시술 완료로 바꾸고 포인트 지급이 가능 하게 함. 
	public int work_completed(HS_NM_BEAN_TICKETING ticketing) {
		return sql.update("ticketing.work_completed", ticketing);
	}

// 예약 취소 complete 3으로 변경 
	public int ticketing_cancel(HS_NM_BEAN_TICKETING ticketing) {
		return sql.update("ticketing.ticketing_cancel", ticketing);
	}

// 예약 강제 막기 
	public int ticketing_Block_Insert(HS_NM_BEAN_TICKETING ticketing) {
		return sql.insert("ticketing.ticketing_Block_Insert", ticketing);
	}

}
