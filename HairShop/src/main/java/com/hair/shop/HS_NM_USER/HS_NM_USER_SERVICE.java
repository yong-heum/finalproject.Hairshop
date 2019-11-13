package com.hair.shop.HS_NM_USER;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.hair.shop.HS_DN_USER.HS_DN_BEAN_User;
import com.hair.shop.HS_DN_USER.HS_DN_USER_DAO;
import com.hair.shop.HS_NM_NOTICE.HS_NM_BEAN_Notice;
import com.hair.shop.HS_NM_REVIEW.HS_NM_BEAN_Review;
import com.hair.shop.HS_NM_SHOP.HS_NM_BEAN_Shop;
import com.hair.shop.HS_NM_TICETIGN.HS_NM_TCKETING_DAO;
import com.hair.shop.HS_NM_USER.HS_NM_BEAN_User;
import com.hair.shop.HS_NM_USER.HS_NM_USER_DAO;

@Service
public class HS_NM_USER_SERVICE {

	ModelAndView mav;

	@Autowired
	private HS_NM_USER_DAO DAO;
	@Autowired
	private HS_DN_USER_DAO DN_DAO;
	@Autowired
	private HS_NM_TCKETING_DAO TCKETING_DAO;
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private HttpSession session;

// 아이디 중복확인
	public String idOverlap(String id) {

		String overlapId = DAO.idOverlap(id);
		String resultMsg;

		if (overlapId == null) {
			resultMsg = "OK";
		} else {
			resultMsg = "NO";
		}
		return resultMsg;
	}

// 회원가입 처리, 회원가입 인증 이메일
	public ModelAndView userJoin(HS_NM_BEAN_User user, HttpServletResponse response)
			throws IOException, MessagingException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		MailUtils sendMail = new MailUtils(mailSender);
		Random ran = new Random();
		mav = new ModelAndView();

		// 비밀번호 암호화
		BCryptPasswordEncoder passEncoder = new BCryptPasswordEncoder();
		String encPassword = passEncoder.encode(user.getPassword());
		user.setPassword(encPassword);
		String pid = "HS_NM_USER_" + user.getId() + "_" + ran.nextInt(99);
		user.setPid(pid);

		DAO.uniqueUserJoin(user);
		int result = DAO.userJoin(user);

		// 회원가입 인증 mail 작성 관련
		sendMail.setSubject("[" + user.getName() + "] 회원가입 이메일 인증");
		sendMail.setText(sendMail.JoinResultSetContent(pid));
		sendMail.setFrom("chldydgma32@gmail.com ", "hairShop");
		sendMail.setTo(user.getEmail());
		sendMail.send();

		// 회원가입 성공 여부, 이동 경로
		if (result == 1) {
			out.println("<script>");
			out.println("alert('회원가입 성공. 이메일 인증 발송 되었습니다.')");
			out.println("location.href='loginJSP'</script>");
			out.close();

		} else {
			out.println("<script>");
			out.println("alert('회원가입을 실패하였습니다.')");
			out.println("history.back();</script>");
			out.close();
		}
		return mav;
	}

