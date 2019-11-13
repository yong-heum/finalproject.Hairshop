package com.hair.shop.HS_NM_EmailInquiry;

import java.io.IOException;
import java.io.PrintWriter;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.hair.shop.HS_NM_USER.HS_NM_USER_DAO;
import com.hair.shop.HS_NM_USER.MailUtils;

@Service
public class HS_NM_EmailInquiry_SERVICE {

	ModelAndView mav;

	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	HS_NM_USER_DAO USER_DAO;

// 이메일 문의 전송
	public void EmailInquiry(HS_NM_BEAN_EmailInquiry mail, HttpServletResponse response)
			throws IOException, MessagingException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		MailUtils sendMail = new MailUtils(mailSender);

		// 고객 이메일정보 가져오기
		String Email = USER_DAO.user_Email(mail.getId());
		
		// 회원가입 인증 mail 작성 관련
		sendMail.setSubject("[" + mail.getId() + "]님의 신고/문의사항 ");
		sendMail.setText(sendMail.EmailInquirySetContent(mail.getContents()));
		sendMail.setFrom(Email, "hairShop");
		sendMail.setTo("chldyd2004@naver.com");
		sendMail.send();
		
		out.println("<script>");
		out.println("alert('신고/문의사항 내용이 발송 되었습니다. 고객님의 이메일로 빠른 시일 내에 메일 확인 후 답변 드리겠습니다.')");
		out.println("location.href='EmailInquiryJSP'</script>");
		out.close();
	}

}
