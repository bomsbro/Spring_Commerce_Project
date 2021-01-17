<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="java.sql.Date"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%	
	String str="";	
	if(request.getAttribute("m_id")!=null){
		String m_id=(String)request.getAttribute("m_id"); // null...where is congtroller show me
		if(request.getAttribute("m_id").equals("0")){
			str="일치하는 ID 정보가 없습니다.";
		}else{
			str="회원님의 ID는 "+m_id+"입니다.";
		}
	}
%>
<!DOCTYPE html>
<html>
  <head>
    <title>Vegefoods - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <%@ include file="../inc/header.jsp" %>
    <style>
body {
  margin: 0;
  padding: 0;
  height: 100vh;
}
#login .container #login-row #login-column #login-box {
  margin-top: 120px;
  max-width: 700px;
  height: 350px;
  border: 1px solid #9C9C9C;
  background-color: #EAEAEA;
}
#login .container #login-row #login-column #login-box #login-form {
  padding: 0px;
}
#login .container #login-row #login-column #login-box #login-form #register-link {
  margin-top: -85px;
}
</style>
<script>
	function login(){
		if($("#m_id").val()==""){
			alert("아이디를 입력해주세요");
		}else if($("#m_pass").val()==""){
			alert("비밀번호를 입력해주세요");
		}else{
			$.ajax({
				url:"/shop/member/login",
				method:"post",
				data:{
					m_id:$("#m_id").val(),
					m_pass:$("#m_pass").val()
				},
				success:function(responseData){
					if(responseData=="1"){
						location.href="/";
					}else{
						alert("올바르지 않은 정보입니다.");
					}
				}
			});
		}
	}
</script>		
  </head>
  <body class="goto-here">
	<%@ include file="../inc/top.jsp"%>	
	   <div id="login">        
        <div class="container">
            <div id="login-row" class="row justify-content-center align-items-center">
                <div id="login-column" class="col-md-6">
                    <div id="login-box" class="col-md-12">
                        <form id="login-form" class="form">
                            <h3 class="text-center text-info">Login</h3>
                            <div class="form-group">
                                <label for="username" class="text-info">Username:</label><br>
                                <input type="text" name=m_id id="m_id"   class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="password" class="text-info">Password:</label><br>
                                <input type="password" name="m_pass" id="m_pass" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="remember-me" class="text-info"><span>Remember me</span> <span><input id="remember" name="remember" type="checkbox" required></span></label><br>
                                <input type="button" class="btn btn-info btn-md" onclick="login()" value="Login">                                                               
                                <input type="button" class="btn btn-info btn-md" onclick="javascript:location.href='/shop/find/findidform'" value="아이디 찾기">
                                <input type="button" id="findpass" class="btn btn-info btn-md" onclick="javascript:location.href='/shop/find/findpassform'" value="비밀번호 찾기">                                
                            </div>
                            <div id="register-link" class="text-right">
                                <a href="/shop/member/signup" class="text-info">Register here</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
		<section class="ftco-section ftco-partner">
    	<div class="container" id="findID">
    		<h2><%=str %></h2>
    	</div>
    </section>

		<section class="ftco-section ftco-no-pt ftco-no-pb py-5 bg-light">
      <div class="container py-4">
        <div class="row d-flex justify-content-center py-5">
          <div class="col-md-6">
          	<h2 style="font-size: 22px;" class="mb-0">Subcribe to our Newsletter</h2>
          	<span>Get e-mail updates about our latest shops and special offers</span>
          </div>
          <div class="col-md-6 d-flex align-items-center">
            <form action="#" class="subscribe-form">
              <div class="form-group d-flex">
                <input type="text" class="form-control" placeholder="Enter email address">
                <input type="submit" value="Subscribe" class="submit px-3">
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>

	

	<!-- footer -->
  	<%@ include file="../inc/footer.jsp" %>
    
  </body>
</html>