// 회원가입 후에  메일인증 눌렀을 때
	public ModelAndView joinsenMail(String pid, HttpServletResponse response) throws IOException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		mav = new ModelAndView();
		PrintWriter out = response.getWriter();

		HS_NM_BEAN_User loginCheckResult = DAO.userLoginCheck(pid);
		HS_DN_BEAN_User DN_loginCheckResult = DN_DAO.DN_userLoginCheck(pid);

		if (loginCheckResult != null) {
			if (loginCheckResult.getEmail_rs() == 1) {
				out.println("<script>");
				out.println("alert('이미 인증이 되어 있습니다.')");
				out.println("location.href='loginJSP'</script>");
				out.close();

			} else {
				int loginresult = DAO.joinsenMail(pid);
				if (loginresult == 1) {
					out.println("<script>");
					out.println("alert('인증 되었습니다. 로그인해주세요.')");
					out.println("location.href='loginJSP'</script>");
					out.close();

				} else {
					out.println("<script>");
					out.println("alert('알수 없는 오류가 발생 되었습니다.')");
					out.println("history.back();</script>");
					out.close();
				}
			}
		} else if (DN_loginCheckResult != null) {
			if (DN_loginCheckResult.getEmail_rs() == 1) {
				out.println("<script>");
				out.println("alert('이미 인증이 되어 있습니다.')");
				out.println("location.href='loginJSP'</script>");
				out.close();

			} else {
				int loginresult = DN_DAO.DN_joinsenMail(pid);
				if (loginresult == 1) {
					out.println("<script>");
					out.println("alert('인증 되었습니다. 로그인해주세요.')");
					out.println("location.href='loginJSP'</script>");
					out.close();

				} else {
					out.println("<script>");
					out.println("alert('알수 없는 오류가 발생 되었습니다.')");
					out.println("history.back();</script>");
					out.close();
				}
			}
		}
		return mav;
	}

//로그인 처리
	public ModelAndView userLogin(HS_NM_BEAN_User user, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		mav = new ModelAndView();
		HS_NM_BEAN_User loginResult = DAO.userLogin(user.getId());
		HS_DN_BEAN_User DN_loginResult = DN_DAO.DN_userLogin(user.getId());
		BCryptPasswordEncoder passEncoder = new BCryptPasswordEncoder();
		if (DN_loginResult != null) {

			if (DN_loginResult.getEmail_rs() == 1) {
				boolean passMatch1 = passEncoder.matches(user.getPassword(), DN_loginResult.getPassword());

				if (passMatch1 == true) {

					//유저 정보 가져오기
					HS_NM_BEAN_User userLoginSelect = DAO.NM_userSelect(user.getId());
					//공지사항 최근정보 5개만가져오기
					List<HS_NM_BEAN_Notice> noticeList = DAO.noticeList();
					//리뷰게시판 최근정보 5개만 가져오기
					List<HS_NM_BEAN_Review> reviewList = DAO.reviewList();
					//매장 최근정보 3개만 가져오기
					List<HS_NM_BEAN_Shop> shopList = DAO.shopList();
					
					for(int i=0; i<reviewList.size();i++) {
						if(reviewList.get(i).getTitle().length()>25) {
							reviewList.get(i).setTitle(reviewList.get(i).getTitle().substring(0, 17)+"............");
						}
					}
					
					for(int i=0; i<noticeList.size();i++) {
						if(noticeList.get(i).getTitle().length()>25) {
							noticeList.get(i).setTitle(noticeList.get(i).getTitle().substring(0, 17)+"............");
						}
					}
					
					if (userLoginSelect != null) {
						
						session.setAttribute("adrs_street_1", DN_loginResult.getAdrs_street_1());
						session.setAttribute("sessionIdCheck", "DN");
						session.setAttribute("name", DN_loginResult.getName());
						session.setAttribute("sessionId", DN_loginResult.getId());
						session.setAttribute("sessionPid", DN_loginResult.getPid());

						mav.addObject("reviewList", reviewList);
						mav.addObject("shopList", shopList);
						mav.addObject("noticeList", noticeList);
						mav.addObject("userLogin", userLoginSelect);
						mav.setViewName("main");
					}

				} else {
					out.println("<script>");
					out.println("alert('아이디 또는 비밀번호를 확인하세요.')");
					out.println("history.back();</script>");
					out.close();
				}
			} else if (DN_loginResult.getEmail_rs() == 0) {
				out.println("<script>");
				out.println("alert('이메일인증 후에 로그인이 가능합니다..')");
				out.println("history.back();</script>");
				out.close();
			}
		} else if (loginResult != null) {
			if (loginResult.getEmail_rs() == 1) {
				boolean passMatch2 = passEncoder.matches(user.getPassword(), loginResult.getPassword());

				if (passMatch2 == true) {
					//유저 정보 가져오기
					HS_NM_BEAN_User userLoginSelect = DAO.NM_userSelect(user.getId());
					//공지사항 최근정보 5개만가져오기
					List<HS_NM_BEAN_Notice> noticeList = DAO.noticeList();
					//리뷰게시판 최근정보 5개만 가져오기
					List<HS_NM_BEAN_Review> reviewList = DAO.reviewList();
					//매장 최근정보 3개만 가져오기
					List<HS_NM_BEAN_Shop> shopList = DAO.shopList();
					
					for(int i=0; i<reviewList.size();i++) {
						if(reviewList.get(i).getTitle().length()>25) {
							reviewList.get(i).setTitle(reviewList.get(i).getTitle().substring(0, 17)+"............");
						}
					}
					
					for(int i=0; i<noticeList.size();i++) {
						if(noticeList.get(i).getTitle().length()>25) {
							noticeList.get(i).setTitle(noticeList.get(i).getTitle().substring(0, 17)+"............");
						}
					}
					
					if (userLoginSelect != null) {
						
						session.setAttribute("adrs_street_1", userLoginSelect.getAdrs_street_1());
						session.setAttribute("sessionIdCheck", "NM");
						session.setAttribute("name", userLoginSelect.getName());
						session.setAttribute("sessionId", userLoginSelect.getId());
						session.setAttribute("sessionPid", userLoginSelect.getPid());

						mav.addObject("reviewList", reviewList);
						mav.addObject("shopList", shopList);
						mav.addObject("noticeList", noticeList);
						mav.addObject("userLogin", userLoginSelect);
						mav.setViewName("main");
					}

				} else {
					out.println("<script>");
					out.println("alert('아이디 또는 비밀번호를 확인하세요.')");
					out.println("history.back();</script>");
					out.close();
				}
			} else if (loginResult.getEmail_rs() == 0) {
				out.println("<script>");
				out.println("alert('이메일인증 후에 로그인이 가능합니다.')");
				out.println("history.back();</script>");
				out.close();
			}
		} else {
			out.println("<script>");
			out.println("alert('아이디와 비밀번호를 확인해주세요.')");
			out.println("history.back();</script>");
			out.close();
		}
		return mav;

	}

