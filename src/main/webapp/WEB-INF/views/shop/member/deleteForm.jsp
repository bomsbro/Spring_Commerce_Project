<%@page import="com.gumzima.shopping.model.domain.Member"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	Member member = (Member)session.getAttribute("member");
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
	$(function(){
		$("#drop").on("click",function(){
			//alert("?");
			 if($("#m_pass").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("#m_pass").focus();
				return false;
			}else{
				$("#delete-form").attr({
					action:"/shop/member/delete_Form",
					method:"post"
				});
				$("#delete-form").submit();			
			} 		
		});		
	});

</script>		
  </head>
  <body class="goto-here">
	<%@ include file="../inc/top.jsp"%>	
	   <div id="login">        
        <div class="container">
            <div id="login-row" class="row justify-content-center align-items-center">
                <div id="login-column" class="col-md-6">
                    <div id="login-box" class="col-md-12">
                        <form id="delete-form" method="post" class="form">
                            <h3 class="text-center text-info">Secession</h3>
                            <div class="form-group">
                                <label >UserId:</label><br>
                                <%=member.getM_id() %><input type="hidden" name="m_id" value="<%=member.getM_id()%>">
                            </div>
                            <div class="form-group">
                                <label for="password" class="text-info">Password:</label><br>
                                <input type="password" name="m_pass" id="m_pass" class="form-control">
                            </div>
                            <div class="form-group">                                                            
                                <input type="button" id="drop" class="btn btn-info btn-md"  value="탈퇴하기">                                
                                <input type="button" id="findpass" class="btn btn-info btn-md" onclick="javascript:history.back()" value="뒤로가기">                                
                            </div>
                            <div id="register-link" class="text-right">                                
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
		<section class="ftco-section ftco-partner">
    	<div class="container">
    		
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