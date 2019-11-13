package com.hair.shop.HS_DN_USER;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hair.shop.HS_DN_USER.HS_DN_BEAN_User;
import com.hair.shop.HS_DN_USER.HS_DN_USER_SERVICE;


@Controller
public class HS_DN_USER_CONTROLLER {

	private ModelAndView mav; // ModelAndView : 데이터와 화면을 같이 가지고 가게해줌. 리퀘스트로 데이터를 넣고 디스패처방식으로 넘겨주지 않아도 됨.
	
	@Autowired
	private HS_DN_USER_SERVICE service;


//회원가입JSP로 이동
	@RequestMapping(value = "/DN_joinJSP")
	public ModelAndView JoinJSP() {

		mav = new ModelAndView();
		mav.setViewName("join_DN");
		return mav;
	}

// 아이디 중복확인 처리(ajax)
	@RequestMapping(value = "/DN_idOverlap")
	public @ResponseBody String DN_idOverlap(@RequestParam("id") String id) {

		String resultMsg = service.DN_idOverlap(id);

		return resultMsg;
	}

// 회원가입 처리
	@RequestMapping(value = "/DN_join")
	public ModelAndView DN_userJoin(@ModelAttribute HS_DN_BEAN_User user, HttpServletResponse response)
			throws IOException, MessagingException {
		mav = service.DN_userJoin(user, response);
		return mav;
	}

// 회원가입 후에  메일인증 눌렀을 때
	@RequestMapping(value = "/DN_joinsenMail")
	public ModelAndView DN_joinsenMail(@RequestParam("pid") String pid, HttpServletResponse response) throws IOException {

		mav = new ModelAndView();
		
		mav = service.DN_joinsenMail(pid, response);
		return mav;
	}

}
