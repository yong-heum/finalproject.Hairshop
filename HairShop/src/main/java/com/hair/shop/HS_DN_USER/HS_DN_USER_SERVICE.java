package com.hair.shop.HS_DN_USER;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hair.shop.HS_NM_USER.HS_NM_BEAN_User;
import com.hair.shop.HS_NM_USER.HS_NM_USER_DAO;
import com.hair.shop.HS_NM_USER.MailUtils;

@Service
public class HS_DN_USER_SERVICE {

	ModelAndView mav;

	@Autowired
	private HS_DN_USER_DAO DAO;
	@Autowired
	private JavaMailSender mailSender;


// 아이디 중복확인
	public String DN_idOverlap(String id) {
		
		String overlapId = DAO.DN_idOverlap(id);
		String resultMsg;

		if (overlapId == null) {
			resultMsg = "OK";
		} else {
			resultMsg = "NO";
		}
		return resultMsg;
	}

// 회원가입 처리, 회원가입 인증 이메일
	public ModelAndView DN_userJoin(HS_DN_BEAN_User user, HttpServletResponse response) throws IOException, MessagingException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		MailUtils sendMail = new MailUtils(mailSender);
		Random ran = new Random();
		mav = new ModelAndView();

		//비밀번호 암호화
		BCryptPasswordEncoder passEncoder = new BCryptPasswordEncoder();
		String encPassword = passEncoder.encode(user.getPassword());
		user.setPassword(encPassword);

		//고유번호 생성
		user.setPid("HS_DN_USER_" + user.getId() + "_" + ran.nextInt(99));
		
		//프로필사진 첨부
		MultipartFile Profile_Photo = user.getProfile_Photo();
		String Profile_Photo_name = Profile_Photo.getOriginalFilename();
//		String savePath = "C:/Users/user/Desktop/HairShop/src/main/webapp/resources/profile_photo/"+Profile_Photo_name;
		String savePath = "C:/Users/gg/Desktop/용흠/HairShop/src/main/webapp/resources/profile_photo/"+Profile_Photo_name;
		
		if(!Profile_Photo.isEmpty()) {
			Profile_Photo.transferTo(new File(savePath));
		}
		user.setProfile_Photo_Name(Profile_Photo_name);

		//디자이너 소개글 엔터 가능처리
		user.setIntroduce(user.getIntroduce().replace("\r\n", "<br>"));
		
		DAO.DN_uniqueUserJoin(user);
		int result = DAO.DN_userJoin(user);

		// 회원가입 인증 mail 작성 관련
		sendMail.setSubject("[  ] 회원가입 이메일 인증");
		sendMail.setText(new StringBuffer().append("<h1>[이메일 인증]</h1>").append("<p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>")
				.append("<a href='http://localhost:8786/shop/joinsenMail?pid=").append(user.getPid())
				.append("' target='_blenk'>이메일 인증 확인</a>").toString());
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
	public ModelAndView DN_joinsenMail(String pid, HttpServletResponse response) throws IOException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		mav = new ModelAndView();
		PrintWriter out = response.getWriter();

		HS_DN_BEAN_User loginCheckResult = DAO.DN_userLoginCheck(pid);

		if (loginCheckResult.getEmail_rs() == 1) {
			out.println("<script>");
			out.println("alert('이미 인증이 되어 있습니다.')");
			out.println("location.href='loginJSP'</script>");
			out.close();

		} else {
			int loginresult = DAO.DN_joinsenMail(pid);
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
		return mav;
	}

}