// 회원 상세 정보 불러오기
	public ModelAndView userSelect(String id, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		HS_NM_BEAN_User userSelect = DAO.NM_userSelect(id);
		String pid = TCKETING_DAO.customer_pid(id);
		// 포인트
		int point = 0;

		if (pid.substring(0, 10).equals("HS_NM_USER")) {

			point = TCKETING_DAO.NM_User_point(pid);

		} else if (pid.substring(0, 10).equals("HS_DN_USER")) {

			point = TCKETING_DAO.DN_User_point(pid);

		}

		if (userSelect != null) {
			mav.addObject("point", point);
			mav.addObject("userSelect", userSelect);
			mav.setViewName("userSelect");

		} else {
			out.println("<script>");
			out.println("alert('회원정보 불러오기 실패.')");
			out.println("history.back();</script>");
			out.close();

		}
		return mav;
	}

//회원정보 수정 (정보 불러오기)
	public ModelAndView userUpdate1(String id, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		mav = new ModelAndView();

		HS_NM_BEAN_User userSelect = DAO.NM_userSelect(id);

		if (userSelect != null) {

			mav.addObject("userSelect", userSelect);
			mav.setViewName("userUpdate");

		} else {
			out.println("<script>");
			out.println("alert('회원정보 불러오기 실패.')");
			out.println("history.back();</script>");
			out.close();

		}
		return mav;
	}

//회원정보 수정
	public ModelAndView userUpdate(HS_NM_BEAN_User user, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		mav = new ModelAndView();

		int result = DN_DAO.DN_userUpdate(user);

		if (result == 1) {

			HS_DN_BEAN_User userSelect = DN_DAO.DN_userSelect(user.getId());
			DAO.NM_uniqueUserInsert(user);

			mav.addObject("userSelect", userSelect);
			mav.setViewName("userSelect");
		}
		return mav;
	}

