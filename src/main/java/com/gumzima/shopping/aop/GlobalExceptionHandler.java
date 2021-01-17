package com.gumzima.shopping.aop;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gumzima.shopping.exception.LoginRequiredException;
import com.gumzima.shopping.model.common.MessageData;

/*
 * 모든 컨트롤러마다 일일이 예외처리 핸들러를 작성하면 코드 중복이 발생하므로,
 * 컨트롤러에서 발생하는 모든 예외를 감지하는 객체를 정의하여, 공통예외 처리를
 * 작성
 * */

@ControllerAdvice
public class GlobalExceptionHandler {
	@ExceptionHandler(LoginRequiredException.class)
	public ModelAndView handlerException(LoginRequiredException e) {
		ModelAndView mav = new ModelAndView();

		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		mav.addObject("messageData", messageData);
		mav.setViewName("shop/error/message");
		return mav;
	}
}
