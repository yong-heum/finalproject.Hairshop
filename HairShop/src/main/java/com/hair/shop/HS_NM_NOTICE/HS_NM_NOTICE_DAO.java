package com.hair.shop.HS_NM_NOTICE;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hair.shop.HS_NM_REVIEW.HS_NM_BEAN_Review;
import com.hair.shop.HS_NM_SHOP.HS_NM_BEAN_Paging;

@Repository
public class HS_NM_NOTICE_DAO {
	
	@Autowired
	private SqlSessionTemplate sql;

// 현재 페이지에 보여줘야 하는 공지사항 글만 DB에서 가져오기
	public List<HS_NM_BEAN_Notice> noticeList(HS_NM_BEAN_Paging page) {
		return sql.selectList("notice.noticeList", page);
	}

// 전체 공지사항 글 갯수 DB에서 가져오기 
	public int noticeBoardCount() {
		return sql.selectOne("notice.noticeBoardCount");
	}
	
// 공지사항 글 올리기
	public int noticeInsert(HS_NM_BEAN_Notice notice) {
		return sql.insert("notice.noticeInsert", notice);
	}

// 조회수 올리기 (상세보기에 같이 넣어두면 새로고침 할 때 마다 조회수가 증가되는 것 방지)
	public void noticeHitUp(int boardNum) {
		sql.update("notice.noticeHitUp", boardNum);
		
	}

// 공지사항 게시판 상세정보 조회
	public HS_NM_BEAN_Notice noticeSelect(int boardNum) {
		return sql.selectOne("notice.noticeSelect", boardNum);
	}

// 공지사항 삭제
	public int noticeDelete(int boardNum) {
		return sql.delete("notice.noticeDelete", boardNum);
	}

// 공지사항 수정 
	public int noticeUpdate(HS_NM_BEAN_Notice notice) {
		return sql.update("notice.noticeUpdate", notice);
	}

}
