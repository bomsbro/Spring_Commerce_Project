<%@page import="com.gumzima.shopping.model.domain.Customer"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.gumzima.shopping.model.common.Pager"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	Customer customer = (Customer)request.getAttribute("customer");
	System.out.print("jsp_id:"+customer.getCustomer_id());
 	String c_ok=null;
	if(customer.getC_ok()==0){
 		c_ok="미처리";
 	}else{
 		c_ok="처리완료";
 	}
%>
<!DOCTYPE html>
<html >
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<%@ include file="../inc/header.jsp"%>
  <style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}

input[type=text], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}

input[type=button] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type=button]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script>
$(function(){
	$("#reply").click(function(){	
		$.ajax({
			url:"/admin/customer/customerupdate",
			data:{
				customer_id:$("#customer_id").val(),
				title:$("#title").val(),
				writer:$("#writer").val(),
				writer_server:$("#writer_server").val(),
				content:$("#content").val()
			},	
			type:"post",
			success:function(data){
				alert(data);
				location.href="/admin/customer/customer_list";
				// 문의 성공 날리기
			}
		});
	});
});
</script>
</head>
<body>
<%@ include file="../inc/main_navi.jsp"%>
<div class="container">
  <h4>답변달기</h4>     

  <form>    
  	<p><h3>처리 상태 : <%=c_ok%><h3></p>
    <input type="hidden" name="customer_id" id="customer_id" value="<%=customer.getCustomer_id()%>">
    <p><h3>질문 내용 : <%=customer.getTitle()%><h3></p>
    <p><h3>작성일 : <%=customer.getRegdate()%><h3></p>
    <input type="hidden" name="title" id="title" value="<%=customer.getTitle()%>">
    <p>질문자 E-mail : <%=customer.getWriter() %>@<%=customer.getWriter_server() %></p>
    <input type="hidden" name="writer" id="writer" value="<%=customer.getWriter()%>">
    <input type="hidden" name="writer_server" id="writer_server" value="<%=customer.getWriter_server()%>">
    
    <textarea name="content"  id="content" placeholder="" style="height:200px"></textarea>    	
    <input type="button" id="reply" value="답변달기">
    <input type="button" value="이전으로" onclick="location.href=history.back();">
  </form>

</div>

</body>
</html>