//회원정보 수정 패스워드 확인, 회원 탈퇴
	public ModelAndView updatePassword(HS_NM_BEAN_User user, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		BCryptPasswordEncoder passEncoder = new BCryptPasswordEncoder();

		mav = new ModelAndView();

		if (user.getPid().substring(0, 10).equals("HS_NM_USER")) {

			HS_NM_BEAN_User userSelect = DAO.NM_userSelect(user.getId());

			boolean passMatch1 = passEncoder.matches(user.getPassword(), userSelect.getPassword());

//회원 수정
			if (user.getPasswordCheck() == 1 && passMatch1 == true) {
				mav.addObject("userSelect", userSelect);
				mav.setViewName("userUpdate");
//회원 탈퇴
			} else if (user.getPasswordCheck() == 2 && passMatch1 == true) {
				int result = DAO.NM_userDelete(user.getPid());
				if (result == 1) {
					DAO.NM_uniqueUserDelete(user.getPid());
					session.invalidate();
					out.println("<script>");
					out.println("alert('삭제 되었습니다. 이용해 주셔서 감사합니다.')");
					out.println("location.href='loginJSP'</script>");
					out.close();
				} else {
					out.println("<script>");
					out.println("alert('회원탈퇴 실패.')");
					out.println("location.href='loginJSP'</script>");
					out.close();
				}
//비밀번호 수정
			} else if (user.getPasswordCheck() == 3 && passMatch1 == true) {
				mav.setViewName("userPasswordUpdate");

			} else {

				out.println("<script>");
				out.println("alert('비밀번호가 맞지 않습니다.')");
				out.println("history.back();</script>");
				out.close();
			}
		} else if (user.getPid().substring(0, 10).equals("HS_DN_USER")) {

			HS_DN_BEAN_User userSelect = DN_DAO.DN_userSelect(user.getId());
			boolean passMatch1 = passEncoder.matches(user.getPassword(), userSelect.getPassword());

			if (user.getPasswordCheck() == 1 && passMatch1 == true) {
				mav.addObject("userSelect", userSelect);
				mav.setViewName("userUpdate");

			} else if (user.getPasswordCheck() == 2 && passMatch1 == true) {
				int result = DAO.NM_userDelete(user.getPid());
				if (result == 1) {
					session.invalidate();
					out.println("<script>");
					out.println("alert('삭제 되었습니다. 이용해 주셔서 감사합니다.')");
					out.println("location.href='loginJSP'</script>");
					out.close();
				} else {
					out.println("<script>");
					out.println("alert('회원탈퇴 실패.')");
					out.println("location.href='loginJSP'</script>");
					out.close();
				}
			} else if (user.getPasswordCheck() == 3 && passMatch1 == true) {
				mav.setViewName("userPasswordUpdate");

			} else {

				out.println("<script>");
				out.println("alert('비밀번호가 맞지 않습니다.')");
				out.println("history.back();</script>");
				out.close();
			}
		}
		return mav;
	}

// 비밀번호 변경
	public ModelAndView userPasswordUpdate(HS_NM_BEAN_User user, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		mav = new ModelAndView();

		// 비밀번호 암호화
		BCryptPasswordEncoder passEncoder = new BCryptPasswordEncoder();
		String encPassword = passEncoder.encode(user.getPassword());
		user.setPassword(encPassword);

		if (user.getPid().substring(0, 10).equals("HS_NM_USER")) {

			int result = DAO.NM_userPasswordUpdate(user);

			if (result == 1) {
				session.invalidate();
				out.println("<script>");
				out.println("alert('비밀 번호 변경이 완료 되었습니다. 다시 로그인 해주십시오')");
				out.println("location.href='loginJSP';</script>");
				out.close();

			}
		} else if (user.getPid().substring(0, 10).equals("HS_DN_USER")) {

			int result = DN_DAO.DN_userPasswordUpdate(user);

			if (result == 1) {
				session.invalidate();
				out.println("<script>");
				out.println("alert('비밀 번호 변경이 완료 되었습니다. 다시 로그인 해주십시오')");
				out.println("location.href='loginJSP';</script>");
				out.close();

			}
		}
		return mav;
	}

