package com.hair.shop.HS_NM_EmailInquiry;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HS_NM_EmailInquiry_CONTROLLER {

	@Autowired
	private HS_NM_EmailInquiry_SERVICE service;

// 이메일 문의 JSP로 이동.
	@RequestMapping(value = "/EmailInquiryJSP")
	public String EmailInquiryJSP() {
		return "EmailInquiry";
	}

// 이메일 문의 전송
	@RequestMapping(value = "/EmailInquiry")
	public void EmailInquiry(HS_NM_BEAN_EmailInquiry mail, HttpServletResponse response ) throws MessagingException, IOException {
		
		service.EmailInquiry(mail,response);
	}
	
}
