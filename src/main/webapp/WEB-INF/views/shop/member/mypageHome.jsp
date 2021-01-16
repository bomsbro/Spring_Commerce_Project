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
  <script type="text/javascript">

  </script>
  </head>
  <body class="goto-here">
	<%@ include file="../inc/top.jsp" %>
	
    <section class="ftco-section">
      <div class="container">      
        <div class="row justify-content-center">
          <div class="col-xl-7 ftco-animate">
			<form id="member_form" class="billing-form">
							<h3 class="mb-4 billing-heading">Join</h3>
	          	<div class="row align-items-end">	          		
					<div class="col-xl-5">
	          <div class="row mt-5 pt-3">
	          	<div class="col-md-12">
	          		<input type="button" method="get" onclick="javascript:location.href='/shop/member/myPageEdit?member_id=<%=member.getMember_id() %>'" id="myPageEdit" value="회원정보수정" class="form-control" >	          		    		       		
	          		<input type="button" id="" value="주문조회" class="form-control" >	          		    		       		
	          		        		    		       		
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