//비밀번호 찾기 메일 보내기
	public ModelAndView passwordFind(HS_NM_BEAN_User user, HttpServletResponse response)
			throws IOException, MessagingException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		MailUtils sendMail = new MailUtils(mailSender);
		mav = new ModelAndView();

		HS_NM_BEAN_User NM_userInfo = DAO.userLogin(user.getId());
		HS_DN_BEAN_User DN_userInfo = DN_DAO.DN_userLogin(user.getId());

		if (NM_userInfo != null) {

			if (user.getEmail().contentEquals(NM_userInfo.getEmail())
					&& user.getName().contentEquals(NM_userInfo.getName())
					&& user.getBirthDay().contentEquals(NM_userInfo.getBirthDay())) {

				session.setAttribute("sessionPid", NM_userInfo.getPid());

				// 비밀번호 변경 사이트로 가게해주는 mail 작성 관련
				sendMail.setSubject("[  ] 비밀번호 찾기/변경 이메일");
				sendMail.setText(new StringBuffer().append("<h1>[이메일 찾기/변경]</h1>")
						.append("<p>아래 링크를 클릭하시면 비밀번호 변경 페이지로 이동됩니다.</p>")
						.append("<a href='http://localhost:8787/shop/userPasswordUpdateJSP")
						.append("' target='_blenk'>본인 확인 인증</a>").toString());
				sendMail.setFrom("chldydgma32@gmail.com ", "chldydgma32@gmail.com");
				sendMail.setTo(user.getEmail());
				sendMail.send();

				out.println("<script>");
				out.println("alert('이메일 찾기 이메일이 전송 되었습니다. 메일을 확인해 주세요.')");
				out.println("location.href='loginJSP';</script>");
				out.close();

			} else {
				out.println("<script>");
				out.println("alert('회원정보를 정확히 입력해주세요.')");
				out.println("history.back();</script>");
				out.close();
			}
		} else if (DN_userInfo != null) {
			if (user.getEmail().contentEquals(DN_userInfo.getEmail())
					&& user.getName().contentEquals(DN_userInfo.getName())
					&& user.getBirthDay().contentEquals(DN_userInfo.getBirthDay())) {

				session.setAttribute("sessionPid", DN_userInfo.getPid());

				// 비밀번호 변경 사이트로 가게해주는 mail 작성 관련
				sendMail.setSubject("[  ] 비밀번호 찾기/변경 이메일");
				sendMail.setText(new StringBuffer().append("<h1>[이메일 찾기/변경]</h1>")
						.append("<p>아래 링크를 클릭하시면 비밀번호 변경 페이지로 이동됩니다.</p>")
						.append("<a href='http://localhost:8787/shop/userPasswordUpdateJSP")
						.append("' target='_blenk'>본인 확인 인증</a>").toString());
				sendMail.setFrom("chldydgma32@gmail.com ", "chldydgma32@gmail.com");
				sendMail.setTo(user.getEmail());
				sendMail.send();

				out.println("<script>");
				out.println("alert('이메일 찾기 이메일이 전송 되었습니다. 메일을 확인해 주세요.')");
				out.println("location.href='loginJSP';</script>");
				out.close();

			} else {
				out.println("<script>");
				out.println("alert('회원정보를 정확히 입력해주세요.')");
				out.println("history.back();</script>");
				out.close();
			}
		} else {
			out.println("<script>");
			out.println("alert('회원정보를 정확히 입력해주세요.')");
			out.println("history.back();</script>");
			out.close();
		}
		return mav;
	}

