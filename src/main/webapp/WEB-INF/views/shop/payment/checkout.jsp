<%@page import="com.gumzima.shopping.common.Formatter"%>
<%@page import="com.gumzima.shopping.model.domain.Paymethod"%>
<%@page import="com.gumzima.shopping.model.domain.Member"%>
<%@page import="java.util.List"%>

<%@page import="com.gumzima.shopping.model.domain.Cart"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	List<Cart> cartList = (List)request.getAttribute("cartList");
	List<Paymethod> paymethodList = (List)request.getAttribute("paymethodList");
	Member member=(Member)session.getAttribute("member");

	
	
	//장바구니로부터, 상품 가액 계산
	int order_price=0;
	int delivery_price=3000;
	int discount_price=1000;
	int total_price=0;
	
	for(Cart cart : cartList){
		order_price += (cart.getQuantity() * cart.getPrice());
	}
	
	total_price=order_price+delivery_price-discount_price-total_price;
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Vegefoods - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <!-- include haeader -->
    <%@ include file="../inc/header.jsp" %>
   
   	<script>
		function setData(ch){
			var form=document.querySelector("#checkout-form");
			
			if(ch.checked){//체크를 했다면, 주문자 정보를 받는자 정보에 대입
				form.receiver_name.value=form.m_name.value;
				form.receiver_cellphone.value=form.m_phone.value;
				form.receiver_postcode.value=form.m_postcode.value;
				form.receiver_address1.value=form.m_address1.value;
				form.receiver_address2.value=form.m_address2.value;
			}else{
				//받는 사람 정보를 다시 원상 복구(초기화)
				form.receiver_name.value="";
				form.receiver_phone.value="";	
				form.receiver_postcode.value="";
				form.receiver_address1.value="";
				form.receiver_address2.value="";
			}
		}
		
		function order(){
			$("#checkout-form").attr({
				action:"/shop/payment/regist",
				method:"post"
			});
			$("#checkout-form").submit();
		}
		</script>
  </head>
  <body class="goto-here">
  
	  <!-- top -->
		<%@ include file="../inc/top.jsp"%>

        <div class="hero-wrap hero-bread" style="background-image: url('/resources/images/bg_1.jpg');">
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
          	<p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home</a></span> <span>Checkout</span></p>
            <h1 class="mb-0 bread">Checkout</h1>
          </div>
        </div>
      </div>
    </div>

    <section class="ftco-section">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-xl-7 ftco-animate">
						<form id="checkout-form" action="#" class="billing-form">
							<input type="hidden" name="order_price" value="<%=order_price%>">
              <input type="hidden" name="delivery_price" value="<%=delivery_price%>">
              <input type="hidden" name="discount_price" value="<%=discount_price%>">
							<input type="hidden" name="total_price" value="<%=total_price%>">
							
							<h3 class="mb-4 billing-heading">주문하기</h3>
	          	<div class="row align-items-end">
	        
	          		<div class="col-md-6">
	                <div class="form-group">
	                	<label for="m_name">주문자명</label>
	               		<input id="m_name" value="<%=member.getM_name()%>" type="text" class="form-control" placeholder="">	
	                </div>
	              </div>
                <div class="w-100"></div>
                
                 <div class="col-md-6">
	                <div class="form-group">
	                	<label for="m_phone">연락처</label>
	                  <input id="m_phone" value="<%=member.getM_phone()%>" type="text" class="form-control" placeholder="">
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="form-group">
	                	<label for="m_email">이메일주소</label>
	                  <input id="m_mail" value="<%=member.getM_email()+"@"+member.getM_email_server()%>" type="text" class="form-control" placeholder="">
	                </div>
                </div>                        
                <div class="w-100"></div>
                
                      
                <div class="col-md-6">
		            	<div class="form-group">
		            		<label for="m_postcode">우편번호</label>
	                  <input id="m_postcode" value="<%=member.getM_addr1()%>" type="text" class="form-control" placeholder="">
	                </div>
		            </div>
		            <div class="w-100"></div>       
		            
		            <div class="col-md-6">
	                <div class="form-group">
	                	<label for="m_address1">주소1</label>
	                  <input id="m_address1" value="<%=member.getM_addr2()%>" type="text" class="form-control" placeholder="">
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="form-group">
	                	<label for="m_address2">주소2</label>
	                  <input id="m_address2" value="<%=member.getM_addr3()%>" type="text" class="form-control" placeholder="">
	                </div>
                </div>
                <div class="w-100"></div>
                
                <div class="col-12 mb-3">
	                <div class="custom-control custom-checkbox d-block mb-2">
	                        <input type="checkbox" class="custom-control-input" id="customCheck1" onClick="setData(this)">
	                        <label class="custom-control-label" for="customCheck1">주문자와 동일</label>
	                </div>
                </div>
                
                <div class="w-100"></div>
		            
		            <div class="col-md-6">
	                <div class="form-group">
	                	<label for="receiver_name">수취인명</label>
	                  <input name="receiver_name" value="" type="text" class="form-control" placeholder="">
	                </div>
	              </div>
	              
	              <div class="col-md-6">
	                <div class="form-group">
	                	<label for="receiver_cellphone">수취인 연락처</label>
	                  <input name="receiver_cellphone" value="" type="text" class="form-control" placeholder="">
	                </div>
                </div>                        
                <div class="w-100"></div>
                 
                <div class="col-md-6">
		            	<div class="form-group">
		            		<label for="receiver_postcode">우편번호</label>
	                  <input name="receiver_postcode" value="" type="text" class="form-control" placeholder="">
	                </div>
		            </div>
		            <div class="w-100"></div>       
		            
		             <div class="col-md-6">
	                <div class="form-group">
	                	<label for="receiver_address1">주소1</label>
	                  <input name="receiver_address1" value=""  type="text" class="form-control" placeholder="">
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="form-group">
	                	<label for="receiver_address2">주소2</label>
	                  <input name="receiver_address2" value="" type="text" class="form-control" placeholder="">
	                </div>
                </div>
                <div class="w-100"></div>
		            
		            <div class="col-md-12">
	                <div class="form-group">
	                	<label for="receiver_request">배송 요청사항</label>
	                  <input name="receiver_request" value="" type="text" class="form-control" placeholder="">
	                </div>
                </div>
		            
		             <div class="w-100"></div>
		            
		             <div class="col-md-6">
		            	<div class="form-group">
		            		<label for="country">결제방법</label>
		            		<div class="select-wrap">
		                  <div class="icon"><span class="ion-ios-arrow-down"></span></div>
		                  <select name="paymethod_id" class="form-control">
		                  <%for(Paymethod paymethod : paymethodList){ %>
		                  	<option value="<%=paymethod.getPaymethod_id()%>"><%=paymethod.getPaymethod_name()%></option>
		                  <%} %>	              
		                  </select>
		                </div>
		            	</div>
		            </div>
		            <div class="col-md-6">
	                <div class="form-group">
	                	<label for="money_sender">입금자명</label>
	                  <input name="money_sender" value="<%=member.getM_name()%>" type="text" class="form-control" placeholder="">
	                </div>
                </div>
		            
		                  
		            <div class="w-100"></div>             
	            </div>
	            
	          </form><!-- END -->
					</div>
					<div class="col-xl-5">
	          <div class="row mt-5 pt-3">
	          	<div class="col-md-12 d-flex mb-5">
	          		<div class="cart-detail cart-total p-3 p-md-4">
	          			<h3 class="billing-heading mb-4">Cart Total</h3>
	          			<p class="d-flex">
		    						<span>Subtotal</span>
		    						<span><%=Formatter.getCurrency(order_price)%></span>
		    					</p>
		    					<p class="d-flex">
		    						<span>Delivery</span>
		    						<span><%=Formatter.getCurrency(delivery_price)%></span>
		    					</p>
		    					<p class="d-flex">
		    						<span>Discount</span>
		    						<span><%=Formatter.getCurrency(discount_price)%></span>
		    					</p>
		    					<hr>
		    					<p class="d-flex total-price">
		    						<span>Total</span>
		    						<span><%=Formatter.getCurrency(total_price)%></span>
		    					</p>
								</div>
	          	</div>
	          	<div class="col-md-12">
	          		<div class="cart-detail p-3 p-md-4">
	          			<h3 class="billing-heading mb-4">Proceed</h3>
									<p><a href="javascript:order()"class="btn btn-primary py-3 px-4">Place an order</a></p>
								</div>
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
  
		<!-- footer -->
  	<%@ include file="../inc/footer.jsp" %>
    
  </body>
</html>