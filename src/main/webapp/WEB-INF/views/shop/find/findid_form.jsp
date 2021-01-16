<%@ page contentType="text/html; charset=utf-8"%>
<%
	String m_id = (String)request.getAttribute("m_id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<style>
body {
  margin: 0;
  padding: 0;
  //background-color: #17a2b8;
  height: 100vh;
}
#login .container #login-row #login-column #login-box {
  margin-top: 120px;
  max-width: 600px;
  height: 320px;
  border: 1px solid #9C9C9C;
  background-color: #EAEAEA;
}
#login .container #login-row #login-column #login-box #login-form {
  padding: 20px;
}
#login .container #login-row #login-column #login-box #login-form #register-link {
  margin-top: -85px;
}
</style>
<script type="text/javascript">
function find_id() {//아이디를 찾아주세요..
	$("#member_form").attr({
		action:"/shop/find/findid",
		method:"post"	
	});	
	$("#member_form").submit();
}
</script>
</head>
<body>
<div class="container">
	<form id="member_form" class="form" >
		<h3 class="text-center text-info">아이디 찾기</h3>
		<div class="form-group">
			<label for="username" class="text-info">nickName:</label><br> <input
				type="text" name="m_name" id="m_name" class="form-control">
		</div>
		<div class="form-group">
			<label for="useremail" class="text-info">Email:</label><br> <input
				type="text" name="m_email" id="m_email" class="form-control">
		</div>
		<div id="register-link" class="text-right">
			<input type="button" onclick="find_id()" value="Find">					
		</div>
		<div class="form-group">			
			<button type="button" onclick="javascript:history.back();">Cancel</button>
		</div>
		<div>
			
		</div>
	</form>
</div>
</body>
</html>