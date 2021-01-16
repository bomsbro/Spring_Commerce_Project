
<%@page import="com.gumzima.shopping.common.Formatter"%>
<%@page import="com.gumzima.shopping.model.domain.Orders"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
List<Orders> ordersList =(List)request.getAttribute("OrdersList");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Vegefoods - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   
    <!-- include haeader -->
    <%@ include file="../inc/header.jsp" %>
    
   	<style>
   	
   	body{
    margin-top:20px;
    background:#eee;
		}
		/* My Account */
		.payments-item img.mr-3 {
		    width: 47px;
		}
		.order-list .btn {
		    border-radius: 2px;
		    min-width: 121px;
		    font-size: 13px;
		    padding: 7px 0 7px 0;
		}
		.osahan-account-page-left .nav-link {
		    padding: 18px 20px;
		    border: none;
		    font-weight: 600;
		    color: #535665;
		}
		.osahan-account-page-left .nav-link i {
		    width: 28px;
		    height: 28px;
		    background: #535665;
		    display: inline-block;
		    text-align: center;
		    line-height: 29px;
		    font-size: 15px;
		    border-radius: 50px;
		    margin: 0 7px 0 0px;
		    color: #fff;
		}
		.osahan-account-page-left .nav-link.active {
		    background: #f3f7f8;
		    color: #282c3f !important;
		}
		.osahan-account-page-left .nav-link.active i {
		    background: #282c3f !important;
		}
		.osahan-user-media img {
		    width: 90px;
		}
		.card offer-card h5.card-title {
		    border: 2px dotted #000;
		}
		.card.offer-card h5 {
		    border: 1px dotted #daceb7;
		    display: inline-table;
		    color: #17a2b8;
		    margin: 0 0 19px 0;
		    font-size: 15px;
		    padding: 6px 10px 6px 6px;
		    border-radius: 2px;
		    background: #fffae6;
		    position: relative;
		}
		.card.offer-card h5 img {
		    height: 22px;
		    object-fit: cover;
		    width: 22px;
		    margin: 0 8px 0 0;
		    border-radius: 2px;
		}
		.card.offer-card h5:after {
		    border-left: 4px solid transparent;
		    border-right: 4px solid transparent;
		    border-bottom: 4px solid #daceb7;
		    content: "";
		    left: 30px;
		    position: absolute;
		    bottom: 0;
		}
		.card.offer-card h5:before {
		    border-left: 4px solid transparent;
		    border-right: 4px solid transparent;
		    border-top: 4px solid #daceb7;
		    content: "";
		    left: 30px;
		    position: absolute;
		    top: 0;
		}
		.payments-item .media {
		    align-items: center;
		}
		.payments-item .media img {
		    margin: 0 40px 0 11px !important;
		}
		.reviews-members .media .mr-3 {
		    width: 56px;
		    height: 56px;
		    object-fit: cover;
		}
		.order-list img.mr-4 {
		    width: 70px;
		    height: 70px;
		    object-fit: cover;
		    box-shadow: 0 .125rem .25rem rgba(0, 0, 0, .075)!important;
		    border-radius: 2px;
		}
		.osahan-cart-item p.text-gray.float-right {
		    margin: 3px 0 0 0;
		    font-size: 12px;
		}
		.osahan-cart-item .food-item {
		    vertical-align: bottom;
		}
		
		.h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
		    color: #000000;
		}
		
		.shadow-sm {
		    box-shadow: 0 .125rem .25rem rgba(0,0,0,.075)!important;
		}
		
		.rounded-pill {
		    border-radius: 50rem!important;
		}
		a:hover{
		    text-decoration:none;
		}
	</style>
	
  </head>
  <body class="goto-here">
  	
	  <!-- top -->
		<%@ include file="../inc/top.jsp"%>

		<div class="container">
		    <div class="row">

		        <div class="col-md-9 mx-auto">
		            <div class="osahan-account-page-right shadow-sm bg-white p-4 h-100">
		                <div class="tab-content" id="myTabContent">
		                    <div class="tab-pane  fade  active show" id="orders" role="tabpanel" aria-labelledby="orders-tab">
		                        <h4 class="font-weight-bold mt-0 mb-4">주문내역</h4>
		                      	 <%for(Orders orders:ordersList){%>
		                        <div class="bg-white card mb-4 order-list shadow-sm">
		                            <div class="gold-members p-4">
		                                <a href="#">
		                                </a>
		                                <div class="media">
		                                    <div class="media-body">
		                                        <a href="#">
		                                            <span class="float-right text-info">배송날짜: <%=orders.getShipment_date()%><i class="icofont-check-circled text-success"></i></span>
		                                        </a>
		                                        <h6 class="mb-2">
		                                            <a href="#"></a>
		                                            <a href="#" class="text-black">주문번호: <%=orders.getOrders_id()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;주문날짜: <%=orders.getOrder_date() %></a>
		                                        </h6>
		                                        <hr>
		                                        <p class="text-gray mb-1"><i class="icofont-location-arrow"></i> 수취인: <%=orders.getReceiver_name() %>
		                                        </p>
		                                        <p class="text-gray mb-1"><i class="icofont-location-arrow"></i> 주소: <%=orders.getReceiver_address1() %> <%=orders.getReceiver_address2() %>
		                                        </p>
		                                        <br>
		                                        <div class="float-right">
		                                            <a class="btn btn-sm btn-primary" href="/shop/mypage/orderhistory/detail?orders_id=<%=orders.getOrders_id()%>"><i class="icofont-refresh"></i> 주문 상세보기</a>
		                                        </div>
		                                        <p class="mb-0 text-black text-primary pt-2"><span class="text-black font-weight-bold"> 총 금액: <%=Formatter.getCurrency(orders.getTotal_price())%></span> 
		                                        </p>
		                                    </div>
		                                </div>
		
		                            </div>
		                        </div>
		                       <%} %>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
     
  
		<!-- footer -->
  	<%@ include file="../inc/footer.jsp" %>
    
  </body>
</html>