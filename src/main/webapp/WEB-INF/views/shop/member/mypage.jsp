<%@page import="com.gumzima.shopping.model.domain.Member"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	Member member = (Member)request.getAttribute("member");
%>
<!DOCTYPE html>
<html>
  <head>
    <title>Vegefoods - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <%@ include file="../inc/header.jsp" %>  
 <script type="text/javascript">
	function myPageEdit() {
		if(confirm("수정 하시겠습니까?")){
			var form = document.querySelector("form");
			form.action="/shop/member/myPage_Edit";
			form.method="post";
			form.submit();
		}
	}
	
	function myPageDel() {
		if(confirm("탈퇴 하시겠습니까?")){
			$("#member_form").attr({
				action:"/shop/member/myPage_Del",
				method:"post"
			})
			$("#member_form").submit();			
		}
	}
  </script>
  </head>
  <body class="goto-here">
	<%@ include file="../inc/top.jsp" %>
	
    <section class="ftco-section">
      <div class="container">      
        <div class="row justify-content-center">
          <div class="col-xl-7 ftco-animate">
			<form id="member_form" class="billing-form">
				<input type="hidden" name="member_id" value="<%=member.getMember_id()%>">
				<h3 class="mb-4 billing-heading">Join</h3>
	          	<div class="row align-items-end">
	          		<div class="col-md-6">
	                <div class="form-group">
	                	<label>UserID</label>
	                  <%=member.getM_id() %><input type="hidden" name="m_id" value="<%=member.getM_id()%>">            
	                </div>
	              </div>
	           
                <div class="w-100"></div>
                <div class="col-md-6">
	                <div class="form-group">
	                	<label>Name</label>
	                  <%=member.getM_name() %>
	                </div>
                </div>
                <div class="w-100"></div>
                <div class="col-md-6">
	                <div class="form-group">
	                	<label for="email">Email</label>
	                  <input type="text" id="m_email" name="m_email" value="<%=member.getM_email() %>" class="form-control" placeholder="">
	                </div>
                </div>
		            <div class="col-md-12">
		            	<div class="form-group">
		            		<label for="emailserver">emailServer</label>
		            		<div class="select-wrap">
		                  <div class="icon"><span class="ion-ios-arrow-down"></span></div>
		                  <select name="m_email_server" value="<%=member.getM_email_server() %>" id="m_email_server" class="form-control">
		                  	<option value="gmail.com">gmail.com</option>
		                    <option value="naver.com">naver.com</option>
		                    <option value="daum.net">daum.net</option>
		                  </select>
		                </div>
		            	</div>
		            </div>
		            <div class="w-100"></div>
		            <div class="col-md-6">
	                <div class="form-group">
	                	<label for="phone">Phone</label>
	                  <input type="text" id="m_phone" name="m_phone" value="<%=member.getM_phone() %>" class="form-control" placeholder="(-)를 제외하고 입력바랍니다.">
	                </div>
	              </div>
		            <div class="w-100"></div>
		            <div class="col-md-6">
		            	<div class="form-group">
	                	<label for="address">Address</label>
	                  <input type="text" id="m_addr1" name="m_addr1" value="<%=member.getM_addr1() %>" class="form-control" placeholder="기본주소">
	                  <input type="button" onclick="goPopup();" value="찾기" >
	                </div>
		            </div>
		            <div class="col-md-6">
		            	<div class="form-group">
	                  <input type="text" id="m_addr2" name="m_addr2" value="<%=member.getM_addr2() %>" class="form-control" placeholder="상세주소">
	                </div>
		            </div>
	            </div>
	          </form><!-- END -->
					</div>
					<div class="col-xl-5">
	          <div class="row mt-5 pt-3">
	          	<div class="col-md-12">
	          		<input type="button" onclick="myPageEdit()" id="myPage_Edit" value="수정하기" class="form-control" >	          		
	          		<input type="button" onclick="myPageDel()" id="myPage_Del" value="탈퇴하기" class="form-control" >	          		
	          	</div>
	          </div>
          </div> <!-- .col-md-8 -->
        </div>
      </div>
    </section> <!-- .section -->

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
    <%@ include file="../inc/footer.jsp" %>    
  </body>
</html>