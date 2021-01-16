<%@page import="com.gumzima.shopping.model.domain.Notice"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	int result = (Integer)request.getAttribute("result"); //수정결과값
	Notice notice = (Notice)request.getAttribute("notice");
	
	StringBuilder sb = new StringBuilder();
	
	sb.append("<script>");	
	if(result==0){
		sb.append("alert('수정실패');");
		sb.append("history.back();");
	}else{
		sb.append("alert('수정성공');");
		sb.append("location.href='/admin/notice/detail?notice_id="+notice.getNotice_id()+"';");
	}
	sb.append("</script>");
	
	out.print(sb.toString());
%>