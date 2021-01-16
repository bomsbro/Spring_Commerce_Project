<%@page import="com.gumzima.shopping.model.domain.Member"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	Member member= (Member)request.getAttribute("member");	
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<style>
input[type=text], select, textarea,input[type=password] {
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
.loader {
  border: 16px solid #f3f3f3;
  border-radius: 50%;
  border-top: 16px solid blue;
  border-right: 16px solid green;
  border-bottom: 16px solid red;
  border-left: 16px solid pink;
  width: 120px;
  height: 120px;
  -webkit-animation: spin 2s linear infinite;
  animation: spin 2s linear infinite;
}

@-webkit-keyframes spin {
  0% { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
	$("input[type='button']"[0]).click(function () {
		edit();
	});	
});
function edit(){
	if(confirm("수정하시겠습니까?")){
	  var form = document.querySelector("form");
	  form.action="/shop/member/edit";
	  form.method="post";
	  form.submit();		
	}
}
function del(){
	if(confirm("삭제하시겠습니까?")){
	  var form = document.querySelector("form");
	  form.action="/shop/member/del";
	  form.method="post";
	  form.submit();		
	}
}
</script>
</head>
<body>
	<%-- <%@ include file="../inc/top.jsp"%> --%>
	<div class="container">
	<div id="loader" style="margin:auto"></div>	
	<form >
		<h3 class="text-center text-info">회원가입</h3>
		<input type="hidden" name="member_id" value="<%=member.getMember_id()%>">
		<div class="form-group">
			<label for="username" class="text-info">Username:</label><br> <input
				type="text" name="m_id" id="m_id" value="<%=member.getM_id() %>" class="form-control"><button type="button" onclick="idCheck()">중복확인</button>
		</div>
		<div class="form-group">
			<label for="password" class="text-info">nickName:</label><br> <input
				type="text" name="m_name" id="m_name" value="<%=member.getM_name() %>" class="form-control">
		</div>
		<div class="form-group">
			<label for="password" class="text-info">Email:</label><br> <input
				type="text" name="m_email" id="m_email" value="<%=member.getM_email()%>" class="form-control">
		</div>
		<div class="form-group">
			<select name="m_email_server" class="form-control">
				<option value="gmail.com">gmail.com</option>
				<option value="daum.net">daum.net</option>
				<option value="naver.com">naver.com</option>
			</select>
		</div>
		<div class="form-group">
			<label for="password" class="text-info">Phone:</label><br> <input
				type="text" name="m_phone" id="m_phone" value="<%=member.getM_phone() %>" class="form-control" value="(-)를 제외하고 입력해주세요.">
		</div>
		<div class="form-group">
			<label for="password" class="text-info">Addr:</label><br><input 
				type="button" onclick="goPopup();" value="찾기" > 
				<input type="text" name="m_addr1" id="m_addr1" value="<%=member.getM_addr1() %>" class="form-control">			
				<input type="text" name="m_addr1" id="m_addr2" value="<%=member.getM_addr2() %>" class="form-control">			
				<input type="text" name="m_addr1" id="m_addr3" value="<%=member.getM_addr3() %>" class="form-control">			
		</div>	
		<div id="register-link" class="text-right">
			 <input type="button" value="수정하기" onClick="edit()">
    		<input type="button" value="삭제하기" onClick="del()">		
    		<input type="button" value="목록보기" onClick="location.href='/shop/member/list'">		
		</div>
	</form>
	</div>
</body>

</html>