// 아이디 찾기
	public ModelAndView idFind(HS_NM_BEAN_User user, HttpServletResponse response)
			throws IOException, MessagingException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		MailUtils sendMail = new MailUtils(mailSender);
		mav = new ModelAndView();

		HS_NM_BEAN_User NM_userInfo = DAO.NM_idFind(user);
		HS_DN_BEAN_User DN_userInfo = DN_DAO.DN_idFind(user);

		if (NM_userInfo != null) {

			String id = NM_userInfo.getId();
			String result = id.substring(0, id.length() - 4);
			String userId = result + "****";

			// 비밀번호 변경 사이트로 가게해주는 mail 작성 관련
			sendMail.setSubject("[  ] 아이디 찾기 이메일");
			sendMail.setText(new StringBuffer().append("<h1>[고객님의 아이디 :" + userId + "]</h1>")
					.append("<p>아래 링크를 클릭하시면 로그인 페이지로 이동됩니다.</p>")
					.append("<a href='http://localhost:8787/shop/loginJSP").append("' target='_blenk'>로그인 하러 가기</a>")
					.toString());
			sendMail.setFrom("chldydgma32@gmail.com ", "chldydgma32@gmail.com");
			sendMail.setTo(user.getEmail());
			sendMail.send();

			out.println("<script>");
			out.println("alert('아이디가 회원님의 이메일로 전송 되었습니다. 메일을 확인해 주세요.')");
			out.println("location.href='loginJSP';</script>");
			out.close();

		} else if (DN_userInfo != null) {

			String userId = "*" + DN_userInfo.getId().substring(1, 7) + "***";
			// 비밀번호 변경 사이트로 가게해주는 mail 작성 관련
			sendMail.setSubject("[  ] 아이디 찾기 이메일");
			sendMail.setText(new StringBuffer().append("<h1>[고객님의 아이디 :" + userId + "]</h1>")
					.append("<p>아래 링크를 클릭하시면 로그인 페이지로 이동됩니다.</p>")
					.append("<a href='http://localhost:8787/shop/loginJSP").append("' target='_blenk'>로그인 하러 가기</a>")
					.toString());
			sendMail.setFrom("chldydgma32@gmail.com ", "chldydgma32@gmail.com");
			sendMail.setTo(user.getEmail());
			sendMail.send();

			out.println("<script>");
			out.println("alert('아이디가 회원님의 이메일로 전송 되었습니다. 메일을 확인해 주세요.')");
			out.println("location.href='loginJSP';</script>");
			out.close();

		} else {
			out.println("<script>");
			out.println("alert('회원정보를 정확히 입력해주세요.')");
			out.println("history.back();</script>");
			out.close();
		}
		return mav;
	}

//메인 JSP로 회원정보불러와 이동
	public ModelAndView mainJSP(String id) {

		mav = new ModelAndView();
		//유저 정보 가져오기
		HS_NM_BEAN_User userLoginSelect = DAO.NM_userSelect(id);
		//공지사항 최근정보 5개만가져오기
		List<HS_NM_BEAN_Notice> noticeList = DAO.noticeList();
		//리뷰게시판 최근정보 5개만 가져오기
		List<HS_NM_BEAN_Review> reviewList = DAO.reviewList();
		//매장 최근정보 3개만 가져오기
		List<HS_NM_BEAN_Shop> shopList = DAO.shopList();
		
		for(int i=0; i<reviewList.size();i++) {
			if(reviewList.get(i).getTitle().length()>25) {
				reviewList.get(i).setTitle(reviewList.get(i).getTitle().substring(0, 17)+"............");
			}
		}
		
		for(int i=0; i<noticeList.size();i++) {
			if(noticeList.get(i).getTitle().length()>25) {
				noticeList.get(i).setTitle(noticeList.get(i).getTitle().substring(0, 17)+"............");
			}
		}
		
		if (userLoginSelect != null) {

			mav.addObject("reviewList", reviewList);
			mav.addObject("shopList", shopList);
			mav.addObject("noticeList", noticeList);
			mav.addObject("userLogin", userLoginSelect);
			mav.setViewName("main");
		}
		return mav;
	}

}
