<%@ page contentType="text/html; charset=utf-8"%>
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
$(function(){
	$("#find_pass").click(function(){
		$.ajax({
			url:"/shop/find/findpass",
			type:"post",
			data:{
				m_id:$("#m_id").val(),
				m_name:$("#m_name").val(),
				m_email:$("#m_email").val(),
				m_email_server:$("#m_email_server").val()
			},
			success:function(data){					

				alert(data);
				location.href="/shop/member/loginForm";
				// 임시비밀번호 발송 확인바란다 안내 문구 날려보기
			}
		});
	});
});
</script>
</head>
<body>
<div class="container">
	<form id="member_form" class="form" >
		<h3 class="text-center text-info">비밀번호 찾기</h3>
		<div class="form-group">
			<label for="username" class="text-info">ID:</label><br> <input
				type="text" name="m_id" id="m_id" class="form-control">
		</div>
		<div class="form-group">
			<label for="username" class="text-info">Name:</label><br> <input
				type="text" name="m_name" id="m_name" class="form-control">
		</div>
		<div class="form-group">
			<label for="username" class="text-info">Email_ID:</label><br> <input
				type="text" name="m_email" id="m_email" class="form-control">
		</div>
		@
		<div class="form-group">
			<label for="username" class="text-info">Email_Server:</label><br> <input
				type="text" name="m_email_server" id="m_email_server" class="form-control">
		</div>
		<div id="register-link" class="text-right">
			<input type="button" id="find_pass" value="Find">					
		</div>
		<div class="form-group">			
			<button type="button" onclick="history.back();">Cancel</button>
		</div>
	</form>
</div>
</body>
</html>