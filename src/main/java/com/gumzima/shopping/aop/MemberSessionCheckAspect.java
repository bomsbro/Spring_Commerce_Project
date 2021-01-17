package com.gumzima.shopping.aop;
/*
 * 앞으로 로그인이 필요한 서비스 여부를 처리하기 위한 코드는, 컨트롤러에 두지 않고,
 * 지금 이 객체로 공통화시켜 AOP를 적용하겠다
 * */

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.gumzima.shopping.exception.LoginRequiredException;
import com.gumzima.shopping.model.domain.Member;

public class MemberSessionCheckAspect {
	private static final Logger logger=LoggerFactory.getLogger(MemberSessionCheckAspect.class);
	public Object sessionCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		Object target = joinPoint.getTarget();//원래 호출하려고 했던 객체
		//원래 요청의 흐름을 그대로 진행
		String methodName=joinPoint.getSignature().getName();
		Object[] args= joinPoint.getArgs();//원래 호출하려했던 메서드의 매개변수
		
		//현재의 요청이 세션을 가지고 있는지를 판단하여, 적절한 제어
		
		
		//세션을 얻기 위해서는 httpServletRequest가 필요하다
		HttpServletRequest request=null;
		for(Object arg : args) {
			logger.debug("매개변수 명은 "+arg);
			if(arg instanceof HttpServletRequest) {//request 객체라면
				request = (HttpServletRequest)arg;
			}
		}
		
		//1. 세션이 없다면? 예외를 발생시킬 것임 -->ExceptionHandler를 거쳐서 클라이언트에게 적절한 응답처리
		//2. 세션이 있다면? 그대로 원래 호출하려 했던 메서드 진행
		HttpSession session=null;
		session=request.getSession();
		Object result=null;
		
		if(session.getAttribute("member")==null) {
			throw new LoginRequiredException("로그인이 필요한 서비스입니다.");
		}else {
				//원래 요청의 흐름을 그대로 진행
				//원래 호출하려던 메소드를 대신 호출
				result= joinPoint.proceed();
		}
				
		return result;
	}
	
	public Object adminCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		Object target = joinPoint.getTarget();//원래 호출하려고 했던 객체
		//원래 요청의 흐름을 그대로 진행
		String methodName=joinPoint.getSignature().getName();
		Object[] args= joinPoint.getArgs();//원래 호출하려했던 메서드의 매개변수
		
		//현재의 요청이 세션을 가지고 있는지를 판단하여, 적절한 제어
		
		
		//세션을 얻기 위해서는 httpServletRequest가 필요하다
		HttpServletRequest request=null;
		for(Object arg : args) {
			logger.debug("매개변수 명은 "+arg);
			if(arg instanceof HttpServletRequest) {//request 객체라면
				request = (HttpServletRequest)arg;
			}
		}
		
		//1. 세션이 없다면? 예외를 발생시킬 것임 -->ExceptionHandler를 거쳐서 클라이언트에게 적절한 응답처리
		//2. 세션이 있다면? 그대로 원래 호출하려 했던 메서드 진행
		HttpSession session=null;
		session=request.getSession();
		Object result=null;
		
		if(session.getAttribute("member")==null) {
			throw new LoginRequiredException("로그인이 필요한 서비스입니다.");
		}else {
			Member adminMember=(Member)session.getAttribute("member");
			if(adminMember.getCode()==0) {
				throw new LoginRequiredException("관리자 권한이 필요한 서비스입니다.");
			}else {
				result= joinPoint.proceed();
			}
		}
		return result;
	}
}
