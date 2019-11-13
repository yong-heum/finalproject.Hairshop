package com.hair.shop.HS_NM_USER;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hair.shop.HS_NM_USER.HS_NM_BEAN_User;
import com.hair.shop.HS_NM_USER.HS_NM_USER_SERVICE;

@Controller
public class HS_NM_USER_CONTROLLER {

	private ModelAndView mav; // ModelAndView : 데이터와 화면을 같이 가지고 가게해줌. 리퀘스트로 데이터를 넣고 디스패처방식으로 넘겨주지 않아도 됨.

	@Autowired
	private HS_NM_USER_SERVICE service;
	@Autowired
	private HttpSession session;

//	@RequestMapping(value = "/")
//	public String home() {
//		return "1test";
//	}

//프로젝트 실행시 기본으로 출력할 페이지 설정
	@RequestMapping(value = "/")
	public String home() {

		return "login";
	}



//매장등록 JSP로 이동
	@RequestMapping(value = "/shopInsertJSP")
	public String shopInsertJSP() {
		return "shopInsert";
	}

//회원가입JSP로 이동
	@RequestMapping(value = "/NM_joinJSP")
	public ModelAndView JoinJSP() {

		mav = new ModelAndView();
		mav.setViewName("join_NM");
		return mav;
	}

//로그인JPS로 이동
	@RequestMapping(value = "/loginJSP")
	public String loginJSP() {
		return "login";
	}

//메인 JSP로 회원정보불러와 이동
	@RequestMapping(value = "/mainJSP")
	public ModelAndView mainJSP(@RequestParam("id") String id) {
		mav = service.mainJSP(id);
		return mav;
	}

// 아이디 중복확인 처리(ajax)
	@RequestMapping(value = "/idOverlap")
	public @ResponseBody String idOverlap(@RequestParam("id") String id) {

		String resultMsg = service.idOverlap(id);
		return resultMsg;
	}

// 회원가입 처리
	@RequestMapping(value = "/NM_join")
	public ModelAndView userJoin(HS_NM_BEAN_User user, HttpServletResponse response)
			throws IOException, MessagingException {

		mav = service.userJoin(user, response);
		return mav;
	}

// 회원가입 후에  메일인증 눌렀을 때
	@RequestMapping(value = "/joinsenMail")
	public ModelAndView joinsenMail(@RequestParam("pid") String pid, HttpServletResponse response) throws IOException {

		mav = service.joinsenMail(pid, response);
		return mav;
	}

// 로그인 처리
	@RequestMapping(value = "/userLogin")
	public ModelAndView userLogin(@ModelAttribute HS_NM_BEAN_User user, HttpServletResponse response)
			throws IOException {

		mav = service.userLogin(user, response);
		return mav;
	}

// 회원 상세 정보 불러오기
	@RequestMapping(value = "/userSelect")
	public ModelAndView userSelect(@RequestParam("id") String id, HttpServletResponse response) throws IOException {

		mav = service.userSelect(id, response);
		return mav;
	}

//회원정보 수정 (정보 불러오기)
	@RequestMapping(value = "/userUpdate1")
	public ModelAndView userUpdate1(@RequestParam("id") String id, HttpServletResponse response) throws IOException {

		mav = service.userUpdate1(id, response);
		return mav;
	}

// 회원정보 수정
	@RequestMapping(value = "/userUpdate2")
	public ModelAndView userUpdate2(@ModelAttribute HS_NM_BEAN_User user, HttpServletResponse response)
			throws IOException {

		mav = service.userUpdate(user, response);
		return mav;
	}

// 회원정보 수정, 회원탈퇴, 비밀번호 변경 (패스워드 확인)
	@RequestMapping(value = "/updatePassword")
	public ModelAndView updatePassword(@ModelAttribute HS_NM_BEAN_User user, HttpServletResponse response)
			throws IOException {

		mav = service.updatePassword(user, response);
		return mav;
	}

// 로그아웃
	@RequestMapping(value = "/logOut")
	public String logOut() {

		session.invalidate();

		return "login";
	}

// 비밀번호 찾기 JSP 가기
	@RequestMapping(value = "/passwordFindJSP")
	public String passwordFindJSP() {
		return "passwordFindJSP";
	}

// 비밀번호 찾기(메일보내기)
	@RequestMapping(value = "/passwordFind")
	public ModelAndView passwordFind(@ModelAttribute HS_NM_BEAN_User user, HttpServletResponse response)
			throws IOException, MessagingException {

		mav = service.passwordFind(user, response);
		return mav;
	}

// 비밀번호 변경JSP(메일링크 눌렀을 때 비밀번호 변경JSP로이동)
	@RequestMapping(value = "/userPasswordUpdateJSP")
	public String passwordUpdateJSP() {
		return "userPasswordUpdate";
	}

// 비밀번호 변경
	@RequestMapping(value = "/userPasswordUpdate")
	public ModelAndView userPasswordUpdate(@ModelAttribute HS_NM_BEAN_User user, HttpServletResponse response)
			throws IOException {

		mav = service.userPasswordUpdate(user, response);
		return mav;
	}

// 아이디 찾기 JSP로 이동
	@RequestMapping(value = "/idFindJSP")
	public String idFindJSP() {
		return "idFindJSP";
	}

// 아이디 찾기(메일보내기)
	@RequestMapping(value = "/idFind")
	public ModelAndView idFind(@ModelAttribute HS_NM_BEAN_User user, HttpServletResponse response)
			throws IOException, MessagingException {

		mav = service.idFind(user, response);
		return mav;
	}
}
