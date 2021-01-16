<%@page import="com.gumzima.shopping.common.Formatter"%>
<%@page import="java.util.List"%>

<%@page import="com.gumzima.shopping.model.domain.Cart"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
List<Cart> cartList = (List)request.getAttribute("cartList");
int discount = 1000;
int delivery = 3000;
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Vegefoods - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <!-- include haeader -->
    <%@ include file="../inc/header.jsp" %>
    <script type="text/javascript">
   
    
    
    
		  function delCart(){
				if(confirm("장바구니를 모두 비우시겠습니까?")){
					$.ajax({
						url:"/shop/cart/del",
						type:"get",
						success : function(messageData) {
							alert(messageData.msg);
							location.href=messageData.url;
						}
					});
				}
			}
			
			function editCart(){
				if(confirm("주문 수량을 변경하시겠어요?")){
					$("#cart-form").attr({
						action:"/shop/cart/edit",
						method:"post"
					});
					$("#cart-form").submit();
				}	
				
			}
			
			function checkoutForm(){
				location.href="/shop/payment/form";	
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
          	<p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home</a></span> <span>Cart</span></p>
            <h1 class="mb-0 bread">My Cart</h1>
          </div>
        </div>
      </div>
    </div>

    <section class="ftco-section ftco-cart">
			<div class="container">
				<div class="row">
    			<div class="col-md-12 ftco-animate">
    				<div class="cart-list">
	    				<table class="table">
						    <thead class="thead-primary">
						      <tr class="text-center">
						        <th>&nbsp;</th>
						        <th>&nbsp;</th>
						        <th>Product name</th>
						        <th>Price</th>
						        <th>Quantity</th>
						        <th>Total</th>
						      </tr>
						    </thead>
						    <tbody>
						    	<form id="cart-form">
							    	<%int sum=0; //합계 %>
	                  <%for(Cart cart : cartList){ %>
							      <tr class="text-center">
							      <td><a href="#"><span></span></td>
							        <td class="image-prod"><div class="img" style="background-image:url(/resources/data/basic/<%=cart.getProduct_id() %>.<%=cart.getFilename()%>);"></div></td>
							        <td class="product-name">
							        	<h6><%=cart.getP_subcategory().getName()%></h6>
							        	<h3><%=cart.getProduct_name() %></h3>
							        	<p><%=cart.getDetail() %></p>
							        </td>					        
							        <td class="price"><%=Formatter.getCurrency(cart.getPrice())%></td>					        
							        <td class="quantity">
							        	<div class="input-group mb-3">
							        		<input type="hidden" name="cart_id" value="<%=cart.getCart_id() %>">
						             	<input type="text" name="quantity" class="quantity form-control input-number" value="<%=cart.getQuantity()%>" min="1" max="100">
						          	</div>
						          </td>
						          <%sum = sum + (cart.getPrice()*cart.getQuantity());%>				        
							        <td class="total"><%=Formatter.getCurrency(cart.getPrice()*cart.getQuantity()) %></td>
							      </tr><!-- END TR-->
							      <%} %>
							     </form>					        
						    </tbody>
						  </table>
					  </div>
    			</div>
    		</div>
    		<div class="row justify-content-end">
    			<div class="col-lg-4 mt-5 cart-wrap ftco-animate">
    				<div class="cart-total mb-3">
    					<h3>Clear cart</h3>
    					<p>You can clear or update your cart by clicking these buttons</p>
    					<p><a href="javascript:editCart()" class="btn btn-primary py-3 px-4">Update cart</a></p>
    				<p><a href="javascript:delCart()" class="btn btn-primary py-3 px-4">Clear cart</a></p>
    				</div>
    			</div>
    			<div class="col-lg-4 mt-5 cart-wrap ftco-animate">
    				<div class="cart-total mb-3">
    					<h3>Coupon Code</h3>
    					<p>Enter your coupon code if you have one</p>
  						<form action="#" class="info">
	              <div class="form-group">
	              	<label for="">Coupon code</label>
	                <input type="text" class="form-control text-left px-3" placeholder="">
	              </div>
	            </form>
    				</div>
    				<p><a href="checkout.html" class="btn btn-primary py-3 px-4">Apply Coupon</a></p>
    			</div>
    			<div class="col-lg-4 mt-5 cart-wrap ftco-animate">
    				<div class="cart-total mb-3">
    					<h3>Cart Totals</h3>
    					<p class="d-flex">
    						<span>Subtotal</span>
    						<span><%=Formatter.getCurrency(sum) %></span>
    					</p>
    					<p class="d-flex">
    						<span>Delivery</span>
    						<span><%=Formatter.getCurrency(delivery) %></span>
    					</p>
    					<p class="d-flex">
    						<span>Discount</span>
    						<span><%=Formatter.getCurrency(discount)%></span>
    					</p>
    					<hr>
    					<p class="d-flex total-price">
    						<span>Total</span>
    						<span><%=Formatter.getCurrency(sum) %></span>
    					</p>
    				</div>
    				<p><a href="javascript:checkoutForm()" class="btn btn-primary py-3 px-4">Proceed to Checkout</a></p>
    			</div>
    		</div>
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