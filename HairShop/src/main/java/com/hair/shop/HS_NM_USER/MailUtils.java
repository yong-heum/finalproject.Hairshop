package com.hair.shop.HS_NM_USER;
import java.io.UnsupportedEncodingException;
import java.nio.ShortBuffer;

import javax.activation.DataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailUtils {
    
    private JavaMailSender mailSender;
    private MimeMessage message;
    private MimeMessageHelper messageHelper;
    
    public MailUtils(JavaMailSender mailSender) throws MessagingException {
        this.mailSender = mailSender;
        message = this.mailSender.createMimeMessage();
        messageHelper = new MimeMessageHelper(message, true, "UTF-8");
    }
    
    public void setSubject(String subject) throws MessagingException {
        messageHelper.setSubject(subject);
    }
    
    public void setText(String htmlContent) throws MessagingException {
        messageHelper.setText(htmlContent, true);
    }
    
    public void setFrom(String email, String name) throws UnsupportedEncodingException, MessagingException {
        messageHelper.setFrom(email, name);
    }
    
    public void setTo(String email) throws MessagingException {
        messageHelper.setTo(email);
    }
    
    public void addInline(String contentId, DataSource dataSource) throws MessagingException {
        messageHelper.addInline(contentId, dataSource);
    }
    
    public void send() {
        mailSender.send(message);
    }
    
    // 회원가입 이메일 내용.
    public String JoinResultSetContent(String pid) {
    	StringBuffer stb = new StringBuffer();
    	stb.append("<h1>[이메일 인증]</h1>");
    	stb.append("<p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>");
    	stb.append("<a href='http://localhost:8786/shop/joinsenMail?pid="+pid+"&target='_blenk'>이메일 인증 확인'></a>");
    	return stb.toString();
    }
    
    // 비밀번호 찾기 이메일 내용.
    public String PasswordGetContent(String pid) {
    	StringBuffer stb = new StringBuffer();
    	stb.append("<h1>[content]</h1>");
    	stb.append("<p>title</p>");
    	stb.append("<a href='http://localhost:8786/shop/joinsenMail?pid="+pid+"&target='_blenk'>이메일 인증 확인'></a>");
    	return stb.toString();
    }
    
    // 회원가입 이메일 내용.
    public String EmailInquirySetContent(String contents) {
    	StringBuffer stb = new StringBuffer();
    	stb.append("<h1>[신고/문의사항 ]</h1>");
    	stb.append("<p>"+contents+"</p>");
    	return stb.toString();
    }
}